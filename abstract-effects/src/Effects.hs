module Effects where

class Monad m => DoSomeAction m where
  doSomeAction :: m ()
