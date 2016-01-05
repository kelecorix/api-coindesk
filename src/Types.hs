{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Types
       ( BPITime(..)
       , BPICurrency(..)
       , BPI(..)
       , BPIWrapper(..))
       where

import           Data.Aeson
import           GHC.Generics

--------------------------------------------------------------------------------

data BPITime =
  BPITime { updated    :: String -- UTC
          , updatedISO :: String -- ISO
          , updateduk  :: String -- GMT
          } deriving (Generic, FromJSON, Show)

data BPICurrency =
  BPICurrency { code        :: String
              , symbol      :: String
              , rate        :: String  
              , description :: String
              , rate_float  :: Float  
              } deriving (Generic, FromJSON, Show)

data BPI =
  BPI { usd :: BPICurrency
      , gbp :: BPICurrency
      , eur :: BPICurrency  
    } deriving (Generic, FromJSON, Show)

-- | Bitcoing price index
data BPIWrapper =
  BPIWrapper { time       :: BPITime 
             , disclaimer :: String
             , bpi        :: BPI
             } deriving (Generic, FromJSON, Show)

       
