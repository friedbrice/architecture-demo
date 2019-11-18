module Effects where

import Control.Monad.Reader
import qualified SomeLibrary as Some

class HasSomeHandle a where
  getSomeHandle :: a -> Some.Handle

doSomeAction :: (HasSomeHandle a, MonadIO m, MonadReader a m)
             => m ()
doSomeAction = do
  conf <- ask
  let handle = getSomeHandle conf
  liftIO (Some.doAction handle)
