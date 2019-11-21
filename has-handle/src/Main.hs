{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Effects
import Logic

import Control.Monad.Reader
import System.Environment
import qualified SomeLibrary as Some

data Conf =
  Conf { mode :: String, chan :: Int, num :: Int }
  deriving Read

data Env =
  Env { someHandle :: Some.Handle }

newtype App a =
  App { runApp :: ReaderT Env IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader Env)

instance HasSomeHandle Env where
  getSomeHandle conf = someHandle conf

main :: IO ()
main = do
  args <- getArgs
  let conf = read (head args)

  handle <- Some.makeHandle (mode conf) (chan conf) (num conf)
  let env = Env { someHandle = handle }

  runReaderT (runApp entryPoint) env
