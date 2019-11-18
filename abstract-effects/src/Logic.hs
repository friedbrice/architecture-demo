module Logic where

import Effects

import Data.Foldable

someFunction :: String -> Int -> String
someFunction = undefined

someData :: [(String, Int)]
someData = undefined

someBranching :: DoSomeAction m
              => (String -> Int -> String)
              -> [(String, Int)]
              -> m ()
someBranching f xs =
  for_ (map (uncurry f) xs) $ \y ->
    if y == "do the thing!"
      then doSomeAction
      else return ()

entryPoint :: DoSomeAction m => m ()
entryPoint = someBranching someFunction someData
