{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Commands.ParseYaml where

import Data.Aeson (FromJSON)
import Data.Text (Text)
import Data.Yaml (ParseException, decodeFileEither)
import GHC.Generics (Generic)

data Record = Record
  { name :: Text,
    password :: Text,
    entropy :: Double
  }
  deriving (Show, Generic)

instance FromJSON Record

yamlOK :: IO ()
yamlOK = do
  result <- decodeFileEither "passwd.yaml" :: IO (Either ParseException [Record])
  case result of
    Left err -> putStrLn $ "Error parsing YAML file: " ++ show err
    Right records -> print records
