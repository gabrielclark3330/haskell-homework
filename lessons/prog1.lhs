This is our first Haskell program.

> module Func.Lec1 where
> import Data.List

Here are some strings.

> help = words "test alpha1 alpha2 str1 str2 main op var fn1 fn2 sillyFN"
> str1 = "You say goodbye, and I say hello."
> str2 = "Yesterday, all my troubles seem so far away."
> var2 = words "Obladi Oblada"
> main = putStrLn

You can use :t command to check out type information.
More variables:

> test = 5
> alpha1 = 'e'
> alpha2 = 'u'
> op = 5+7+9*2
> var = 123 `mod` 8
> myArr = [1,2,3,4,5.0]
> myArr2 = [1,2,3,4,5]

> sum' :: (Num a) => [a] -> a
> sum' = foldr (+) 0

fn1 number

> fn1 = (^2)

fn2 string

> fn2 = length . words

Lazy evaluation

> sillyFn c = let e = error "Ouch!"
>                 u = undefined
> -- we need to move the line above so that u lines up
> -- with e
>                 in case c of 'e' -> e
>                              'E' -> e
>                              'u' -> u
>                              'U' -> u
>                              otherwise -> "safe"

Try finding the type for safeDiv. 

> safeDiv x y = x `div` y

> safeDiv' x y = let q = x `div` y
>                in if y == 0
>                   then 0
>                   else q

Order independence

> evenN 0 = True
> evenN n = oddN (n-1)
>
> oddN 0 = False
> oddN n = evenN (n-1)


> guessingGame num = do
>   putStrLn "Enter your guess:"
>   guess <- getLine
>   case compare (read guess) num of
>     LT -> do putStrLn "Too low!"
>              guessingGame num
>     GT -> do putStrLn "Too high!"
>              guessingGame num
>     EQ -> putStrLn "You Win!"

use :info name to get info
use :t to see type information
use :q to quit
