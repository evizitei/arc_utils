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
colors = [ ("38;2;32;32;32", "Black")
        , ("34", "Blue")         
        , ("31", "Red")          
        , ("32", "Green")        
        , ("33", "Yellow")       
        , ("90", "Grey")         
        , ("95", "Pink")         
        , ("38;2;139;69;19", "Brown")      
        , ("38;2;135;206;235", "Light Blue")   
        , ("38;5;208", "Orange")      
        ]

-- Main function
main :: IO ()
main = do
    putStrLn "Here are your requested colors with their closest ANSI equivalents:"
    forM_ colors printColoredSquare