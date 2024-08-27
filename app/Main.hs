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
parse ["-g"] = runD >> exit
parse ["--gen"] = runD >> exit
parse ["-A"] = showAllPasswords >> exit
parse ["--all-passwords"] = showAllPasswords >> exit
parse ["-s"] = searchByName >> exit 
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
    "-g, --gen              generate and save a new password",
    "-A, --all-passwords    display all current passwords",
    "-s, --search           search for a specific stored password",
    "-h, --help             display the help menu",
    "-v, --version          output version information",
    "",
    "Source code of ppp: <https://github.com/rendick/ppp>",
    "Full documentation: <soon>"
  ]

exit :: IO a
exit = exitSuccess
