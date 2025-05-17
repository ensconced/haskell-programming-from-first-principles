foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f acc [] = acc
foldr f acc (x : xs) = f x (foldr f acc xs)

-- foldr (+) 0 [1, 2, 3]
-- f := (+), acc := 0, x := 1, xs := [2, 3]
-- (+) 1 (foldr (+) 0 [2, 3])
-- f := (+), acc := 0, x := 2, xs := [3]
-- (+) 1 ((+) 2 (foldr (+) 0 [3]))
-- f := (+), acc := 0, x := 3, xs := []
-- (+) 1 ((+) 2 ((+) 3 (foldr (+) 0 [])))
-- f := (+), acc := 0
-- (+) 1 ((+) 2 ((+) 3 0))
-- (+) 1 ((+) 2 3)
-- (+) 1 5
-- 6

-- foldr const 0 [1, 2, 3]
-- f := const, acc := 0, x := 1, xs := [2, 3]
-- const 1 (foldr const 0 [2, 3])
-- 1

-- foldr (\_ _ -> 9001) 0 [1..5]
-- f := (\_ _ -> 9001), acc := 0, x := 1, xs := [2..5]
-- (\_ _ -> 9001) 1 (foldr (\_ _ -> 9001) 0 [2..5])
-- 9001

-- foldr (\_ _ -> 9001) 0 [1, 2, 3, undefined]
-- f := (\_ _ -> 9001), acc := 0, x := 1, xs := [2, 3, undefined]
-- (\_ _ -> 9001) 1 (foldr (\_ _ -> 9001) 0 [2, 3, undefined])
-- 9001

-- foldr (\_ _ -> 9001) 0 ([1, 2, 3] ++ undefined)
-- f := (\_ _ -> 9001), acc := 0, x: 1, xs := (2 : (3 : undefined))
-- (\_ _ -> 9001) 1 (foldr (\_ _ -> 9001) 0 (2 : (3 : undefined)))
-- 9001

-- foldr (\_ _ -> 9001) 0 undefined
-- errors

-- foldr (\_ _ -> 9001) 0 (1: (undefined : []))
-- f := (\_ _ -> 9001), acc := 0, x := 1, xs := (undefined : [])
-- (\_ _ -> 9001) 1 (foldr (\_ _ -> 9001) 0 (undefined : []))
-- 9001

-- foldr (\_ _ -> 9001) 0 (undefined : (undefined : []))
-- f := (\_ _ -> 9001), acc := 0, x := undefined, xs := (undefined : [])
-- (\_ _ -> 9001) undefined (foldr (\_ _ -> 9001) 0 (undefined : []))
-- 9001

-- const 1 2
-- 1

-- const 2 1
-- 2

-- foldr const 0 [1..5]
-- foldr const 0 (1:  (2 : (3 : (4 : (5 : [])))))
-- f := const, acc := 0, x := 1, xs := (2 : (3 : (4 : (5 : []))))
-- const 1 (foldr const 0 (2 : (3 : (4 : (5 : [])))))
-- 1

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f acc [] = acc
foldl f acc (x : xs) = foldl f (f acc x) xs

-- foldl (+) 0 [1, 2, 3]
-- foldl (+) 0 (1 : (2 : (3 : [])))
-- f := (+), acc := 0, x := 1, xs := (2 : (3 : []))
-- foldl (+) ((+) 0 1) (2 : (3 : []))
-- f := (+), acc := ((+) 0 1), x := 2, xs := (3 : [])
-- foldl (+) ((+) ((+) 0 1) 2) (3 : [])
-- f := (+), acc += ((+) ((+) 0 1) 2), x := 3, xs := []
-- foldl (+) ((+) ((+) ((+) 0 1) 2) 3) []
-- f := (+), acc := ((+) ((+) ((+) 0 1) 2) 3)
-- ((+) ((+) ((+) 0 1) 2) 3)
-- ((+) ((+) 1 2) 3)
-- ((+) 3 3)
-- 6

-- foldr (^) 2 [1..3]
-- foldr (^) 2 (1 : (2 : (3 : [])))
-- f x (foldr f acc xs)
-- f := (^), acc := 2, x := 1, xs := (2 : (3 : []))
-- (^) 1 (foldr (^) 2 (2 : (3 : [])))
-- f := (^), x := 2, acc := 2, xs := (3 : [])
-- (^) 1 ((^) 2 (foldr (^) 2 (3 : [])))
-- f := (^), x := 3, acc := 2, xs := []
-- (^) 1 ((^) 2 ((^) 3 (foldr (^) 2 [])))
-- (^) 1 ((^) 2 ((^) 3 2))
-- (^) 1 ((^) 2 9)
-- (^) 1 512
-- 1

-- foldl (^) 2 [1..3]
-- foldl (^) 2 (1 : (2 : (3 : [])))
-- f := (^), acc := 2, x := 1, xs := (2 : (3 : []))
-- foldl (^) ((^) 2 1) (2 : (3 : []))
-- f := (^), acc := ((^) 2 1), x := 2, xs := (3 : [])
-- foldl (^) ((^) ((^) 2 1) 2) (3 : [])
-- f := (^), acc := ((^) ((^) 2 1) 2), x := 3, xs := []
-- foldl (^) ((^) ((^) ((^) 2 1) 2) 3) []
-- acc := ((^) ((^) ((^) 2 1) 2) 3)
-- ((^) ((^) ((^) 2 1) 2) 3)
-- ((^) ((^) 2 2) 3)
-- ((^) (4 3)
-- 64

-- foldr f acc [] = acc
-- foldr f acc (x : xs) = f x (foldr f acc xs)

-- foldr (:) [] [1..3]
-- foldr (:) [] (1 : (2 : (3 : [])))
-- f := (:), acc := [], x := 1, xs := (2 : (3 : []))
-- (:) 1 (foldr (:) [] (2 : (3 : [])))
-- f := (:), acc := [], x := 2, xs := (3 : [])
-- (:) 1 ((:) 2 (foldr (:) [] (3 : [])))
-- f := (:), acc := [], x := 3, xs := []
-- (:) 1 ((:) 2 ((:) 3 (foldr (:) [] [])))
-- acc := []
-- (:) 1 ((:) 2 ((:) 3 []))
-- 1 : (2 : (3 : []))

-- foldl f acc [] = acc
-- foldl f acc (x : xs) = foldl f (f acc x) xs

-- foldl (flip (:)) [] [1..3]
-- foldl (flip (:)) [] (1 : (2 : (3 : [])))
-- f := flip (:), acc := [], x := 1, xs := (2 : (3 : []))
-- foldl (flip (:)) ((flip (:)) [] 1) (2 : (3 : []))
-- f := (flip (:)), acc := ((flip (:)) [] 1), x := 2, xs := (3 : [])
-- foldl (flip (:)) ((flip (:)) ((flip (:)) [] 1) 2) (3 : [])
-- f := (flip (:)), acc := ((flip (:)) ((flip (:)) [] 1) 2), x := 3, xs := []
-- foldl (flip (:)) ((flip (:)) ((flip (:)) ((flip (:)) [] 1) 2) 3) []
-- acc := ((flip (:)) ((flip (:)) ((flip (:)) [] 1) 2) 3)
-- (flip (:)) ((flip (:)) ((flip (:)) [] 1) 2) 3
-- (flip (:)) ((flip (:)) (1 : []) 2) 3
-- (flip (:)) (2 : (1 : [])) 3
-- 3 : (2 : (1 : []))
-- [3, 2, 1]

-- foldl f acc [] = acc
-- foldl f acc (x : xs) = foldl f (f acc x) xs

-- foldl (flip (*)) 1 [1..3]
-- foldl (flip (*)) 1 (1 : (2 : (3 : [])))
-- f := (flip (*)), acc := 1, x := 1, xs := (2 : (3 : []))
-- foldl (flip (*)) ((flip (*)) 1 1) (2 : (3 : []))
-- f := (flip (*)), acc := ((flip (*)) 1 1), x := 2, xs := (3 : [])
-- foldl (flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) (3 : [])
-- f := (flip (*)), acc := ((flip (*)) ((flip (*)) 1 1) 2), x := 3, xs := []
-- foldl (flip (*)) ((flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) 3) []
-- acc := ((flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) 3)
-- ((flip (*)) ((flip (*)) ((flip (*)) 1 1) 2) 3)
-- ((flip (*)) ((flip (*)) (1 * 1) 2) 3)
-- ((flip (*)) (2 * (1 * 1)) 3)
-- (3 * (2 * (1 * 1)))
-- (3 * (2 * 1))
-- (3 * 2)
-- 6

-- foldr f acc [] = acc
-- foldr f acc (x : xs) = f x (foldr f acc xs)

-- foldr const 0 ([1..5] ++ undefined)
-- foldr const 0 (1 : (2 : (3 : (4 : (5 : undefined)))))
-- f := const, acc := 0, x := 1, xs := (2 : (3 : (4 : (5 : undefined))))
-- const 1 (foldr const 0 (2 : (3 : (4 : (5 : undefined)))))
-- 1

-- foldr (flip const) 0 ([1..5] ++ undefined)
-- foldr (flip const) 0 (1 : (2 : (3 : (4 : (5 : undefined)))))
-- f := (flip const), acc := 0, x := 1, xs := (2 : (3 : (4 : (5 : undefined))))
-- (flip const) 1 (foldr (flip const) 0 (2 : (3 : (4 : (5 : undefined)))))
-- f := (flip const), acc := 0, x := 2, xs := (3 : (4 : (5 : undefined))))
-- (flip const) 1 ((flip const) 2 (foldr (flip const) 0 (3 : (4 : (5 : undefined))))))
-- ...
-- (flip const) 1 ((flip const) 2 ((flip const) 3 ((flip const) 4 (foldr (flip const) 0 (5 : undefined)))))

-- foldl f acc [] = acc
-- foldl f acc (x : xs) = foldl f (f acc x) xs

-- foldl const 0 ([1..5] ++ undefined)
-- foldl const 0 (1 : (2 : (3 : (4 : (5 : undefined)))))
-- f := const, acc := 0, x := 1, xs := (2 : (3 : (4 : (5 : undefined))))
-- foldl const (const 0 1) (2 : (3 : (4 : (5 : undefined))))
-- f := const, acc := (const 0 1), x := 2, xs := (3 : (4 : (5 : undefined)))
-- foldl const (const (const 0 1) 2) (3 : (4 : (5 : undefined)))
-- ...
-- foldl const (const (const (const (const (0 1)) 2) 3) 4) (5 : undefined)