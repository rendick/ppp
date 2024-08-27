module Commands.ProduceFile where

import System.Directory (doesFileExist)
import System.IO (appendFile)
import Text.Printf

outputText :: String -> String -> Double -> IO ()
outputText service pwd entropy = do
  exists <- doesFileExist "passwd.yaml"

  let pppYamlContent =
        unlines
          [ "- name: " ++ service,
            "  password: " ++ pwd,
            "  entropy: " ++ printf "%.2f" entropy
          ]

  if exists
    then do
      appendFile "passwd.yaml" ("\n" ++ pppYamlContent)
      putStrLn "New data appended successfully."
    else do
      writeFile "passwd.yaml" pppYamlContent
      putStrLn "File created and data written successfully."
