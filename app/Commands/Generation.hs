module Commands.Generation where

import Commands.ProduceFile
import System.Exit (exitSuccess)
import System.IO (hFlush, stdout)
import System.Posix.User
import System.Random
import Text.Printf (printf)
import Control.Monad (when)

randomChar :: IO Char
randomChar = getStdRandom $ randomR ('0', 'z')

generation :: Int -> IO [Char]
generation 0 = return ""
generation n = randomChar >>= \c -> generation (n - 1) >>= \b -> return (c : b)

passwordEntropy :: Int -> Double
passwordEntropy n = fromIntegral n * logBase 2 95

prompServiceName :: IO String
prompServiceName = do
  putStr "Write the service for which you want to save the password: "
  hFlush stdout
  serviceNameInput <- getLine
  if null serviceNameInput
    then do
      putStrLn "You are not able to leave the input field blank."
      prompServiceName
    else return serviceNameInput

prompPasswordLength :: String -> IO ()
prompPasswordLength serviceNameInput = do
  username <- getLoginName
  let passwordStoragePath = "/home/" ++ username ++ "/passwd.yaml"
  putStrLn passwordStoragePath
  putStr "Write down the desired password length: [12] "
  hFlush stdout
  lengthPwdInput <- getLine
  let passwordLength =
        if null lengthPwdInput
          then 12
          else read lengthPwdInput :: Int

  if passwordLength < 4 || passwordLength == 0
    then do
      putStrLn "Invalid password length. Please enter a length of at least 4 characters."
      prompPasswordLength serviceNameInput
    else proceedWithPassword passwordLength serviceNameInput

proceedWithPassword :: Int -> String -> IO ()
proceedWithPassword passwordLength serviceNameInput = do
  let entropy = passwordEntropy passwordLength
  when (entropy < 75) $ do
      putStr "The entropy is less than 75. Do you want to continue? [y/n] "
      hFlush stdout
      entropyStrengthInput <- getLine
      if entropyStrengthInput `elem` ["y", "Y"]
        then return ()
        else do
          putStr "Do you want to repeat password generation? [Y/n] "
          hFlush stdout
          repeatField <- getLine
          if repeatField `elem` ["", "y", "Y"] then runD else exitSuccess

  pwd <- generation passwordLength
  printf "%s [%.2f]\n" pwd entropy
  putStr "Do you want to save this password? [Y/n] "
  hFlush stdout
  savePwdResult <- getLine
  if savePwdResult `elem` ["", "y", "Y"]
    then do
      putStrLn "Saving..."
      outputText serviceNameInput pwd entropy
    else do
      putStr "Do you want to repeat password generation? [Y/n] "
      hFlush stdout
      repeatPasswordGeneration <- getLine
      if repeatPasswordGeneration `elem` ["", "y", "Y"]
        then runD
        else exitSuccess

runD :: IO ()
runD = do
 serviceNameInput <- prompServiceName
 prompPasswordLength serviceNameInput
