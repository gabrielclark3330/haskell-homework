> module Func.Lec6 where
> import Data.Char

As we have seen, handling list operations tends to
naturally be written recursively. This is because a
list is a recursively defined data type. For example,
we can think of a function such as length as:

> length' :: [a] -> Int 
> length' [] = 0
> length' (_:xs) = 1 + length' xs

For example, if we supply [3,4,5,6,7] as the argument
to length', it would perform the following operations:

Winding
length' [3,4,5,6,7]
1: length' [3,4,5,6,7] = 1 + length'[4,5,6,7]
2: length' [4,5,6,7] = 1 + length'[5,6,7]
3: length' [5,6,7] = 1 + length'[6,7]
4: length' [6,7] = 1 + length'[7]
5: length'[7] = 1 + length'[] 

Unwinding
5:length'[7] = 1 + length'[] = 1 
4: length'[6,7] = 1 + length'[7] = 2
3: length'[5,6,7] = 1 + length'[6,7] = 3
2: length'[4,5,6,7] = 1 + length'[5,6,7] = 4
1: length'[3,4,5,6,7] = 1 + length'[4,5,6,7] = 5

Note that length' [] = 0 is referred to as edge
condition. It is a termination point of a recursive
function. 

The key here is that a function does not complete until
it returns (void or a value of a certain type). As
such, when a call is made, but the function does not
return, the recursion is winding. In length', we
recursively call it, each time with a shorter list.
Finally, we call it with length' [], causing the
function to return 0; thus, unwinding. This causes the
computation of the length to occur as the calls unwind. 


Let's look at another function that operates on lists.

> last' :: [a] -> a
> last' (x:[]) = x
> last' (_:xs) = last' xs
>

Edge condition: 

What do you think this function does?

Solution: last.sol

Edge condition: last' (x:[]) = x

How does it work?
last' "hello"

last' (h:[ello]) = last' [ello]
last' (e:[llo]) = last' [llo]
last' (l:[lo]) = last' [lo]
last' (l:[o]) = last' [o]
last' (o:[]) = o
===============================================

This example concatenates lists together.

> (+++) :: [a] -> [a] -> [a]
> [] +++ ys = ys
> (x:xs) +++ ys = x : xs +++ ys
> --try [5,6,7] +++ [12,13,21]

How many edge conditions do we have? What are they?
How does it concatenate lists?

Solution: ppp.sol

(5: 6,7) +++ [12,13,21] = 5 : [6,7] +++ [12,13,21]
(6: 7) +++ [12,13,21] = 5: 6: [7] +++ [12,13,21]
(7:[]) +++ [12,13,21] = 5: 6: 7: [] +++ [12,13,21]
[] +++ [12,13,21] = [12,13,21]

Unwinding:

5: 6: 7:[12,13,21]
5: 6: [7,12,13,21]
5: [6,7,12,13,21]
[5,6,7,12,13,21]

===============================================

> reverse' :: [a] -> [a]
> reverse' [] = []
> reverse' (x:xs) = reverse' xs +++ [x]
 
Again, think about how this function performs its
task.

Solution: reverse.sol

Edge condition: reverse' [] = []

How does this work?

reverse' "Mary"

Winding:
reverse' (M:[ary]) = reverse' [ary] ++ [M]
reverse' (a:[ry]) = reverse' [ry] ++ [a]
reverse' (r:[y]) = reverse' [y] ++ [r]
reverse' (y:[]) = reverse' [] ++ [y]
reverse' [] = []

Unwinding:
reverse' (y:[]) = [] ++ [y]
reverse' (r:[y]) = [y] ++ [r]
reverse' (a:[ry]) = [ry] ++ [a]
reverse' (M:[ary]) = [ary] ++ [M]

===============================================

Next, we'll try recursion with pattern matching.

>-- we'll use pattern matching and guards to write our max' function
> max' :: (Ord a) => [a] -> a  
> max' [] = error "maximum of empty list"  
> max' [x] = x  
> max' (x:xs)   
>     | x > maxTail = x  
>     | otherwise = maxTail  
>    where maxTail = max' xs  

-- How many edge conditions we have? What are they?

-- Given the following list, [5,1,31,2], how does this
function find the maximum value on the list?

Solution: max.sol

max' [5,1,31,2]

1. max' (x:xs) => x = 5, xs = [1,31,2]
2. where maxTail = max' [1,31,2]
3. max' (x:xs) => x = 1, xs = [31,2]
4. where maxTail = max' [31,2]
5. max' (x:xs) => x = 31, xs = [2]
6. where maxTail = max' [2] (reaches an edge condition, now unwinds) 
7. (line 6) x > maxTail => 31 > 2 (first guard) returns 31 
8. (line 4) x > maxTail => 1 > 31 (second guard) returns 31
9. (line 2) x > maxTail => 5 > 31 (second guard) returns 31


===============================================

Last example: Quicksort

Given the following list:

[7,1,6,23,9,12,0,31,3,5]

What are the steps a quicksort algorithm would use to
sort this list?

Solution: quicksort.steps

[7,1,6,23,9,12,0,31,3,5] => 7, [1,6,23,9,12,0,31,3,5]

1: [1,6,0,3,5] ++ [7] ++ [23,9,12,31]

[1,6,0,3,5] => 1, [6,0,3,5]

2: [0] ++ [1] ++ [6,3,5] 

[6,3,5] => 6, [3,5]

3: [3,5] + 6 + []

[3,5] => 3,[5]

4: [] + [3] + [5]

[23,9,12,31] => 23, [9,12,31]

5: [9,12] ++ [23] ++ [31]

[9,12] => 9, [12]

6: [] + [9] + [12]

Now we unwind

6: [9,12]

5: [9,12,23,31]

4: [3,5]

3: [3,5,6]

2: [0,1,3,5,6]

1: [0,1,3,5,6,7,9,12,23,31] 

Here is a Haskell implementation of a quicksort.

> quicksort :: (Ord a) => [a] -> [a]  
> quicksort [] = []  
> quicksort (x:xs) =   
> -- let binding with list comprehension
>     let smallerSorted = quicksort [a | a <- xs, a <= x]  
>         biggerSorted = quicksort [a | a <- xs, a > x]  
>     in  smallerSorted ++ [x] ++ biggerSorted  

-- How many edge conditions we have? What are they?
-- Given the following list: [10,2,7,28,0], how does
this function sort the list?

Solution: quicksort.sol

Edge condition: quicksort [] = []

How does this work?

quicksort [10, 2, 7, 28, 0]

1: quicksort (10:[2,7,28,0]) //(x = 10, xs = [2,7,28,0])
	smallerSorted = quicksort [2,7,0] //(a <= x)
	biggerSortee = quicksort [28] //(a > x)

2: quicksort (2:[7,0])
	smallerSorted = quicksort [0]
	biggerSorted = quicksort [7]

3: quicksort (0:[])
	smallerSorted = quicksort []
	biggerSorted = quicksort []
	returns 0 //([] ++ 0 ++ [])

4: quicksort (7:[])
	smallerSorted = quicksort []
	biggerSorted = quicksort []
	returns 7 //([] ++ 7 ++ [])

5: quicksort (28:[])
	smallerSorted = quicksort []
	biggerSorted = quicksort [](a <= x)
	returns 28 // ([] ++ 28 ++ [])

Now we unwind.

2: quicksort (2:[7,0]) returns [0] ++ [2] ++ [7] => [0,2,7] 

1: quicksort (10:[2,7,28,0]) returns [0,2,7]  ++ [10] ++ [28] => [0,2,7,10,28]

===============================================

For more information, you can visit: http://learnyouahaskell.com/recursion
