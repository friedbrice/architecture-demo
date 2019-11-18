{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Effects
import Logic

import Control.Monad.Reader
import System.Environment
import qualified SomeLibrary as Some

data Args = Args { mode :: String, chan :: Int, num :: Int } deriving Read
data Conf = Conf { someHandle :: Some.Handle }

newtype App a = App { runApp :: ReaderT Conf IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader Conf)

instance DoSomeAction App where
  doSomeAction = do
    conf <- ask
    let handle = someHandle conf
    liftIO (Some.doAction handle)

main :: IO ()
main = do
  args <- getArgs
  let appArgs = read (head args)

  handle <- Some.makeHandle (mode appArgs) (chan appArgs) (num appArgs)
  let appConf = Conf { someHandle = handle }

  runReaderT (runApp entryPoint) appConf
