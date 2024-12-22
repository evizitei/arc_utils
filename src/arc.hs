import Data.Aeson (decode)
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified System.Console.ANSI as ANSI
import Control.Monad (forM_)
import Data.List (intercalate)
import Data.Maybe (fromMaybe, isJust)

import Data.Proxy (Proxy(..))

data Color = Black | Blue | Red | Green | Yellow | Grey | Pink | Orange | SkyBlue | Brown
  deriving (Show, Eq, Enum, Bounded, Ord)

newtype ColorRow = ColorRow [Color]
newtype ColorGrid = ColorGrid [ColorRow]


intToColor :: Int -> Color
intToColor n = fromMaybe Black $ lookup n $ zip [0..] [minBound..maxBound]

jsonToColorGrid :: String -> Maybe ColorGrid
jsonToColorGrid jsonStr = do
    intArrays <- decode (BL.pack jsonStr) :: Maybe [[Int]]
    let rows = length intArrays
        cols = if rows > 0 then length (head intArrays) else 0
    let allLengths = map length intArrays
    let wrongSized = any (/= cols) allLengths
    let colorArrays = map (map intToColor) intArrays
    let colorRows = map ColorRow colorArrays
    if wrongSized then Nothing else return $ ColorGrid colorRows

toAnsiCode :: Color -> String
toAnsiCode Black = "38;2;32;32;32"
toAnsiCode Blue = "34"
toAnsiCode Red = "31"
toAnsiCode Green = "32"
toAnsiCode Yellow = "33"
toAnsiCode Grey = "90"
toAnsiCode Pink = "95"
toAnsiCode Orange = "38;5;208"
toAnsiCode SkyBlue = "38;2;135;206;235"
toAnsiCode Brown = "38;2;139;69;19"

toAnsiRow :: ColorRow -> String
toAnsiRow (ColorRow colors) = unwords $ map toAnsiBlock colors

toAnsiGrid :: ColorGrid -> String
toAnsiGrid (ColorGrid rows) = intercalate "\n" $ map toAnsiRow rows

toAnsiBlock :: Color -> String
toAnsiBlock clr = "\ESC[" ++ toAnsiCode clr ++ "m▀▀\ESC[0m"


printColoredSquare :: Color -> IO ()
printColoredSquare clr = do
    putStr $ "\ESC[" ++ toAnsiCode clr ++ "m▀▀\ESC[0m\x200A" 
    print clr

-- Main function
main :: IO ()
main = do
    --let fileInQuestion = "./data/grids/simple_grid.json"
    let fileInQuestion = "./data/grids/big_grid.json"
    gridStr <- readFile fileInQuestion
    case jsonToColorGrid gridStr of
        Nothing -> putStrLn "Failed to parse grid"
        Just grid -> do
            putStrLn "Here is your grid:"
            putStrLn $ toAnsiGrid grid
