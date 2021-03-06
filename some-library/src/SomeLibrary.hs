module SomeLibrary where

-- | Represents some system-level resource. In a real library, this
-- type would actually have some stuff in it, but the details would
-- probably be hidden from clients.
data Handle

-- | Takes some config params and acquires a reusable handle.
-- Imagine it's costly to make a handle, so we don't want to make
-- new handles if we don't need to.
makeHandle :: String -> Int -> Int -> IO Handle
makeHandle mode chan num = undefined

-- | Use a handle to perform some action. You're free to reuse the
-- same handle over and over.
doAction :: Handle -> IO ()
doAction handle = undefined
