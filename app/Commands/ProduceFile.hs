module Commands.ProduceFile where

import System.Directory (doesFileExist)
import System.Posix.User
import Text.Printf

outputText :: String -> String -> Double -> IO ()
outputText service pwd entropy = do
  username <- getLoginName
  putStrLn username
  let passwordStoragePath = "/home/" ++ username ++ "/passwd.yaml"
  exists <- doesFileExist passwordStoragePath
  let pppYamlContent =
        unlines
          [ "- name: " ++ service,
            "  password: " ++ pwd,
            "  entropy: " ++ printf "%.2f" entropy
          ]

  if exists
    then do
      appendFile passwordStoragePath ("\n" ++ pppYamlContent)
      putStrLn "New data appended successfully."
    else do
      writeFile passwordStoragePath pppYamlContent
      putStrLn "File created and data written successfully."
