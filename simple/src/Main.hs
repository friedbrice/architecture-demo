{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Logic

import System.Environment
import qualified SomeLibrary as Some

data Args =
  Args { mode :: String, chan :: Int, num :: Int }
  deriving Read

data Conf =
  Conf { someHandle :: Some.Handle }

main :: IO ()
main = do
  cliArgs <- getArgs
  let args = read (head cliArgs)

  handle <- Some.makeHandle (mode args) (chan args) (num args)
  let appConf = Conf { someHandle = handle }

  entryPoint (someHandle appConf)
