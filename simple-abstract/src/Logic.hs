module Logic where

import Data.Foldable

someProcessing :: String -> Int -> String
someProcessing = undefined

someData :: [(String, Int)]
someData = undefined

someBranching ::
  IO () ->
  (String -> Int -> String) ->
  [(String, Int)] ->
  IO ()
someBranching doSomeAction f xs =
  for_ (map (uncurry f) xs) $ \y ->
    if y == "do the thing!"
      then doSomeAction
      else return ()

entryPoint :: IO () -> IO ()
entryPoint doSomeAction =
  someBranching doSomeAction someProcessing someData
