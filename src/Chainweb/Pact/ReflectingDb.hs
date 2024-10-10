{-# LANGUAGE GADTs #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DerivingVia #-}
{-# LANGUAGE RecordWildCards #-}

module Chainweb.Pact.ReflectingDb where

import Data.Text(Text)

import qualified Pact.Types.Persistence as Pact4
import qualified Pact.Types.Util as Pact4
import qualified Pact.Core.Builtin as Pact5
import qualified Pact.JSON.Encode as J


import Control.Monad.IO.Class (liftIO)
import Control.Monad (unless)
import Control.Lens ((^?), (^.), ix, view)
import Data.Maybe (isJust, fromMaybe, catMaybes)
import Data.Map (Map)
import Data.IORef
import qualified Data.Map.Strict as M
import qualified Data.Set as S
import Data.ByteString (ByteString)


import Pact.Core.Guards
import Pact.Core.Namespace
import Pact.Core.Names hiding (renderTableName)
import Pact.Core.DefPacts.Types (DefPactExec)
import Pact.Core.Persistence
import Pact.Core.Serialise
import Pact.Core.StableEncoding
import Pact.Core.Errors as Errors
import Pact.Core.Evaluate
import Data.Set (Set)
import Data.Aeson (FromJSON)
import Data.String (IsString)
import Data.Foldable (forM_)



type TxLogQueue = IORef (Map TxId [TxLog ByteString])

-- | Small newtype to ensure we
--   turn the table names into Text keys
newtype Rendered v
  = Rendered { _unRender :: Text }
  deriving (Eq, Ord, Show)

renderTableName :: TableName -> Rendered TableName
renderTableName tn = Rendered (toUserTable tn)

newtype MockUserTable =
  MockUserTable (Map (Rendered TableName) (Map RowKey ByteString))
  deriving (Eq, Show, Ord)
  deriving (Semigroup, Monoid) via (Map (Rendered TableName) (Map RowKey ByteString))

newtype MockSysTable k v =
  MockSysTable (Map (Rendered k) ByteString)
  deriving (Eq, Show, Ord)
  deriving (Semigroup, Monoid) via (Map (Rendered k) ByteString)

data TableFromDomain k v b i where
  TFDUser :: IORef (MockUserTable) -> TableFromDomain RowKey RowData b i
  TFDSys :: IORef (MockSysTable k v) -> TableFromDomain k v b i


mkReflectingDb :: Pact4.PactDb e -> IO (Pact4.PactDb e, PactDb Pact5.CoreBuiltin Info)
mkReflectingDb pact4Db = do
  pactTables <- createPactTables
  reflectingDb <- pact4ReflectingDb pactTables pact4Db
  pdb' <- mockPactDb pactTables serialisePact_lineinfo
  pure (reflectingDb, pdb')

type WriteSet = Map Text (Set Text)

isInWriteSet :: (Ord k, Ord a) => k -> a -> Map k (Set a) -> Bool
isInWriteSet dom k ws = maybe False id $ do
  s <- M.lookup dom ws
  pure (S.member k s)

pact4ReflectingDb :: forall e. PactTables Pact5.CoreBuiltin Info -> Pact4.PactDb e -> IO (Pact4.PactDb e)
pact4ReflectingDb PactTables{..} pact4Db = do
  ws <- newIORef mempty
  pure $ Pact4.PactDb {
   Pact4._readRow = read' ws
  , Pact4._writeRow = write' ws
  , Pact4._keys = keys'
  , Pact4._txids = Pact4._txids pact4Db
  , Pact4._createUserTable = Pact4._createUserTable pact4Db
  , Pact4._getUserTableInfo = Pact4._getUserTableInfo pact4Db
  , Pact4._beginTx = Pact4._beginTx pact4Db
  , Pact4._commitTx = Pact4._commitTx pact4Db
  , Pact4._rollbackTx = Pact4._rollbackTx pact4Db
  , Pact4._getTxLog = Pact4._getTxLog pact4Db
  }
  where
  write' :: (forall k v . (Pact4.AsString k,J.Encode v) => IORef WriteSet -> Pact4.WriteType -> Pact4.Domain k v -> k -> v -> Pact4.Method e ())
  write' ws wt domain k v meth = do
    _ <- Pact4._writeRow pact4Db wt domain k v meth
    let domString = Pact4.asString domain
        rowString = Pact4.asString k
    modifyIORef' ws (M.insertWith S.union domString (S.singleton rowString))

  keys' :: forall k v . (IsString k,Pact4.AsString k) => Pact4.Domain k v -> Pact4.Method e [k]
  keys' dom meth = do
    ks <- Pact4._keys pact4Db dom meth
    case dom of
      Pact4.UserTables _ -> do
        forM_ ks $ \rk -> do
          MockUserTable tbl <- readIORef ptUser
          let tblString = Pact4.asString dom
              rowString = RowKey (Pact4.asString rk)
          writeIORef ptUser $ MockUserTable $ M.insertWith (flip (<>)) (Rendered tblString) (M.singleton rowString mempty) tbl
        pure ks
      _ -> pure ks



  read' :: forall k v . (IsString k,FromJSON v) => IORef WriteSet -> Pact4.Domain k v -> k -> Pact4.Method e (Maybe v)
  read' wsRef dom k meth = do
    let domainStr = Pact4.asString dom
    let keyString = Pact4.asString keyString
    writeSet <- readIORef wsRef
    Pact4._readRow pact4Db dom k meth >>= \case
      Nothing -> pure Nothing
      Just v -> do
        unless (isInWriteSet domainStr keyString writeSet) $ writeToPactTables dom k v
        pure (Just v)

  writeToPactTables :: Pact4.Domain k v -> k -> v -> IO ()
  writeToPactTables dom k v = case dom of
    Pact4.UserTables _ -> do
      MockUserTable tbl <- readIORef ptUser
      let tblString = Pact4.asString dom
          rowString = RowKey (Pact4.asString k)
          encoded = J.encodeStrict v
      writeIORef ptUser $ MockUserTable $ M.insertWith (<>) (Rendered tblString) (M.singleton rowString encoded) tbl
    Pact4.Modules -> do
      MockSysTable tbl <- readIORef ptModules
      let rowString = Pact4.asString k
          encoded = J.encodeStrict v
      writeIORef ptModules $ MockSysTable $ M.insert (Rendered rowString) encoded tbl
    Pact4.KeySets -> do
      MockSysTable tbl <- readIORef ptKeysets
      let rowString = Pact4.asString k
          encoded = J.encodeStrict v
      writeIORef ptKeysets $ MockSysTable $ M.insert (Rendered rowString) encoded tbl
    Pact4.Namespaces -> do
      MockSysTable tbl <- readIORef ptNamespaces
      let rowString = Pact4.asString k
          encoded = J.encodeStrict v
      writeIORef ptNamespaces $ MockSysTable $ M.insert (Rendered rowString) encoded tbl
    Pact4.Pacts -> do
      MockSysTable tbl <- readIORef ptDefPact
      let rowString = Pact4.asString k
          encoded = J.encodeStrict v
      writeIORef ptDefPact $ MockSysTable $ M.insert (Rendered rowString) encoded tbl





tableFromDomain :: Domain k v b i -> PactTables b i -> TableFromDomain k v b i
tableFromDomain d PactTables{..} = case d of
  DUserTables {} -> TFDUser ptUser
  DKeySets -> TFDSys ptKeysets
  DModules -> TFDSys ptModules
  DNamespaces -> TFDSys ptNamespaces
  DDefPacts -> TFDSys ptDefPact
  -- DModuleSource -> TFDSys ptModuleCode


-- | A record collection of all of the mutable
--   table references
data PactTables b i
  = PactTables
  { ptTxId :: !(IORef TxId)
  , ptUser :: !(IORef MockUserTable)
  , ptModules :: !(IORef (MockSysTable ModuleName (ModuleData b i)))
  -- , ptModuleCode :: !(IORef (MockSysTable HashedModuleName ModuleCode))
  , ptKeysets :: !(IORef (MockSysTable KeySetName KeySet))
  , ptNamespaces :: !(IORef (MockSysTable NamespaceName Namespace))
  , ptDefPact :: !(IORef (MockSysTable DefPactId (Maybe DefPactExec)))
  , ptTxLogQueue :: TxLogQueue
  , ptRollbackState :: IORef (Maybe (PactTablesState b i))
  -- , ptReflectedWriteSet :: IORef (Set Text)
  }

-- | The state of the database at the beginning of a transaction
data PactTablesState b i
  = PactTablesState
  { _ptsExecMode :: ExecutionMode
  , _ptsUser :: !MockUserTable
  , _ptsModules :: !(MockSysTable ModuleName (ModuleData b i))
  , _ptsKeysets :: !(MockSysTable KeySetName KeySet)
  , _ptsNamespaces :: !(MockSysTable NamespaceName Namespace)
  , _ptsDefPact :: !(MockSysTable DefPactId (Maybe DefPactExec))
  , _ptsTxLogQueue :: Map TxId [TxLog ByteString]
  }

-- | Create an empty table
createPactTables :: IO (PactTables b i)
createPactTables = do
  refMod <- newIORef mempty
  -- refMCode <- newIORef mempty
  refKs <- newIORef mempty
  refUsrTbl <- newIORef mempty
  refPacts <- newIORef mempty
  refNS <- newIORef mempty
  refRb <- newIORef Nothing
  refTxLog <- newIORef mempty
  refTxId <- newIORef $ TxId 0
  -- refWriteset <- newIORef mempty
  pure $ PactTables
    { ptTxId = refTxId
    , ptUser = refUsrTbl
    , ptModules = refMod
    -- , ptModuleCode = refMCode
    , ptKeysets = refKs
    , ptNamespaces = refNS
    , ptDefPact = refPacts
    , ptTxLogQueue = refTxLog
    , ptRollbackState = refRb
    }

getRollbackState :: ExecutionMode -> PactTables b i -> IO (PactTablesState b i)
getRollbackState em PactTables{..} =
  PactTablesState em
    <$> readIORef ptUser
    <*> readIORef ptModules
    <*> readIORef ptKeysets
    <*> readIORef ptNamespaces
    <*> readIORef ptDefPact
    <*> readIORef ptTxLogQueue



mockPactDb :: forall b i. PactTables b i -> PactSerialise b i -> IO (PactDb b i)
mockPactDb pactTables serial = do
  pure $ PactDb
    { _pdbPurity = PImpure
    , _pdbRead = read' pactTables
    , _pdbWrite = write pactTables
    , _pdbKeys = keys pactTables
    , _pdbCreateUserTable = createUsrTable pactTables
    , _pdbBeginTx = liftIO . beginTx pactTables
    , _pdbCommitTx = commitTx pactTables
    , _pdbRollbackTx = rollbackTx pactTables
    }
  where
  beginTx pts@PactTables{..} em = do
    readIORef ptRollbackState >>= \case
      -- A tx is already in progress, so we fail to get a
      -- new tx id
      Just _ -> pure Nothing
      -- No tx in progress, get the state of the pure tables prior to rollback.
      Nothing -> do
        rbs <- getRollbackState em pts

        writeIORef ptRollbackState (Just rbs)
        tid <- readIORef ptTxId
        pure (Just tid)

  commitTx PactTables{..} = liftIO (readIORef ptRollbackState) >>= \case
    -- We are successfully in a transaction
    Just (PactTablesState em usr mods ks ns dp txl) -> case em of
      Transactional -> liftIO $ do
        -- Reset the rollback state,
        -- increment to the next tx id, and return the
        -- tx logs for the transaction
        writeIORef ptRollbackState Nothing
        txId <- atomicModifyIORef' ptTxId (\(TxId i) -> (TxId (succ i), TxId i))
        txLogQueue <- readIORef ptTxLogQueue
        pure $ reverse $ M.findWithDefault [] txId txLogQueue
      Local -> liftIO $ do
        -- in local, we simply roll back all tables
        -- then and return the logs, then roll back the logs table
        writeIORef ptRollbackState Nothing
        writeIORef ptModules mods
        writeIORef ptKeysets ks
        writeIORef ptUser usr
        writeIORef ptTxLogQueue txl
        writeIORef ptNamespaces ns
        writeIORef ptDefPact dp

        txId <- readIORef ptTxId
        txl' <- readIORef ptTxLogQueue

        let logs = M.findWithDefault [] txId txl'
        writeIORef ptTxLogQueue txl
        pure logs
    Nothing ->
      throwDbOpErrorGasM (Errors.NotInTx "commit")

  rollbackTx PactTables{..} = liftIO (readIORef ptRollbackState) >>= \case
    Just (PactTablesState _ usr mods ks ns dp txl) -> liftIO $ do
      writeIORef ptRollbackState Nothing
      writeIORef ptModules mods
      writeIORef ptKeysets ks
      writeIORef ptUser usr
      writeIORef ptTxLogQueue txl
      writeIORef ptNamespaces ns
      writeIORef ptDefPact dp
    Nothing -> throwDbOpErrorGasM (Errors.NotInTx "rollback")


  keys
    :: PactTables b i
    -> Domain k v b i
    -> GasM b i [k]
  keys PactTables{..} d = case d of
    DKeySets -> do
      MockSysTable r <- liftIO $ readIORef ptKeysets
      -- Note: the parser only fails on null input, so
      -- if this ever fails, then somehow the null key got into the keysets.
      -- this is benign.
      let getKeysetName = fromMaybe (KeySetName "" Nothing) . rightToMaybe . parseAnyKeysetName
      return $ getKeysetName . _unRender <$> M.keys r
    DModules -> do
      MockSysTable r <- liftIO $ readIORef ptModules
      let getModuleName = parseModuleName . _unRender
      return $ catMaybes $ getModuleName <$> M.keys r
    DUserTables tbl -> do
      MockUserTable r <- liftIO $ readIORef ptUser
      let tblName = renderTableName tbl
      case M.lookup tblName r of
        Just t -> return (M.keys t)
        Nothing -> throwDbOpErrorGasM (Errors.NoSuchTable tbl)
    DDefPacts -> do
      MockSysTable r <- liftIO $ readIORef ptDefPact
      return $ DefPactId . _unRender <$> M.keys r
    DNamespaces -> do
      MockSysTable r <- liftIO $ readIORef ptNamespaces
      pure $ NamespaceName . _unRender <$> M.keys r
    -- DModuleSource -> do
    --   MockSysTable r <- liftIO $ readIORef ptModuleCode
    --   let ks = M.keys r
    --   traverse (maybe (throwDbOpErrorGasM (RowReadDecodeFailure "Invalid module source key format")) pure . parseHashedModuleName . _unRender) ks


  createUsrTable
    :: PactTables b i
    -> TableName
    -> GasM b i ()
  createUsrTable tbls@PactTables{..} tbl = do
    let uti = UserTableInfo (_tableModuleName tbl)
    MockUserTable ref <- liftIO $ readIORef ptUser
    let tblName = renderTableName tbl
    case M.lookup tblName ref of
      Nothing -> do
        liftIO $ record tbls (TxLog "SYS:usertables" (_tableName tbl) (encodeStable uti))
        liftIO $ modifyIORef ptUser (\(MockUserTable m) -> MockUserTable (M.insert tblName mempty m))
        pure ()
      Just _ -> throwDbOpErrorGasM (TableAlreadyExists tbl)


  read'
    :: forall k v
    .  PactTables b i
    -> Domain k v b i
    -> k
    -> GasM b i (Maybe v)
  read' PactTables{..} domain k = case domain of
    DKeySets -> readSysTable ptKeysets k (Rendered . renderKeySetName) _decodeKeySet
    DModules -> readSysTable ptModules k (Rendered . renderModuleName) _decodeModuleData
    -- DModuleSource -> readSysTable ptModuleCode k (Rendered . renderHashedModuleName)  _decodeModuleCode
    DUserTables tbl ->
      readRowData ptUser tbl k
    DDefPacts -> readSysTable ptDefPact k (Rendered . _defPactId) _decodeDefPactExec
    DNamespaces ->
      readSysTable ptNamespaces k (Rendered . _namespaceName) _decodeNamespace

  -- checkTable :: MonadIO m => Rendered TableName -> TableName -> MockUserTable -> m ()
  checkTable tbl tn (MockUserTable r) = do
    unless (isJust (M.lookup tbl r)) $ throwDbOpErrorGasM (Errors.NoSuchTable tn)

  write
    :: forall k v
    .  PactTables b i
    -> WriteType
    -> Domain k v b i
    -> k
    -> v
    -> GasM b i ()
  write pt wt domain k v = case domain of
    -- Todo : incrementally serialize other types
    DKeySets -> liftIO $ writeSysTable pt domain k v (Rendered . renderKeySetName) _encodeKeySet
    DModules -> liftIO $ writeSysTable pt domain k v (Rendered . renderModuleName) _encodeModuleData
    DUserTables tbl -> writeRowData pt tbl wt k v
    DDefPacts -> liftIO $ writeSysTable pt domain k v (Rendered . _defPactId) _encodeDefPactExec
    DNamespaces -> liftIO $ writeSysTable pt domain k v (Rendered . _namespaceName) _encodeNamespace
    -- DModuleSource -> liftIO $ writeSysTable pt domain k v (Rendered . renderHashedModuleName) _encodeModuleCode

  readRowData
    :: IORef MockUserTable
    -> TableName
    -> RowKey
    -> GasM b i (Maybe RowData)
  readRowData ref tbl k = do
    let tblName = renderTableName tbl
    mt@(MockUserTable usrTables) <- liftIO $ readIORef ref
    checkTable tblName tbl mt
    case usrTables ^? ix tblName . ix k of
      Just bs -> case _decodeRowData serial bs of
        Just doc -> pure (Just (view document doc))
        Nothing -> throwDbOpErrorGasM $ RowReadDecodeFailure (_rowKey k)
      Nothing -> pure Nothing

  writeRowData
    :: PactTables b i
    -> TableName
    -> WriteType
    -> RowKey
    -> RowData
    -> GasM b i ()
  writeRowData pts@PactTables{..} tbl wt k v = do
    let tblName = renderTableName tbl
    mt@(MockUserTable usrTables) <- liftIO $ readIORef ptUser
    checkTable tblName tbl mt
    case wt of
      Write -> do
        encodedData <- _encodeRowData serial v
        liftIO $ record pts (TxLog (toUserTable tbl) (k ^. rowKey) encodedData)
        liftIO $ modifyIORef' ptUser
          (\(MockUserTable m) -> (MockUserTable (M.adjust (M.insert k encodedData) tblName  m)))
      Insert -> do
        case M.lookup tblName usrTables >>= M.lookup k of
          Just _ -> throwDbOpErrorGasM (Errors.RowFoundError tbl k)
          Nothing -> do
            encodedData <- _encodeRowData serial v
            liftIO $ record pts (TxLog (toUserTable tbl) (k ^. rowKey) encodedData)
            liftIO $ modifyIORef' ptUser
              (\(MockUserTable m) -> (MockUserTable (M.adjust (M.insert k encodedData) tblName  m)))
      Update -> do
        case M.lookup tblName usrTables >>= M.lookup k of
          Just bs -> case view document <$> _decodeRowData serial bs of
            Just (RowData m) -> do
              let (RowData v') = v
                  nrd = RowData (M.union v' m)
              encodedData <- _encodeRowData serial nrd
              liftIO $ record pts (TxLog (toUserTable tbl) (k ^. rowKey) encodedData)
              liftIO $ modifyIORef' ptUser $ \(MockUserTable mut) ->
                MockUserTable (M.insertWith M.union tblName (M.singleton k encodedData) mut)
            Nothing ->
              throwDbOpErrorGasM (RowReadDecodeFailure (_rowKey k))
          Nothing ->
            throwDbOpErrorGasM (NoRowFound tbl k)

  readSysTable
    :: IORef (MockSysTable k v)
    -> k
    -> (k -> Rendered k)
    -> (PactSerialise b i -> ByteString -> Maybe (Document v))
    -> GasM b i (Maybe v)
  readSysTable ref rowkey renderKey decode = do
    MockSysTable m <- liftIO $ readIORef ref
    case M.lookup (renderKey rowkey) m of
      Just bs -> case decode serial bs of
        Just rd -> pure (Just (view document rd))
        Nothing ->
          throwDbOpErrorGasM (RowReadDecodeFailure (_unRender (renderKey rowkey)))
      Nothing -> pure Nothing
  {-# INLINE readSysTable #-}

  writeSysTable
    :: PactTables b i
    -> Domain k v b i
    -> k
    -> v
    -> (k -> Rendered k)
    -> (PactSerialise b i -> v -> ByteString)
    -> IO ()
  writeSysTable pts domain rowkey value renderKey encode = do
    case tableFromDomain domain pts of
      TFDSys ref -> do
        let encodedData = encode serial value
        record pts (TxLog (renderDomain domain) (_unRender (renderKey rowkey)) encodedData)
        modifyIORef' ref $ \(MockSysTable msys) ->
            MockSysTable (M.insert (renderKey rowkey) encodedData msys)
      TFDUser _ ->
        -- noop, should not be used for user tables
        error "Invariant violated: writeSysTable used for user table"


rightToMaybe :: Either e a -> Maybe a
rightToMaybe = \case
  Left{} -> Nothing
  Right a -> Just a

record :: PactTables b i -> TxLog ByteString -> IO ()
record PactTables{..} entry = do
  txIdNow <- readIORef ptTxId
  modifyIORef ptTxLogQueue (M.insertWith (<>) txIdNow [entry])