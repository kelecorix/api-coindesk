{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Concurrent (forkIO, threadDelay)
import           Control.Concurrent.STM.TVar
import           Control.Monad (forever)
import           System.Environment
import           Data.Time.Clock

import           Lib

--------------------------------------------------------------------------------

queryCDC :: String -> IO ()
queryCDC query =
  do
    res <- queryCD query
    case res of
      Nothing   -> putStrLn $ show $ res
      Just bpiw ->
        do
          let currn = eur $ bpi bpiw
              curr  = (rate currn) ++ " " ++ (code currn)
              out   = (updated $ time bpiw) ++ " | " ++ curr
          putStrLn $ out

queryCDCDaemon :: TVar Int -> Int -> String -> IO ()
queryCDCDaemon timeVar delay query =
  forever $ daemonProcess timeVar
    where
      daemonProcess var =
        do
          queryCDC query
          delayTime <- readTVarIO var
          _         <- threadDelay delayTime
          return ()

main :: IO ()
main =
  do
    let delay = 30000 -- each 30 seconds 1/2 minute
    a       <- getArgs
    timeVar <- newTVarIO (delay*1000)
    case a of
      ["-d"]    -> queryCDCDaemon timeVar delay getCurrentPrice
      otherwise -> queryCDC getCurrentPrice 

