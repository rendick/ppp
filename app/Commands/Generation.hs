module Commands.Generation where

import System.Random
import System.IO (hFlush, stdout)

randomChar :: IO Char
randomChar = getStdRandom $ randomR ('0', 'z')

generation :: Int -> IO [Char]
generation 0 = return ""
generation n = randomChar >>= \c -> generation (n-1) >>= \b -> return $ [c] ++ b

passwordEntropy :: Int -> Double
passwordEntropy n = fromIntegral n * logBase 2 94

runD :: IO ()
runD = do 
 let entropy = passwordEntropy 16
 pwd <- generation 16
 putStrLn $ pwd ++ " " ++ "[" ++ show entropy ++ "]"
 putStr "Do you want to save this password? [Y/n] "
 hFlush stdout
 savePwdResult <- getLine
 if savePwdResult == "" 
  then do
   putStrLn "ok"
  else do
   putStrLn "not ok"
   return()
