module Types
       ( BPITime(..)
       , BPICurrency(..)
       , BPI(..)
       , BPIWrapper(..))
       where

--------------------------------------------------------------------------------

data BPITime =
  BPITime { updated    :: String -- UTC
          , updatedISO :: String -- ISO
          , updateduk  :: String -- GMT
          }

data BPICurrency =
  BPICurrency { code        :: String
              , symbol      :: String
              , rate        :: String  
              , description :: String
              , rate_float  :: Float  
              }

data BPI =
  BPI { usd :: BPICurrency
      , gbp :: BPICurrency
      , eur :: BPICurrency  
    }

-- | Bitcoing price index
data BPIWrapper =
  BPIWrapper { time       :: BPITime 
             , disclaimer :: String
             , bpi        :: BPI
             }

       
