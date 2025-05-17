isItTwo :: Integer -> Bool
isItTwo 2 = True
isItTwo _ = False

f :: (a, b, c) -> (d, e, f) -> ((a, d), (c, f))
f (a, b, c) (d, e, f) = ((a, d), (c, f))