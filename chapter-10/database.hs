import Data.Time

data DatabaseItem
  = DbString String
  | DbNumber Integer
  | DbDate UTCTime
  deriving (Eq, Ord, Show)

theDatabase :: [DatabaseItem]
theDatabase =
  [ DbDate (UTCTime {utctDay = fromGregorian 1911 5 1, utctDayTime = secondsToDiffTime 34123}),
    DbNumber 9001,
    DbString "Hello, world!",
    DbDate (UTCTime {utctDay = fromGregorian 1921 5 1, utctDayTime = secondsToDiffTime 34123})
  ]

filterDbDate :: [DatabaseItem] -> [UTCTime]
filterDbDate = foldr reduce []
  where
    reduce x acc = case x of
      DbDate time -> time : acc
      _ -> acc

filterDbNumber :: [DatabaseItem] -> [Integer]
filterDbNumber = foldr reduce []
  where
    reduce x acc = case x of
      DbNumber int -> int : acc
      _ -> acc

mostRecent :: [DatabaseItem] -> UTCTime
mostRecent = maximum . foldr reduce []
  where
    reduce x acc = case x of
      DbDate time -> time : acc
      _ -> acc

sumDB :: [DatabaseItem] -> Integer
sumDB = foldr reduce 0
  where
    reduce x acc = case x of
      DbNumber num -> acc + num
      _ -> acc

avgDb :: [DatabaseItem] -> Double
avgDb xs = fromInteger sum / numCount
  where
    sum = sumDB xs
    numCount = foldr reduce 0 xs
      where
        reduce x acc = case x of
          DbNumber num -> acc + 1
          _ -> acc
