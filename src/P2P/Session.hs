{-# LANGUAGE CPP #-}
{-# LANGUAGE ScopedTypeVariables #-}

-- |
-- Module: P2P.Session
-- Copyright: Copyright © 2018 Kadena LLC.
-- License: MIT
-- Maintainer: Lars Kuhtz <lars@kadena.io>
-- Stability: experimental
--
-- TODO
--
module P2P.Session
(
-- * Log Function
  LogFunction
, defaultLogFunction

-- * P2P Client Session
, P2pSession
) where

import Control.Monad

import qualified Data.Text as T
import qualified Data.Text.IO as T

import Servant.Client

import System.LogLevel

-- Internal imports

-- -------------------------------------------------------------------------- --
-- Log Function

type LogFunction = LogLevel -> T.Text -> IO ()

defaultLogFunction :: LogFunction
defaultLogFunction l = when (l >= Warn) . T.putStrLn

-- -------------------------------------------------------------------------- --
-- P2P Client Session

type P2pSession = LogFunction -> ClientEnv -> IO Bool

