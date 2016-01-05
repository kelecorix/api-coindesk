{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib

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
          putStrLn $ updated $ time bpiw
          putStrLn $ (rate currn) ++ " " ++ (code currn)

main :: IO ()
main = queryCDC getCurrentPrice

