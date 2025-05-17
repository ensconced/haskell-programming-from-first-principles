addOne = \x -> x + 1

addOneIfOdd n = case odd n of
  True -> addOne n
  False -> n

addFive = \x y -> (if x > y then y else x) + 5

mflip f x y = f y x
