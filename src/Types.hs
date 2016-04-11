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
import           Data.Text
import           GHC.Generics
import           Data.Aeson.TH

--------------------------------------------------------------------------------

data BPITime =
  BPITime { updated    :: Text -- UTC
          , updatedISO :: Text -- ISO
          , updateduk  :: Text -- GMT
          } deriving (Generic, FromJSON, Show)

data BPICurrency =
  BPICurrency { code        :: Text
              , symbol      :: Text
              , rate        :: Text  
              , description :: Text
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
             , disclaimer :: Text
             , bpi        :: BPI
           } deriving (Generic, FromJSON, Show)

       
