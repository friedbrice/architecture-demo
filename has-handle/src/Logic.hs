module Logic where

import Effects

import Control.Monad.Reader
import Data.Foldable

someProcessing :: String -> Int -> String
someProcessing = undefined

someData :: [(String, Int)]
someData = undefined

someBranching ::
  (HasSomeHandle a, MonadIO m, MonadReader a m) =>
  (String -> Int -> String) ->
  [(String, Int)] ->
  m ()
someBranching f xs =
  for_ (map (uncurry f) xs) $ \y ->
    if y == "do the thing!"
      then doSomeAction
      else return ()

entryPoint :: (HasSomeHandle a, MonadIO m, MonadReader a m) => m ()
entryPoint = someBranching someProcessing someData
