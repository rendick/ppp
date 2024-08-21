module Main where

import Commands.Generation

import System.Environment (getArgs)
import System.Exit (exitSuccess)

main :: IO ()
main = do
 args <- getArgs
 result <- parse args
 putStrLn $ tac result

tac :: String -> String
tac = unlines . reverse . lines

parse :: [String] -> IO String
parse ["help"] = usage >> exit
parse ["gen"] = runD >> exit
parse ["version"] = version >> exit
parse []= usage >> exit
parse fs = concat <$> mapM readFile fs

usage :: IO ()
usage = putStrLn "Usage: ppp [ARGUMENT]"

version :: IO ()
version = putStrLn "v0.1.0 in development"

exit :: IO a
exit = exitSuccess
