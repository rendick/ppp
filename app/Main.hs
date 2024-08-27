module Main where

import Commands.Generation
import Commands.ParseYaml
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
parse ["-G"] = runD >> exit
parse ["--gen"] = runD >> exit
parse ["-S"] = showAllPasswords >> exit 
parse ["--search"] = searchByName >> exit
parse ["-h"] = mapM_ putStrLn usage >> exit
parse ["--help"] = mapM_ putStrLn usage >> exit
parse ["-v"] = version >> exit
parse ["--version"] = version >> exit
parse [] = mapM_ putStrLn usage >> exit
parse fs = concat <$> mapM readFile fs

version :: IO ()
version = putStrLn "v0.1.0 in development"

usage :: [String]
usage =
  [ "Usage: ppp [ARGUMENT]",
    "",
    "gen      generation",
    "help     help menu",
    "version  version menu",
    "",
    "Source code of ppp: <https://github.com/rendick/ppp>",
    "Full documentation: <soon>"
  ]

exit :: IO a
exit = exitSuccess
