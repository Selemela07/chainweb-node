{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NumericUnderscores #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ViewPatterns #-}

-- |
-- Module: Chainweb.Pact.Backend.RelationalCheckpointer
-- Copyright: Copyright © 2018 - 2020 Kadena LLC.
-- License: See LICENSE file
-- Maintainers: Emmanuel Denloye <emmanuel@kadena.io>
-- Stability: experimental
--
-- Pact Checkpointer for Chainweb
module Chainweb.Pact.Backend.RelationalCheckpointer
  ( initRelationalCheckpointer
  , initRelationalCheckpointer'
  , withProdRelationalCheckpointer
  ) where

import Control.Concurrent (threadDelay)
import Control.Concurrent.Async
import Control.Concurrent.MVar
import Control.Monad
import Control.Monad.Catch
import Control.Monad.IO.Class

import Data.ByteString (intercalate)
import qualified Data.ByteString.Short as BS
import Data.Foldable (foldl')
import Data.Int
import Data.Coerce
import qualified Data.Map.Strict as M
import Data.Maybe
import qualified Data.HashMap.Strict as HashMap
import qualified Data.Set as S
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Vector as V
import GHC.Stack (HasCallStack)

import Database.SQLite3.Direct

import Prelude hiding (log)
import Streaming
import qualified Streaming.Prelude as Streaming

import System.LogLevel

-- pact

import Pact.Interpreter (PactDbEnv(..))
import Pact.Types.Hash (PactHash, TypedHash(..))
import Pact.Types.Persistence
import Pact.Types.RowData
import Pact.Types.SQLite
import Pact.Types.Util (AsString(..))

import qualified Pact.Core.Persistence as PCore

-- chainweb
import Chainweb.BlockHash
import Chainweb.BlockHeader
import Chainweb.BlockHeight
import Chainweb.Logger
import qualified Chainweb.Pact.Backend.ChainwebPactDb as PactDb
import qualified Chainweb.Pact.Backend.ChainwebPactCoreDb as PCore
import Chainweb.Pact.Backend.Types
import Chainweb.Pact.Backend.Utils
import Chainweb.Pact.Backend.DbCache
import Chainweb.Pact.Service.Types
import Chainweb.Pact.Types (defaultModuleCacheLimit)
import Chainweb.Utils
import Chainweb.Utils.Serialization
import Chainweb.Version

initRelationalCheckpointer
    :: (Logger logger)
    => DbCacheLimitBytes
    -> SQLiteEnv
    -> IntraBlockPersistence
    -> logger
    -> ChainwebVersion
    -> ChainId
    -> IO (Checkpointer logger)
initRelationalCheckpointer dbCacheLimit sqlenv p loggr v cid =
    snd <$!> initRelationalCheckpointer' dbCacheLimit sqlenv p loggr v cid

withProdRelationalCheckpointer
    :: (Logger logger)
    => logger
    -> DbCacheLimitBytes
    -> SQLiteEnv
    -> IntraBlockPersistence
    -> ChainwebVersion
    -> ChainId
    -> (Checkpointer logger -> IO a)
    -> IO a
withProdRelationalCheckpointer logger dbCacheLimit sqlenv p v cid inner = do
    (moduleCacheVar, cp) <- initRelationalCheckpointer' dbCacheLimit sqlenv p logger v cid
    withAsync (logModuleCacheStats moduleCacheVar) $ \_ -> inner cp
  where
    logFun = logFunctionText logger
    logModuleCacheStats e = runForever logFun "ModuleCacheStats" $ do
        stats <- modifyMVar e $ \db -> do
            let (s, !mc') = updateCacheStats db
            return (mc', s)
        logFunctionJson logger Info stats
        threadDelay 60_000_000 {- 1 minute -}

-- for testing
initRelationalCheckpointer'
    :: (Logger logger)
    => DbCacheLimitBytes
    -> SQLiteEnv
    -> IntraBlockPersistence
    -> logger
    -> ChainwebVersion
    -> ChainId
    -> IO (MVar (DbCache PersistModuleData), Checkpointer logger)
initRelationalCheckpointer' dbCacheLimit sqlenv p loggr v cid = do
    PactDb.initSchema loggr sqlenv
    moduleCacheVar <- newMVar (emptyDbCache dbCacheLimit)
    let
        checkpointer = Checkpointer
            { _cpRestoreAndSave = doRestoreAndSave loggr v cid sqlenv p moduleCacheVar
            , _cpReadCp = ReadCheckpointer
                { _cpReadFrom = doReadFrom loggr v cid sqlenv moduleCacheVar
                , _cpGetBlockHistory = doGetBlockHistory sqlenv
                , _cpGetHistoricalLookup = doGetHistoricalLookup sqlenv
                , _cpGetEarliestBlock = doGetEarliestBlock sqlenv
                , _cpGetLatestBlock = doGetLatestBlock sqlenv
                , _cpLookupBlockInCheckpointer = doLookupBlock sqlenv
                , _cpGetBlockParent = doGetBlockParent v cid sqlenv
                , _cpLogger = loggr
                }
            }
    return (moduleCacheVar, checkpointer)


-- see the docs for _cpReadFrom
doReadFrom
  :: (Logger logger)
  => logger
  -> ChainwebVersion
  -> ChainId
  -> SQLiteEnv
  -> MVar (DbCache PersistModuleData)
  -> Maybe ParentHeader
  -> (CurrentBlockDbEnv logger -> IO a)
  -> IO a
doReadFrom logger v cid sql moduleCacheVar parent doRead = do
  let currentHeight = maybe (genesisHeight v cid) (succ . _blockHeight . _parentHeader) parent

  withMVar moduleCacheVar $ \sharedModuleCache -> do
    bracket
      (beginSavepoint sql BatchSavepoint)
      (\_ -> abortSavepoint sql BatchSavepoint) $ \() -> do
      txid <- PactDb.getEndTxId "doReadFrom" sql parent
      newDbEnv <- newMVar $ BlockEnv
        (mkBlockHandlerEnv v cid currentHeight sql DoNotPersistIntraBlockWrites logger)
        (initBlockState defaultModuleCacheLimit txid)
          { _bsModuleCache = sharedModuleCache }
      -- NB it's important to do this *after* you start the savepoint (and thus
      -- the db transaction) to make sure that the latestHeader check is up to date.
      latestHeader <- doGetLatestBlock sql
      let
        -- is the parent the latest header, i.e., can we get away without rewinding?
        parentIsLatestHeader = case (latestHeader, parent) of
          (Nothing, Nothing) -> True
          (Just (_, latestHash), Just (ParentHeader ph)) ->
            _blockHash ph == latestHash
          _ -> False

      let
        pactDb
          | parentIsLatestHeader = PactDb.chainwebPactDb
          | otherwise = PactDb.rewoundPactDb currentHeight txid
        pactCoreDb
          | parentIsLatestHeader = PCore.chainwebPactCoreDb newDbEnv
          | otherwise = PCore.rewoundPactCoreDb newDbEnv currentHeight (coerce txid)
        curBlockDbEnv = CurrentBlockDbEnv
          { _cpPactDbEnv = PactDbEnv pactDb newDbEnv
          , _cpPactCoreDbEnv = pactCoreDb
          , _cpRegisterProcessedTx =
            \(TypedHash hash) -> runBlockEnv newDbEnv (PactDb.indexPactTransaction $ BS.fromShort hash)
          , _cpLookupProcessedTx = \hs ->
            runBlockEnv newDbEnv (doLookupSuccessful currentHeight hs)
          }
      doRead curBlockDbEnv


-- TODO: log more?
-- see the docs for _cpRestoreAndSave.
doRestoreAndSave
  :: forall logger r q.
  (Logger logger, Monoid q, HasCallStack)
  => logger
  -> ChainwebVersion
  -> ChainId
  -> SQLiteEnv
  -> IntraBlockPersistence
  -> MVar (DbCache PersistModuleData)
  -> Maybe ParentHeader
  -> Stream (Of (RunnableBlock logger q)) IO r
  -> IO (r, q)
doRestoreAndSave logger v cid sql p moduleCacheVar parent blocks =
    modifyMVar moduleCacheVar $ \moduleCache -> do
      fmap fst $ generalBracket
        (beginSavepoint sql BatchSavepoint)
        (\_ -> \case
          ExitCaseSuccess {} -> commitSavepoint sql BatchSavepoint
          _ -> abortSavepoint sql BatchSavepoint
        ) $ \_ -> do
          PactDb.rewindDbTo sql parent
          txid <- PactDb.getEndTxId "restoreAndSave" sql parent
          ((q, _, _, finalModuleCache) :> r) <- extend txid moduleCache
          return (finalModuleCache, (r, q))
  where

    extend
      :: TxId -> DbCache PersistModuleData
      -> IO (Of (q, Maybe ParentHeader, TxId, DbCache PersistModuleData) r)
    extend startTxId startModuleCache = Streaming.foldM
      (\(m, pc, txid, moduleCache) block -> do
        let
          !bh = maybe (genesisHeight v cid) (succ . _blockHeight . _parentHeader) pc

        -- prepare the block state
        let handlerEnv = mkBlockHandlerEnv v cid bh sql p logger
        let state = (initBlockState defaultModuleCacheLimit txid) { _bsModuleCache = moduleCache }
        dbMVar <- newMVar BlockEnv
          { _blockHandlerEnv = handlerEnv
          , _benvBlockState = state
          }

        let curBlockDbEnv = CurrentBlockDbEnv
              { _cpPactDbEnv = PactDbEnv PactDb.chainwebPactDb dbMVar
              , _cpPactCoreDbEnv = PCore.chainwebPactCoreDb dbMVar
              , _cpRegisterProcessedTx =
                \(TypedHash hash) -> runBlockEnv dbMVar (PactDb.indexPactTransaction $ BS.fromShort hash)
              , _cpLookupProcessedTx = \hs -> runBlockEnv dbMVar $ doLookupSuccessful bh hs
              }
        -- execute the block
        (m', newBh) <- runBlock block curBlockDbEnv pc
        -- grab any resulting state that we're interested in keeping
        nextState <- _benvBlockState <$> takeMVar dbMVar
        let !nextTxId = _bsTxId nextState
        let !nextModuleCache = _bsModuleCache nextState
        -- compute the accumulator early
        let !m'' = m <> m'
        -- check that the new parent header has the right height for a child
        -- of the previous block
        case pc of
          Nothing
            | genesisHeight v cid /= _blockHeight newBh -> throwM $ PactInternalError
              "doRestoreAndSave: block with no parent, genesis block, should have genesis height but doesn't,"
          Just (ParentHeader ph)
            | succ (_blockHeight ph) /= _blockHeight newBh -> throwM $ PactInternalError $
              "doRestoreAndSave: non-genesis block should be one higher than its parent. parent at "
                <> sshow (_blockHeight ph) <> ", child height " <> sshow (_blockHeight newBh)
          _ -> return ()
        -- persist any changes to the database
        PactDb.commitBlockStateToDatabase sql (_blockHash newBh) (_blockHeight newBh) nextState
        return (m'', Just (ParentHeader newBh), nextTxId, nextModuleCache)
      )
      (return (mempty, parent, startTxId, startModuleCache))
      return
      blocks

doGetEarliestBlock :: HasCallStack => SQLiteEnv -> IO (Maybe (BlockHeight, BlockHash))
doGetEarliestBlock db = do
  r <- qry_ db qtext [RInt, RBlob] >>= mapM go
  case r of
    [] -> return Nothing
    (!o:_) -> return (Just o)
  where
    qtext = "SELECT blockheight, hash FROM BlockHistory \
            \ ORDER BY blockheight ASC LIMIT 1"

    go [SInt hgt, SBlob blob] =
        let hash = either error id $ runGetEitherS decodeBlockHash blob
        in return (fromIntegral hgt, hash)
    go _ = fail "Chainweb.Pact.Backend.RelationalCheckpointer.doGetEarliest: impossible. This is a bug in chainweb-node."

doGetLatestBlock :: HasCallStack => SQLiteEnv -> IO (Maybe (BlockHeight, BlockHash))
doGetLatestBlock db = do
  r <- qry_ db qtext [RInt, RBlob] >>= mapM go
  case r of
    [] -> return Nothing
    (!o:_) -> return (Just o)
  where
    qtext = "SELECT blockheight, hash FROM BlockHistory \
            \ ORDER BY blockheight DESC LIMIT 1"

    go [SInt hgt, SBlob blob] =
        let hash = either error id $ runGetEitherS decodeBlockHash blob
        in return (fromIntegral hgt, hash)
    go _ = fail "Chainweb.Pact.Backend.RelationalCheckpointer.doGetLatest: impossible. This is a bug in chainweb-node."

doLookupBlock :: SQLiteEnv -> (BlockHeight, BlockHash) -> IO Bool
doLookupBlock db (bheight, bhash) = do
    r <- qry db qtext [SInt $ fromIntegral bheight, SBlob (runPutS (encodeBlockHash bhash))]
                      [RInt]
    liftIO (expectSingle "row" r) >>= \case
        [SInt n] -> return $! n == 1
        _ -> internalError "doLookupBlock: output type mismatch"
  where
    qtext = "SELECT COUNT(*) FROM BlockHistory WHERE blockheight = ? \
            \ AND hash = ?;"

doGetBlockParent :: ChainwebVersion -> ChainId -> SQLiteEnv -> (BlockHeight, BlockHash) -> IO (Maybe BlockHash)
doGetBlockParent v cid db (bh, hash)
    | bh == genesisHeight v cid = return Nothing
    | otherwise = do
        blockFound <- doLookupBlock db (bh, hash)
        if not blockFound
          then return Nothing
          else do
            r <- qry db qtext [SInt (fromIntegral (pred bh))] [RBlob]
            case r of
              [[SBlob blob]] ->
                either (internalError . T.pack) (return . return) $! runGetEitherS decodeBlockHash blob
              [] -> internalError "doGetBlockParent: block was found but its parent couldn't be found"
              _ -> error "doGetBlockParent: output type mismatch"
  where
    qtext = "SELECT hash FROM BlockHistory WHERE blockheight = ?"


doLookupSuccessful :: BlockHeight -> V.Vector PactHash -> BlockHandler logger (HashMap.HashMap PactHash (T2 BlockHeight BlockHash))
doLookupSuccessful curHeight hashes = do
  fmap buildResultMap $ -- swizzle results of query into a HashMap
    callDb "doLookupSuccessful" $ \db -> do
      let
        hss = V.toList hashes
        params = Utf8 $ intercalate "," (map (const "?") hss)
        qtext = "SELECT blockheight, hash, txhash FROM \
                \TransactionIndex INNER JOIN BlockHistory \
                \USING (blockheight) WHERE txhash IN (" <> params <> ")"
                <> " AND blockheight <= ?;"
        qvals
          -- match query params above. first, hashes
          = map (\(TypedHash h) -> SBlob $ BS.fromShort h) hss
          -- then, the block height; we don't want to see txs from the
          -- current block in the db, because they'd show up in pending data
          ++ [SInt $ fromIntegral (pred curHeight)]

      qry db qtext qvals [RInt, RBlob, RBlob] >>= mapM go
  where
    -- NOTE: it's useful to keep the types of 'go' and 'buildResultMap' in sync
    -- for readability but also to ensure the compiler and reader infer the
    -- right result types from the db query.

    buildResultMap :: [T3 PactHash BlockHeight BlockHash] -> HashMap.HashMap PactHash (T2 BlockHeight BlockHash)
    buildResultMap xs = HashMap.fromList $
      map (\(T3 txhash blockheight blockhash) -> (txhash, T2 blockheight blockhash)) xs

    go :: [SType] -> IO (T3 PactHash BlockHeight BlockHash)
    go (SInt blockheight:SBlob blockhash:SBlob txhash:_) = do
        !blockhash' <- either fail return $ runGetEitherS decodeBlockHash blockhash
        let !txhash' = TypedHash $ BS.toShort txhash
        return $! T3 txhash' (fromIntegral blockheight) blockhash'
    go _ = fail "impossible"

doGetBlockHistory :: SQLiteEnv -> BlockHeader -> Domain RowKey RowData -> IO BlockTxHistory
doGetBlockHistory db blockHeader d = do
  endTxId <- fmap fromIntegral $
    PactDb.getEndTxId "doGetBlockHistory" db (Just $ ParentHeader blockHeader)
  startTxId <- fmap fromIntegral $
    if bHeight == genesisHeight v cid
    then return 0
    else PactDb.getEndTxId' "doGetBlockHistory" db (pred bHeight) (_blockParent blockHeader)

  let tname = domainTableName d
  !history <- queryHistory tname startTxId endTxId

  let (!hkeys,tmap) = foldl' procTxHist (S.empty,mempty) history
  !prev <- M.fromList . catMaybes <$> mapM (queryPrev tname startTxId) (S.toList hkeys)
  return $ BlockTxHistory tmap prev
  where
    v = _chainwebVersion blockHeader
    cid = _blockChainId blockHeader
    bHeight = _blockHeight blockHeader

    procTxHist
      :: (S.Set Utf8, M.Map TxId [PCore.TxLog PCore.RowData])
      -> (Utf8,TxId,PCore.TxLog PCore.RowData)
      -> (S.Set Utf8,M.Map TxId [PCore.TxLog PCore.RowData])
    procTxHist (ks,r) (uk,t,l) = (S.insert uk ks, M.insertWith (++) t [l] r)

    -- Start index is inclusive, while ending index is not.
    -- `endingtxid` in a block is the beginning txid of the following block.
    queryHistory :: Utf8 -> Int64 -> Int64 -> IO [(Utf8,TxId,PCore.TxLog PCore.RowData)]
    queryHistory tableName s e = do
      let sql = "SELECT txid, rowkey, rowdata FROM [" <> tableName <>
                "] WHERE txid >= ? AND txid < ?"
      r <- qry db sql
           [SInt s,SInt e]
           [RInt,RText,RBlob]
      forM r $ \case
        [SInt txid, SText key, SBlob value] -> (key,fromIntegral txid,) <$> PCore.toTxLog (asString d) key value
        err -> internalError $
               "queryHistory: Expected single row with three columns as the \
               \result, got: " <> T.pack (show err)

    -- Get last tx data, if any, for key before start index.
    queryPrev :: Utf8 -> Int64 -> Utf8 -> IO (Maybe (RowKey,PCore.TxLog PCore.RowData))
    queryPrev tableName s k@(Utf8 sk) = do
      let sql = "SELECT rowdata FROM [" <> tableName <>
                "] WHERE rowkey = ? AND txid < ? " <>
                "ORDER BY txid DESC LIMIT 1"
      r <- qry db sql
           [SText k,SInt s]
           [RBlob]
      case r of
        [] -> return Nothing
        [[SBlob value]] -> Just . (RowKey $ T.decodeUtf8 sk,) <$> PCore.toTxLog (asString d) k value
        _ -> internalError $ "queryPrev: expected 0 or 1 rows, got: " <> T.pack (show r)


doGetHistoricalLookup
    :: SQLiteEnv
    -> BlockHeader
    -> Domain RowKey RowData
    -> RowKey
    -> IO (Maybe (PCore.TxLog PCore.RowData))
doGetHistoricalLookup db blockHeader d k = do
  endTxId <-
    fromIntegral <$> PactDb.getEndTxId "doGetHistoricalLookup" db (Just $ ParentHeader blockHeader)
  latestEntry <- queryHistoryLookup (domainTableName d) endTxId (convRowKey k)
  return $! latestEntry
  where
    queryHistoryLookup :: Utf8 -> Int64 -> Utf8 -> IO (Maybe (PCore.TxLog PCore.RowData))
    queryHistoryLookup tableName e rowKeyName = do
      let sql = "SELECT rowKey, rowdata FROM [" <> tableName <>
                "] WHERE txid < ? AND rowkey = ? ORDER BY txid DESC LIMIT 1;"
      r <- qry db sql
           [SInt e, SText rowKeyName]
           [RText, RBlob]
      case r of
        [[SText key, SBlob value]] -> Just <$> PCore.toTxLog (asString d) key value
        [] -> pure Nothing
        _ -> internalError $ "doGetHistoricalLookup: expected single-row result, got " <> sshow r
