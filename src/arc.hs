{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeOperators #-}

import GHC.TypeLits

import qualified System.Console.ANSI as ANSI
import Control.Monad (forM_)

data Color = Black | Blue | Red | Green | Yellow | Grey | Pink | Orange | SkyBlue | Brown
  deriving (Show, Eq, Enum, Bounded, Ord)

data Vec (n :: Nat) a where
    VNil :: Vec 0 a
    VCons :: a -> Vec n a -> Vec (n + 1) a

data ColorRow (n :: Nat) where
    ColorRow :: KnownNat n => Vec n Color -> ColorRow n



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


-- Function to print a colored square with name
printColoredSquare :: Color -> IO ()
printColoredSquare clr = do
    putStr $ "\ESC[" ++ toAnsiCode clr ++ "m██ \ESC[0m "  -- Two blocks and a space
    print clr

-- Main function
main :: IO ()
main = do
    putStrLn "Here are your requested colors with their closest ANSI equivalents:"
    forM_ [minBound..maxBound] printColoredSquare