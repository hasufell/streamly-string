module Main where

import System.Environment (getArgs)
import Streamly.Data.Stream (Stream)
import Streamly.Data.Fold (Fold)
import qualified Streamly.Data.Fold as Fold
import qualified Streamly.FileSystem.File as File
import qualified Streamly.Unicode.Stream as Unicode

import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy as T

main :: IO ()
main = do
  (file:s:_) <- getArgs
  c <- case s of
         "streamly" -> getLastCharFromFile   file
         "string"   -> getLastCharFromFile'  file
         "text"     -> getLastCharFromFile'' file
  print c

getLastCharFromFile :: FilePath -> IO (Maybe Char)
getLastCharFromFile file = stream `Fold.drive` fold
 where
  stream :: Stream IO Char
  stream = Unicode.decodeUtf8Chunks $ File.readChunks file

  fold :: Monad m => Fold m a (Maybe a)
  fold = Fold.latest


getLastCharFromFile' :: FilePath -> IO (Maybe Char)
getLastCharFromFile' file = do
  contents <- readFile file
  pure (Just (last contents))

getLastCharFromFile'' :: FilePath -> IO (Maybe Char)
getLastCharFromFile'' file = do
  contents <- T.readFile file
  pure (Just (T.last contents))

