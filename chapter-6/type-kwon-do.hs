arith :: (Num b) => (a -> b) -> Integer -> a -> b
arith atob int a = atob a + fromInteger int
