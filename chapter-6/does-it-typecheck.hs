x :: Int -> Int
x blah = blah + 20

instance Show (Int -> Int) where
  show a = "bananas"

printIt :: IO ()
printIt = putStrLn (show x)

data Person = Person Bool

instance Show Person where
  show (Person bool) = show bool

printPerson :: Person -> IO ()
printPerson person = putStrLn (show person)

data Mood = Blah | Woot deriving (Show, Eq)

settleDown x = if x == Woot then Blah else x

type Subject = String

type Verb = String

type Object = String

data Sentence = Sentence Subject Verb Object deriving (Eq, Show)

s1 = Sentence "dogs" "drool" "lol"

s2 = Sentence "Julie" "loves" "dogs"