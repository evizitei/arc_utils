import System.Console.ANSI
import Control.Monad (forM_)

-- Define a color mapping type
type ColorInfo = (String, String)  -- (ANSI code, color name)

-- Function to print a colored square with name
printColoredSquare :: ColorInfo -> IO ()
printColoredSquare (code, name) = do
    putStr $ "\ESC[" ++ code ++ "m██ \ESC[0m "  -- Two blocks and a space
    putStrLn name

-- List of colors with their ANSI codes and names
colors :: [ColorInfo]
colors = [ ("30", "Black")       -- Standard black
        , ("34", "Blue")         -- Standard blue
        , ("31", "Red")          -- Standard red
        , ("32", "Green")        -- Standard green
        , ("33", "Yellow")       -- Standard yellow
        , ("90", "Grey")         -- Bright black (grey)
        , ("95", "Pink")         -- Bright magenta (pink)
        , ("33;2", "Brown")      -- Yellow with lower intensity
        , ("94", "Light Blue")   -- Bright blue
        , ("93", "Orange")       -- Bright yellow
        ]

-- Main function
main :: IO ()
main = do
    putStrLn "Here are your requested colors with their closest ANSI equivalents:"
    forM_ colors printColoredSquare