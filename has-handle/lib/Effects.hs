module Effects where

import Control.Monad.IO.Class
import qualified SomeLibrary as Some

class HasSomeHandle m where
  getSomeHandle :: m Some.Handle

doSomeAction :: (HasSomeHandle m, MonadIO m) => m ()
doSomeAction = do
  handle <- getSomeHandle
  liftIO $ Some.doAction handle
