{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Commands.ParseYaml where

import Control.Monad (forM_)
import Data.Aeson (FromJSON)
import Data.Text (Text)
import qualified Data.Text as T
import Data.Yaml (ParseException, decodeFileEither)
import GHC.Generics (Generic)
import System.IO (hFlush, stdout)
import System.Posix.User

data Record = Record
  { name :: Text,
    password :: Text,
    entropy :: Double
  }
  deriving (Show, Generic)

instance FromJSON Record

searchByName :: IO ()
searchByName = do
  username <- getLoginName
  let passwordStoragePath = "/home/" ++ username ++ "/passwd.yaml"
  putStrLn passwordStoragePath
  putStr "Enter the name of the password to search for: "
  hFlush stdout
  searchName <- T.pack <$> getLine
  result <- decodeFileEither passwordStoragePath :: IO (Either ParseException [Record])
  case result of
    Left err -> putStrLn $ "Error while parsing YAML file: " ++ show err
    Right records -> do
      let matchingRecords = filter (\r -> name r == searchName) records
      if null matchingRecords
        then putStrLn "No records found."
        else forM_ matchingRecords print

showAllPasswords :: IO ()
showAllPasswords = do
  username <- getLoginName
  let passwordStoragePath = "/home/" ++ username ++ "/passwd.yaml"
  result <- decodeFileEither passwordStoragePath :: IO (Either ParseException [Record])
  case result of
    Left err -> putStrLn $ "Error parsing YAML file: " ++ show err
    Right records -> forM_ records print
