guessMe1 x y z | x == y = x + z
 | y == z = y + z
 | otherwise = x + y + z


f2 :: (Ord a) => [a] -> a
f2 [] = error "You cannot do this!"
f2 [x] = x
f2 (x:xs)
 | x > f2' = x
 | otherwise = f2'
 where f2' = f2 xs

f0 :: (Eq p, Num p) => p -> p
f0 0 = 1
f0 n = n * f0 (n - 1)
