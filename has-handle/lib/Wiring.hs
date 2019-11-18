{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Wiring where

import Effects
import Logic

import Control.Monad.Reader
import System.Environment
import qualified SomeLibrary as Some

data Args = Args { mode :: String, chan :: Int, num :: Int } deriving Read
data Conf = Conf { someHandle :: Some.Handle }

newtype App a = App { runApp :: ReaderT Conf IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader Conf)

instance HasSomeHandle Conf where
  getSomeHandle conf = someHandle conf

app :: IO ()
app = do
  args <- getArgs
  let appArgs = read (head args)

  handle <- Some.makeHandle (mode appArgs) (chan appArgs) (num appArgs)
  let appConf = Conf { someHandle = handle }

  runReaderT (runApp entryPoint) appConf
