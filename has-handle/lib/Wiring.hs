{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Wiring where

import Effects
import Logic

import Control.Monad.Reader
import qualified SomeLibrary as Some

data Args = Args { mode :: String, chan :: Int, num :: Int }

getAppArgs :: IO Args
getAppArgs = undefined

data Conf = Conf { someHandle :: Some.Handle }

newtype App a = App { runApp :: ReaderT Conf IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader Conf)

instance HasSomeHandle App where
  getSomeHandle = do
    conf <- ask
    return (someHandle conf)

app :: IO ()
app = do
  args <- getAppArgs
  handle <- Some.makeHandle (mode args) (chan args) (num args)
  let conf = Conf { someHandle = handle }
  runReaderT (runApp entryPoint) conf
