> module Func.Lec5 where
> import Data.Char

We will cover the concept of guards in this lecture.

Guards
================================

In the last lecture, I sneaked in a guard example as
part of pattern matching. This is to show that the
concepts are somewhat similar. Here is that example:

> f1 :: Integral a => a -> a-> a -> a
> f1 x y z 
>	| x == y = x + z
>	| y == z = y + z
>	| otherwise = x + y - z

Guards are indicated by pipes that follow a function's
name and its input parameters. In this case, the
function's name is f1 and the parameters are x, y, and
z. A guard is basically a Boolean expression. If it
evaluates to true, then the corresponding function body
is used. If it is false, it continues to evaluate the
next guard. Here is another example:

> myMax :: (Ord a) => a -> a -> a
> myMax a b
>	|	a > b = a
>	|	otherwise = b


Let's revisit an example from prog3.lhs.

> testCompS s1 s2 = s1 `compare` s2
> -- testCompS "Tom" "Thomas"

We can rewrite this function using guards:

> myCompare :: (Ord a) => a -> a -> Ordering
> myCompare s1 s2
>	| s1 > s2 = GT
>	| s1 == s2 = EQ
>	| otherwise = LT

Now, let's write a simple letter grade lookup program
based on an input score.

> grade1 :: (Ord a, Floating a) => a -> Char
> grade1 score 
>	| score / maxPoints * 100 >= 90 = 'A'
>	| score / maxPoints * 100 >= 80 = 'B'
>	| score / maxPoints * 100 >= 70 = 'C'
>	| score / maxPoints * 100 >= 60 = 'D' 
> 	| otherwise = 'F'
>	where maxPoints = 500

Note that this is not a good programming practice since
we are repeating the same equation four times (score /
maxPoints * 100). Instead, we can replace the equation
with a variable name.

> grade2 :: (Ord a, Floating a) => a -> Char
> grade2 score 
>	| finalScore >= 90 = 'A'
>	| finalScore >= 80 = 'B'
>	| finalScore >= 70 = 'C'
>	| finalScore >= 60 = 'D' 
> 	| otherwise = 'F'
>	where finalScore = score / 500 * 100

> grade3 :: (Ord a, Floating a) => a -> Char
> grade3 score 
>    | finalScore >= aRange = 'A'
>    | finalScore >= bRange = 'B'
>    | finalScore >= cRange = 'C'
>    | finalScore >= dRange = 'D' 
>    | otherwise = 'F'
>    where finalScore = score / 500 * 100
>          aRange = 90
>          bRange = 80
>          cRange = 70
>          dRange = 60

> showGrade :: (Ord a, Show a, Floating a) => a -> [Char]
> showGrade score 
>    | score >= aRange = show score ++ " -> " ++ "A"
>    | score >= bRange = show score ++ " -> " ++ "B"
>    | score >= cRange = show score ++ " -> " ++ "C"
>    | score >= dRange = show score ++ " -> " ++ "D" 
>    | otherwise = show score ++ " -> " ++ "F"
>    where (aRange, bRange, cRange, dRange) = (90, 80, 70, 60) 


We can also use string matching in where binding. Here
is an example.

> initials :: String -> String -> String  
> initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
>    where (f:_) = firstname  
>          (l:_) = lastname  

> initials2 :: String -> String
> initials2 name = [f] ++ ". " ++ [l] ++ "."  
>    where nameArray = words name
>          (f:_) = nameArray !! 0 
>          (l:_) = nameArray !! 1 


We use pattern matching in list (f:_) and (l:_) to store the
first character in f and l. We then form a new string
by concatenating f with ". ", l, and ".". 

=====================
Question: What if we would like to take a full name as the
argument. How would we rewrite function initials?
=====================

We can also use let binding to bind values to names.
The following function illustrates how to use let
binding.

> gradeCalc :: Floating a => a -> a -> a -> a 
> gradeCalc lab midterm final =
> -- define each formula below
>      let labScore = lab * labW 
>          midScore = midterm * midW 
>          finScore = final * finW 
> -- define the function below
>      in labScore + midScore + finScore
> -- define the variables below
>      where labW = 0.3
>            midW = 0.25
>            finW = 0.45

> compGrade :: (Floating a) => a -> a -> a
> compGrade raw max = raw / max * 100

It is also possible to use "case" statement. 
The basic format is as follows:

case expression of pattern -> result  
                   pattern -> result  
                   pattern -> result  
                   ...  

Here are two examples of the same function written
using case statements and where with pattern matching.

> describeList :: [a] -> String  
> describeList xs = "The list is " ++ case xs of [] -> "empty."  
>                                                [x] -> "a singleton list."   
>                                                xs -> "a longer list."  

> describeListP :: [a] -> String  
> describeListP xs = "The list is " ++ observe xs  
> -- define function observe below
>    where observe [] = "empty."  
>          observe [x] = "a singleton list."  
>          observe xs = "a longer list."  

For more information, you can visit: http://learnyouahaskell.com/syntax-in-functions
