> module Func.Fold where
> import Data.Char
> import Data.List

Fold
----

"fold" is the name of a class of HoFs that generalize recursion over lists (and
many other data types, as we'll discover). The pattern represented by fold is so
general, in fact, that it can be used to implement *every primitive recursive
function* on lists. 

-- foldr (right fold)

It folds the list up from the right side. It also has
the current value as the first parameter and the
accumulator as the second parameter (since it folds
from the right side). 

> sum' :: (Num a) => [a] -> a
> sum' = foldr (+) 0

> product' :: (Num a) => [a] -> a
> product' = foldr (*) 1

> power :: (Num  a) => a -> a
> power e = e * e

> applyAll :: (Num a) => [a] -> [a]
> applyAll l = map power l 

> sum''' :: (Num a) => [a] -> a
> sum''' = foldr (\acc x -> acc + x) 0

-- foldl (left fold)

It folds the list up from the left side. The 
function is applied between the starting value and the
head of this list.  

> sum'' :: (Num a) => [a] -> a  
> sum'' = foldl (+) 0  

> product'' :: (Num a) => [a] -> a
> product'' = foldl (*) 1


For more information: see http://learnyouahaskell.com/higher-order-functions#folds
