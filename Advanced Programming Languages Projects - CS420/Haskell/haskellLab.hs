------------- CS 420 : Advanced Programming Languages -----------------

---------- Assignment 2 : Functional Prgamming on Haskell -------------

-----------------------------------------------------------------------


-- Runs the script without including prelude library 
{-# LANGUAGE NoImplicitPrelude #-}


module Assign2 where

-- import basic functions needed from prelude library
-- all element functions are supported.
-- map and elem are supported. 

import ModifiedPrelude

-----------------------------------------------------------------------

-- PART A

-- Question 1

-- Sum of all the elements of a list
--
-- >>> sumList [1, 2, 3, 4]
-- 10
--
-- >>> sumList [1, -2, 3, 5]
-- 7
--
-- >>> sumList [1, 3, 5, 7, 9, 11]
-- 36

sumList :: [Int] -> Int
sumList = foldr (+) 0 


-- Question 2

-- `digitsOfInt n` should return `[]` if `n` is <=0,
--    and otherwise returns the list of digits of `n` in the
--    order in which they appear
--
-- >>> digitsOfInt 3124
-- [3, 1, 2, 4]
--
-- >>> digitsOfInt 352663
-- [3, 5, 2, 6, 6, 3]


digitsOfInt :: Int -> [Int]
digitsOfInt x 
    | x <= 0 = []
    | otherwise = digitsOfInt (x `div` 10) ++ [x `mod` 10] 


-- Question 3

-- | `digits n` retruns the list of digits of `n`
--
-- >>> digits 31243
-- [3,1,2,4,3]
--
-- digits (-23422)
-- [2, 3, 4, 2, 2]

digits :: Int -> [Int]
digits n = []


-- Question 4

--   Additive persistence is the process of taking a number, adding its digits,
--   then adding the digits of the number derived from it, etc.,
--   until the remaining number has only one digit.
--
--   The number of additions required to obtain a single digit
--   from a number n is called the additive persistence of n.
--
--   For example, the sequence obtained from the starting number
--   9876 is (9876, 30, 3), so 9876 has
--   an additive persistence of 2
--
-- NOTE: assume additivePersistence is only called with positive numbers
--
-- >>> additivePersistence 9876
-- 2

additivePersistence :: Int -> Int
additivePersistence x 
    | x < 10 = 0
    | otherwise = 1 + additivePersistence(sumList(digitsOfInt x ))

-- Question 5

--   DigitalRoot n is the digit obtained at the end of the sequence
--   computing the additivePersistence
--
--   For example, the sequence obtained from the starting number
--   9876 is (9876, 30, 3), so 9876 has
--   a digital root of 3.
--
-- NOTE: assume digitalRoot is only called with positive numbers
--
-- >>> digitalRoot 9876
-- 3

digitalRoot :: Int -> Int
digitalRoot x 
    | x < 10 = x
    | otherwise = digitalRoot(sumList(digitsOfInt(x)))

-- Question 6

-- listReverse [x1,x2,...,xn] returns [xn,...,x2,x1]
--
-- >>> listReverse []
-- []
--
-- >>> listReverse [1,2,3,4]
-- [4,3,2,1]
--
-- >>> listReverse ["i", "want", "to", "ride", "my", "bicycle"]
-- ["bicycle", "my", "ride", "to", "want", "i"]

listReverse :: [a] -> [a]
listReverse [] = []
listReverse (x:xs) = listReverse xs ++ [x]

-- Question 7

-- A string which has the property of reading the same 
-- forwards as it does backwards
--
-- >>> palindrome "malayalam"
-- True
--
-- >>> palindrome "myxomatosis"
-- False

palindrome :: String -> Bool
palindrome [] = True
palindrome x = listReverse x == x 

-- Question 8
--
-- Compute all the digital rool of all elements in the list 
--
-- >>> rootList [10, 11, 12]
-- [1, 2, 3]

rootList :: [Int] -> [Int]
rootList [] = [] 
rootList (x:xs) = [digitalRoot x] ++ rootList xs

-----------------------------------------------------------------------

-- PART B

-- Questions 9 to 13 should be solved using recurrsion ONLY


-- Question 9

--  `assoc def key [(k1,v1), (k2,v2), (k3,v3);...])`
--   searches the list for the first i such that `ki` = `key`.
--   If such a ki is found, then vi is returned.
--   Otherwise, if no such ki exists in the list, `def` is returned.
--

-- >>> assoc 0 "william" [("ranjit", 85), ("william",23), ("moose",44)])
-- 23
--
-- >>> assoc 0 "bob" [("ranjit",85), ("william",23), ("moose",44)]
-- 0

assoc :: Int -> String -> [(String, Int)] -> Int
assoc def key pairs = go pairs
    where 
        go [] = def
        go ((ki, vi): xs) 
            | ki == key  = vi
            | otherwise = go xs


-- Question 10

--   returns the list of elements of `l` with duplicates
--   that is, second, third ... occurrences, removed,
--   and where the remaining elements appear in the
--   same order as in l.

-- >>> removeDuplicates [1,6,2,4,12,2,13,12,6,9,13]
-- [1,6,2,4,12,13,9]


removeDuplicates :: [Int] -> [Int]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates [y | y <- xs, y /= x]

-- Question 11

-- `wwhile f x` returns `x'` where there exist values
--      `v_0`,...,`v_n` such that
--      - `x` is equal to `v_0`
--      - `x'` is equal to `v_n`
--      - for each `i` between `0` and `n-2`, we have `f v_i` equals `(true, v_i+1)`
--      - `f v_n-1` equals `(false, v_n)`.


ff:: Int -> (Bool, Int)
ff x = (xx < 100, xx)
      where xx = x * x * x

-- >>> wwhile ff 2
-- 512

wwhile :: (a -> (Bool, a)) -> a -> a
wwhile f x  |  v  = wwhile f y
            | otherwise  = y
        where 
            (v, y) = f x


-- Question 12

-- `fixpointL f x0` which returns
--     the list [x_0, x_1, x_2, x_3, ... , x_n]
--     where
--     * x = x_0
--     * f x_0 = x_1, f x_1 = x_2, f x_2 = x_3, ... f x_n = x_{n+1}
--     * xn = x_{n+1}

collatz :: Int -> Int
collatz 1 = 1
collatz n | even n    = n `div` 2
          | otherwise = 3 * n + 1

gg :: Int -> Int
gg x = truncate (1e6 * cos (1e-6 * fromIntegral x))

-- >>> fixpointL collatz 1
-- [1]
-- >>> fixpointL collatz 2
-- [2,1]
-- >>> fixpointL collatz 3
-- [3,5,8,2,1]
-- >>> fixpointL collatz 4
-- [4,1]
-- >>> fixpointL collatz 5
-- [5,8,2,1]
-- >>> fixpointL gg 0
-- [0, 1000000, 540302, 857553, 654289, 793480,701369,763959,
--  722102,750418,731403,744238,735604,741425,737506,740147,738369,
--  739567,738760,739304,738937,739184,739018,739130,739054,739106,
--  739071,739094,739079,739089,739082,739087,739083,739086,739084,739085]
-- this is because cos 0.739085 is approximately 0.739085

fixpointL :: (Int -> Int) -> Int -> [Int]
fixpointL f x 
    | v == x  = [x]
    | otherwise = [x] ++ fixpointL f v 
    where 
        v = f x


-- Question 12

-- Now refactor your implementation of `fixpointL` so that it just returns
-- the LAST element of the list, i.e. the `xn` that is equal to `f xn`

-- >>> fixpointW collatz 1
-- 1
-- >>> fixpointW collatz 2
-- 1
-- >>> fixpointW collatz 3
-- 1
-- >>> fixpointW collatz 4
-- 1
-- >>> fixpointW collatz 5
-- 1
-- >>> fixpointW g 0
-- 739085

fixpointW :: (Int -> Int) -> Int -> Int
fixpointW f x 
    | f x == x  = x
    | otherwise = fixpointW f (f x) 

-----------------------------------------------------------------------

-- PART C

-- Questions 14 to 16 should be solved using foldr ONLY


-- Question 14

-- sqSum [x1, ... , xn] should return (x1^2 + ... + xn^2)
--
-- >>> sqSum []
-- 0
--
-- >>> sqSum [1,2,3,4]
-- 30
--
-- >>> sqSum [(-1), (-2), (-3), (-4)]
-- 30

sqSum :: [Int] -> Int
sqSum = foldr (\x acc -> x * x + acc) 0



-- Question 15

-- `pipe [f1,...,fn] x` should return `f1(f2(...(fn x)))`
--
-- >>> pipe [] 3
-- 3
--
-- >>> pipe [(\x -> x+x), (\x -> x + 3)] 3
-- 12
--
-- >>> pipe [(\x -> x * 4), (\x -> x + x)] 3
-- 24

pipe :: [(a -> a)] -> (a -> a)
pipe f x = foldr (\f acc -> f acc) x f


-- Question 16

-- `sepConcat sep [s1,...,sn]` returns 
--         `s1 ++ sep ++ s2 ++ ... ++ sep ++ sn`
--
-- >>> sepConcat "---" []
-- ""
--
-- >>> sepConcat ", " ["foo", "bar", "baz"]
-- "foo, bar, baz"
--
-- >>> sepConcat "#" ["a","b","c","d","e"]
-- "a#b#c#d#e"

nullList :: [a] -> Bool
nullList [] = True
nullList xs = False

sepConcat :: String -> [String] -> String
sepConcat xs = foldr (\strList acc -> if nullList acc then strList else strList ++ xs ++ acc ) "" 


-- Question 17

-- This question does not require recurrsion or fold
-- Solve it using in-build map function

intString :: Int -> String
intString = show

-- `stringOfList pp [x1,...,xn]` uses the element-wise 
--  printer `pp` to convert the element-list into a string:
--
-- >>> stringOfList intString [1, 2, 3, 4, 5, 6]
-- "[1, 2, 3, 4, 5, 6]"
--
-- >>> stringOfList (\x -> x) ["foo"]
-- "[foo]"
--
-- >>> stringOfList (stringOfList show) [[1, 2, 3], [4, 5], [6], []]
-- "[[1, 2, 3], [4, 5], [6], []]"

myAwesomeMap :: (a -> b) -> [a] -> [b]
myAwesomeMap f xs = foldr mapHelper [] xs
    where 
        mapHelper x acc = f x : acc

stringOfList :: (a -> String) -> [a] -> String
stringOfList fs xs = "[" ++ sepConcat ", " (myAwesomeMap fs xs) ++ "]" 


-- Question 18 & 19 uses a new type
-- BigInt = [Int]

type BigInt = [Int]


-- Question 18 
-- You will be writing three helper functions to solve Question 19 

-- `clone x n` returns a `[x,x,...,x]` containing `n` copies of `x`
--
-- >>> clone 3 5
-- [3,3,3,3,3]
--
-- >>> clone "foo" 2
-- ["foo", "foo"]

clone :: a -> Int -> [a]
clone x n 
    | (n <=0) = []
    | otherwise = [x] ++ clone x (n - 1)
  


-- `padZero l1 l2` returns a pair (l1', l2') which are the input lists,
--  padded with extra `0` on the left such that the lengths of `l1'` 
--  and `l2'` are equal.
--
-- >>> padZero [9,9] [1,0,0,2]
-- ([0,0,9,9], [1,0,0,2])
--
-- >>> padZero [1,0,0,2] [9,9]
-- ([1,0,0,2], [0,0,9,9])

padZero :: BigInt -> BigInt -> (BigInt, BigInt)
padZero xs ys 
    | length xs < length ys = (clone 0 (length ys - length xs) ++ xs, ys)
    | otherwise             = ( xs, clone 0 (length xs - length ys) ++ ys)


-- | `removeZero ds` strips out all leading `0` from the left-side of `ds`.
--
-- >>> removeZero [0,0,0,1,0,0,2]
-- [1,0,0,2]
--
-- >>> removeZero [9,9]
-- [9,9]
--
-- >>> removeZero [0,0,0,0]
-- []

removeZero :: BigInt -> BigInt
removeZero [] = []
removeZero (0:xs) =  removeZero xs
removeZero xs = xs


-- Question 19
-- You will be writing 3 functions in this code. This problem is hard. 


-- `bigAdd n1 n2` returns the `BigInt` representing the sum of `n1` and `n2`
--
-- >>> bigAdd [9, 9] [1, 0, 0, 2]
-- [1, 1, 0, 1]
--
-- >>> bigAdd [9, 9, 9, 9] [9, 9, 9]
-- [1, 0, 9, 9, 8]

addList :: ([Int],[Int]) -> [Int]
addList (xs, []) = xs
addList ([], ys) = ys
addList ((x:xs), (y:ys)) = x + y : addList (xs, ys) 
    
fixList :: Int -> [Int] -> [Int]
fixList carry [] = [carry] 
fixList carry (x:xs) = (sum `mod` 10) : fixList (sum `div` 10) xs 


bigAdd :: BigInt -> BigInt -> BigInt
bigAdd xs ys =
    let 
        (paddedListX, paddedListY) = padZero xs ys
        vs = listReverse(addList (paddedListX, paddedListY))
    in listReverse (fixList 0 vs)


-- `mulByDigit i n` returns the result of multiplying
--  the digit `i` (between 0..9) with `BigInt` `n`.
--
-- >>> mulByDigit 9 [9,9,9,9]
-- [8,9,9,9,1]

mulHelper :: Int -> Int -> BigInt -> BigInt
mulHelper 0 n []         = []
mulHelper carry n []     = [carry]
mulHelper carry n (x:xs) 
    | (product) >= 10    = [(product `mod` 10)] ++ mulHelper (product `quot` 10) n xs
    | otherwise          = [product] ++ mulHelper 0 n xs
        where
            product = n * x + carry 


mulByDigit :: Int -> BigInt -> BigInt
mulByDigit n xs = listReverse(mulHelper 0 n (listReverse xs))


-- `bigMul n1 n2` returns the `BigInt` representing the 
--  product of `n1` and `n2`.
--
-- >>> bigMul [9,9,9,9] [9,9,9,9]
-- [9,9,9,8,0,0,0,1]
--
-- >>> bigMul [9,9,9,9,9] [9,9,9,9,9]
-- [9,9,9,9,8,0,0,0,0,1]

bigMul :: BigInt -> BigInt -> BigInt
bigMul xs ys = removeZero (bigMulHelper xs ys)
    where
        bigMulHelper xs [] = []
        bigMulHelper xs (y:ys) = bigAdd (bigMulHelper xs ys) (mulByDigit y xs ++ clone 0 (length ys))  

-----------------------------------------------------------------------