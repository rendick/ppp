module Commands.Generation where

import System.Exit (exitSuccess)
import System.IO (hFlush, stdout)
import System.Random
import Text.Printf

randomChar :: IO Char
randomChar = getStdRandom $ randomR ('0', 'z')

generation :: Int -> IO [Char]
generation 0 = return ""
generation n = randomChar >>= \c -> generation (n - 1) >>= \b -> return $ [c] ++ b

passwordEntropy :: Int -> Double
passwordEntropy n = fromIntegral n * logBase 2 94

prompServiceName :: IO String
prompServiceName = do
  putStr "Write the service for which you want to save the password: "
  hFlush stdout
  serviceNameInput <- getLine

  if serviceNameInput `elem` [""]
    then do
      putStrLn "You are not able to leav ethe input field blank."
      prompServiceName
    else
      return serviceNameInput

prompPasswordLength :: IO ()
prompPasswordLength = do
  putStr "Write down the desired password length: [16] "
  hFlush stdout
  lenghtPwdInput <- getLine
  let passwordLength = if null lenghtPwdInput then 16 else read lenghtPwdInput :: Int
  if passwordLength < 16
    then do
      putStr "Do you really want to use a password less than 16 characters long? [y/N] "
      hFlush stdout
      lenghtLine <- getLine
      if lenghtLine `elem` ["", "n", "N"]
        then do
          putStrLn "Exiting."
          exitSuccess
        else return ()
    else
      return ()

  let entropy = passwordEntropy (passwordLength :: Int)
  pwd <- generation (passwordLength :: Int)
  printf "%s [%.2f]\n" pwd entropy
  putStr "Do you want to save this password? [Y/n] "
  hFlush stdout
  savePwdResult <- getLine
  if savePwdResult `elem` ["", "y", "Y"]
    then do
      putStrLn "Saving..."
    else do
      putStrLn "Exiting."
      exitSuccess

runD :: IO ()
runD = do
  serviceNameInput <- prompServiceName
  putStrLn serviceNameInput
  prompPasswordLength
