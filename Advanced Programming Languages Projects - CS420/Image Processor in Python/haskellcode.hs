import System.Environment

-- inverts og image by subtracting 255 by each pixel/num
subtract1 :: [Int] -> [Int]
subtract1 [] = []
subtract1 (x:xs) = (255 - x) : subtract1 xs

-- allows for haskel to grab info from text file and process info accordingly with subtract1
main :: IO ()
main = do
    args <- getArgs 
    let numbers = map read args :: [Int] 
        result = subtract1 numbers
        resultStrings = map show result
        outputString = unwords resultStrings
    putStrLn outputString
