{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Logic

import System.Environment
import qualified SomeLibrary as Some

data Conf =
  Conf { mode :: String, chan :: Int, num :: Int }
  deriving Read

data Env =
  Env { someHandle :: Some.Handle }

main :: IO ()
main = do
  args <- getArgs
  let conf = read (head args)

  handle <- Some.makeHandle (mode conf) (chan conf) (num conf)
  let env = Env { someHandle = handle }

  entryPoint (someHandle env)
