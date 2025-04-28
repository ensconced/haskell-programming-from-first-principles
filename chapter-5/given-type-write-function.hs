module GivenTypeWriteFunction where

i :: a -> a
i x = x

c :: a -> b -> a
c a b = a

c' :: a -> b -> b
c' a b = b

r :: [a] -> [a]
r x = take 1 x

co :: (b -> c) -> (a -> b) -> (a -> c)
co f g = f . g

a :: (a -> c) -> a -> a
a f x = x

a' :: (a -> b) -> a -> b
a' = ($)
