> module Func.Lec3 where
> import Data.Char

We will cover types and typeclasses in this lecture.

Types
==============

Haskell has a static type system. The type of every
expression is known at compile time. As such, dividing
a Boolean type with some number would be an error that
is caught during compilation. Everything in Haskell has
a type associating with it.

Haskell compiler knows type information using type
inference. This is why when we write a number, it can
infer the type information on its own. 

We'll now use GHCI to examine types of the expressions
below.

> t0 = 'a'
> t1 = True
> t2 = "You say Good-bye, and I say Hello."
> t3 = (False, t0)
> t4 = t2 == t2
> t5 = [3,56,78,29,32,1]
> t6 = [3.2,56.8,77,29,32,1]

Note that when we use :t, it displays the variable name
followed by :: and its type. :: is read as "has type
of". For t2, the output shows:

t2 :: [Char]

This indicates that is a list of characters (or
a string). For t3, the output shows:

t3 :: (Bool, Char)

This indicates a tuple with the first element is a
Boolean type and the second element is the Char type.  

Common Types
===============
- Int
- Integer
- Float
- Double
- Bool
- Char

Note that Int type stands for integer. It is bound by the
address space in your system (32-bit or 64-bit).
Integer type on the other hand, has no bound. However,
manipulating it is not as efficient as manipulating
Int. 

> --factorial :: Int -> Int
> factorial n = product [1..n]

> factorialBig :: Integer -> Integer
> factorialBig n = product [1..n]

Float is a real floating point with single precision.

Double is a real floating point with double precision.

Bool is a Boolean type that can have values of True and False.

Char represents a character denoted by single quotes. 

String is a synonym for [Char]. 

Function Types
==============

Functions also have types. When we write a function, we
can choose to have an explicitly type declaration,
which is a good programming practice. 

Here is an example of a function that removes any
character that is not an upper-case letter.

> --delUpperCase :: String -> String 
> delLowerCase :: [Char] -> [Char]
> delLowerCase st0 = [st1 | st1 <- st0, st1 `elem` ['A'..'Z']]

Function delLowerCase takes one argument, st0 which is
[Char] (or its synonym "String"). This is written in
list comprehension format so we need to consider the
left side and the right side of the pipe symbol (|).
the function forms the new string (st1) using only the
upper-cases in st0. The predicate states that st1 must
include only elements from the list that includes A to
Z. As such, delLowerCase has a type of [Char] ->
[Char]; it takes a string as an input and returns a
string.   

Type variables and polymorphic functions
================

Given the following expression:

> -- Note that t5 = [3,56,78,29,32,1]
> headTest1 = head t5
> headTest2 = head 

When evaluated, headTest1 returns 3 since this is the
head of t5, which is a list of integers. The type of
headTest1 is:

headTest1 :: Integer

On the other hand, headTest2 takes any list argument
and thus, its type is:

headTest2 :: [a] -> a

Similarly, if we issue ":t head" in GHCI, the type of the
built-in function "head" is:

head :: [a] -> a

What is a? Is it a type? The answer is no. It is a
*type variable*. In this case, a can be any type since
head can return the head of a list of any type.  Thus,
the type declaration of head states that it takes a
list of any type and returns one element of that type.

Note that this type of function is called polymorphic.
These functions are still well-typed, but their types
morph according to the types of arguments. 


Function fst returns the first element of a tuple; 
therefore fst is also polymorphic since the first
element of a tuple can be any type. 
Here is an example:

> fstTest = fst t3

If we issue ":t fstTest" in GHCI, it displays:

fstTest :: Bool

However if we issue ":t fst" in GHCI, it displays:

fst :: (a, b) -> a

In this case, it is showing that it returns the
same type as the tuple first element. 

Typeclasses
================

If a type is a part of a typeclass, it would then
support and implement the behavior of that typeclass.

> sumList :: Num a => [a] -> a 
> -- sumList :: [Int] -> Int
> sumList l = sum l

Note that => is a class constraint symbol.  In this
case, since the built-in function "sum" can work on
Int, Integer, Float, and Double, we simply define a
type variable "a" as being a member of Num class.  Also
note that Num is a constraint class and not a type.


Here is another example:

> combine :: Num b => b -> b -> b -> b
> -- combine :: Num -> Num -> Num -> Num
> combine x y z = sum [x,y,z]

It states that function "combine" takes three
arguments and returns a value; all must be a member of Num class. 

However, if we only restrict the typeclass to only
include whole numbers (Int and Integer) and no floating
points, we would use "Integral".

"Floating" refers to a typeclass that only includes
float and double. 

Function "fromIntegral" converts an Integral input into
a Num output. Here is an example:

> testInt = fromIntegral (head [1, 2, 3]) + 4.245 

fromIntegral :: (Integral a, Num b) => a -> b
 
Similarly, functions such as "==" or "/=" are also 
polymorphic since they can be applied to different
types (e.g., Int == Int, Float == Float, Char == Char).
As such, their type is:

(==) :: Eq a => a -> a -> Bool
(/=) :: Eq a => a -> a -> Bool

For functions such as max, min, ">", "<", ">=", and "<=", their
type is:

(>=) :: Ord a => a -> a -> Bool

We can also use a compare function to return 
the result of typeclass Ord. 

(compare) :: Ord a => a -> a -> Ordering

> testCompS s1 s2 = s1 `compare` s2
> --testCompS "Tom" "Thomas"

> testCompI i1 i2 = i1 `compare` i2
> --testCompI 78 90


See the following link for more information about types
and typeclasses.

http://learnyouahaskell.com/types-and-typeclasses
