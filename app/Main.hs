module Main where

import Parser.Parser (x)

main :: IO ()
main = putStrLn $ "Hello, from" ++ x
