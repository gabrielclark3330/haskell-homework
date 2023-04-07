> module Func.Lec4 where
> import Data.Char

We will cover pattern matching in this lecture.

Let's take a look at the following function.

> lucky :: (Integral a) => a -> String  
> lucky 7 = "LUCKY NUMBER SEVEN!"  
> lucky x = "Sorry, you're out of luck, pal!"  

The type definition indicates that "lucky" takes an
Integral typeclass (Int or Integer) and return a
string. This program matches an input number with the
pattern from top to bottom. In this case, it first
checks if the input is 7, if it is, it prints out the
message and ends the comparison. If it is not, it
continues to the catch all pattern (x in this case). 

> f1 :: Integral a => a -> a-> a -> a
> f1 x y z | x == y = x + z
>                | y == z = y + z
>					  | otherwise = x + y - z

Function f1 checks if x == y first. If this fails, it
checks if y == z. The last statement is a catch-all. 

> factorial :: (Eq p, Num p) => p -> p
> -- check to see if the input is 0 (typeclass Eq since it
> -- matches input with 0).
> -- typeclass Num since it takes n and computes its
> -- factorial
> factorial 0 = 1
> factorial n = n * factorial (n - 1)

Function factorial first checks if the input value is
0. If it is, returns 1. If it is not, it evaluates the
next statement. This function is written as a recursive
function. We'll discuss recursion in the near future.

Note that if you don't have the catch-all statement, it
is possible for an exception to occur. 

> alpha :: Char -> [Char]
> alpha 'w' = "Witawas"
> alpha 'a' = "Alice"
> alpha 'b' = "Bryce"
> alpha 't' = "Timothy"

Don't care is represented as "_". For example, the
following functions emulate fst and snd.

> first :: (a,b) -> a
> first (x,_) = x

> second :: (a,b) -> b
> second (_,y) = y

> lt = [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]
> sumTuple :: Integral a => [(a,a)] -> [a]
> sumTuple xs = [fst (x) + snd (x) | x <- xs]

The above function adds the two values in each tuple on
the list and return a new list. We can also write the
same function using pattern matching.

> sumTuplePM :: Integral a => [(a,a)] -> [a]
> sumTuplePM xs = [a+b | (a,b) <- xs] 

List can also be used in pattern matching. For example,
a pattern like x:xs binds the head of the list to x and
the rest of the list to xs. Note that : is known as the
"cons" operator. For example, [1, 2, 3] is formed by
1:2:3:[] (that is, prepend 3 to empty list => [3], then
prepend 2 to [3] => [2,3], then prepend 1 to [2,3] =>
[1,2,3]). To concatenate two lists, we can use "++"
opeartor.  

The following example illustrates pattern matching in a
list using both : and ++ operators.

> tell :: (Show a) => [a] -> String  
> tell [] = "The list is empty"  
> tell (x:[]) = "The list has one element: " ++ show x  
> tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y  
> tell (x:y:z:_) = "This list is long. The first three elements are: " ++ show x ++ " ," ++ show y ++ ", and " ++ show z  

> --tell [3,4,5,6]
> --tell "This is a long list" 

See the following link for more information about
pattern maching.

http://learnyouahaskell.com/syntax-in-functions#pattern-matching
