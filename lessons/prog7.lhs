> module Func.Lec7 where
> import Data.Char

We'll continue with recursion in this lecture.

Designing recursive functions:
1. Determine the function type.
2. Define one or more edge conditions (e.g., an edge case for a list is empty list, an edge for a tree is a node with no children.).

3. Define a function that operates on a subset of elements and then apply it to the rest of the elements. 
4. Ensure that the values are "shrunk" in recursive calls.

Example 1: function sum'

Create a sum' function that sums up integer values from 0 to N.

1. Type: sum' :: Int -> Int 
2. Edge: sum' 0 = 0
3. Recursion: sum' n = n + sum' (n-1)
4. (n-1) is smaller than n so the values shrink

> sum' :: Int -> Int
> sum' 0 = 0
> sum' n = n + sum' (n - 1)

sum' 4

1: 4 + sum' (3)
2: 3 + sum' (2)
3: 2 + sum' (1)
4: 1 + sum' (0)

Now we unwind:

4: returns 1
3: returns 2 + (1)
2: returns 3 + (2 + 1)
1: returns 4 + (3 + 2 + 1) 

Example 2: function nSqrt' 

Create a function that uses Newton's method for finding
the square root of N starting with a guess g. Next,
test if g is sufficient.  

r = 0.5 * (g + (n/g)) where g is a guess that is between 1 and n.

For example, we have n = 9. Thus, we know that square-root of n = 3. 
Let's apply this method.

Start with g = n = 9: r = 0.5 * (9 + (9/9)) = 5
Repeat with using r for g: r = 0.5 * (5 + (9/5)) = 3.4
Repeat with using r for g: r = 0.5 * (3.4 + (9/3.4)) = 3.02
Repeat with using r for g: r = 0.5 * (3.02 + (9/3.02)) = 3.00    

Once the number reach 3.0x, it continues to stay at
3.0x with closer tolerance to the actual square-root.

Let's try again with g = 2: r = 0.5 * (2 + (9/2)) = 3.25
Repeat with using r for g: r = 0.5 * (3.25 + (9/3.25)) = 3.01
Repeat with using r for g: r = 0.5 * (3.01 + (9/3.01)) = 3.00

We need to create a function that checks if a guess
is good enough. We will call this function "check". 

1. Type: 
		nSqrt :: (Floating a, Ord a) => a -> a 

2. Edge: when abs (g^2 -x ) < 0.0000001 (tolerance) 

3. Recursion: check g | abs (g^2 - x) < 0.000001 = g 
							 | otherwise = check ((g + x/g) * 0.5)

4. As shown, the value of g converges toward the actual
square-root value. 

> nSqrt :: (Floating a, Ord a) => a -> a
> nSqrt x = check (x)
>   where check g | tolerance g = g 
>                	| otherwise = check (newGuess g)
>         newGuess g = (g + x/g) / 2
>         tolerance g = abs (g^2 - x) < 0.000001

Tail Resursive:

We revisit the "reverse" function.

> reverse' :: [a] -> [a]
> reverse' [] = []
> reverse' (x:xs) = reverse' xs ++ [x]

reverse' "Mary"

1: reverse' (M:[ary]) = reverse' [ary] ++ [M]
2: reverse' (a:[ry]) = reverse' [ry] ++ [a]
3: reverse' (r:[y]) = reverse' [y] ++ [r]
4: reverse' (y:[]) = reverse' [] ++ [y]
5: reverse' [] = []
4: [] ++ [y]
3: [y] ++ [r]
2: [yr] ++ [a]
1: [yra] ++ [M]
result = [yraM]

This approach uses recursion to break down the list. It
then reconstructs the reverse list by unwinding.
However, we can rewrite the reverse function using a
different approach as shown below.

> reverse'' :: [a] -> [a] -> [a]
> reverse'' [] r = r
> reverse'' (x:xs) r = reverse'' xs (x:r)

reverse'' "Mary" ""

1: reverse'' (M:[ary]) []  = reverse'' [ary] (M:[])
2: reverse'' (a:[ry]) [M] = reverse'' [ry] (a:[M])
3: reverse'' (r:[y]) [aM] = reverse'' [y] (r:[aM])
4: reverse'' (y:[]) [raM] = reverse'' [] (y:[raM])
Result = "yraM"


