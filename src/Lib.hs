{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( queryCD
    , getCurrentPrice
    , getCurrentPriceInCurrency
    , getHistory
    , getHistoryInCurrency
    , getHistoryYesterday
    , getHistoryInPeriod
    , module Types  
    ) where

import Data.Aeson
import qualified Data.Text as T
import Data.Time 
import Network.HTTP.Conduit (simpleHttp)
import qualified Data.ByteString.Char8 as B
import qualified Data.ByteString.Lazy.Char8 as BL

import Types

--------------------------------------------------------------------------------

endpoint :: T.Text
endpoint = "http://api.coindesk.com/v1/bpi/"

getCurrentPrice :: T.Text
getCurrentPrice = T.concat [endpoint, "currentprice.json"]

-- | 
--  <code>.json, EUR.json
getCurrentPriceInCurrency :: T.Text -- ^ Currency code for conversion
                          -> T.Text 
getCurrentPriceInCurrency c = T.concat [endpoint, "currentprice/", c, ".json"]

-- | Returns history for month in USD
--
getHistory :: T.Text
getHistory = T.concat [endpoint, "historical/close.json"]

-- | Returns history for month in desired currency
--
getHistoryInCurrency :: T.Text -> T.Text
getHistoryInCurrency c = T.concat [endpoint, "historical/close.json?currency=", c]

getHistoryYesterday :: T.Text
getHistoryYesterday = T.concat [getHistory, "?for=yesterday"]

getHistoryInPeriod :: Day -> Day -> T.Text
getHistoryInPeriod sdate edate = T.concat [getHistory, "?start=", "&end="]

-- | Execute defined query over CoindDesk API
-- 
queryCD :: T.Text -> IO (Maybe BPIWrapper)
queryCD query = fmap decode $ simpleHttp (T.unpack query)
