{-# LANGUAGE DeriveGeneric   #-}
{-# LANGUAGE DeriveAnyClass  #-}
{-# LANGUAGE TemplateHaskell #-}

module Types
       ( BPITime(..)
       , BPICurrency(..)
       , BPI(..)
       , BPIWrapper(..))
       where

import           Data.Aeson
import           GHC.Generics
import           Data.Aeson.TH

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
    } deriving (Show)

$(deriveFromJSON defaultOptions {
    fieldLabelModifier =
       let f "usd" = "USD"
           f "gbp" = "GBP"
           f "eur" = "EUR"
       in f
    } ''BPI)

-- | Bitcoing price index
data BPIWrapper =
  BPIWrapper { time       :: BPITime 
             , disclaimer :: String
             , bpi        :: BPI
            } deriving (Generic, FromJSON, Show)

       
