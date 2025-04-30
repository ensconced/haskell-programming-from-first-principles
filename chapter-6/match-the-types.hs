import Data.List (sort)

jung :: [Int] -> Int
jung xs = head (sort xs)

young :: (Ord a) => [a] -> a
young xs = head (sort xs)

mySort :: [Char] -> [Char]
mySort = sort

signifier :: (Ord a) => [a] -> a
signifier xs = head (mySort xs)