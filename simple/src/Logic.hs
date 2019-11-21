module Logic where

import Data.Foldable
import SomeLibrary as Some

someProcessing :: String -> Int -> String
someProcessing = undefined

someData :: [(String, Int)]
someData = undefined

someBranching ::
  Some.Handle ->
  (String -> Int -> String) ->
  [(String, Int)] ->
  IO ()
someBranching h f xs =
  for_ (map (uncurry f) xs) $ \y ->
    if y == "do the thing!"
      then Some.doAction h
      else return ()

entryPoint :: Some.Handle -> IO ()
entryPoint h = someBranching h someProcessing someData
