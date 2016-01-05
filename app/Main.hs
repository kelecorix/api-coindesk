{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib

--------------------------------------------------------------------------------

main :: IO ()
main =
  do
    res <- queryCD getCurrentPrice
    putStrLn $ show $ res
