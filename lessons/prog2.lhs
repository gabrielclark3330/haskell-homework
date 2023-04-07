This is our second Haskell program.

> module Lect.Lect02 where
> import Data.List

========= More Function Examples =======

We'll continue to explore functions in Haskell.
There are several examples below. Each operates on
a string called "msg".

> msg = "dud nan mom chuck pop wow dad poop"
> -- msg is a string containing eight words.

As the first example, we want to reverse the spelling
of string "msg". Note that we can use the "reverse"
function in Haskell. 

Its description states "creates a
new string from the original one with items in the
reverse order." Thus, we need to pass in a `string as the
input to f0. 

> f0 = reverse

Next, we want to reverse the order of words in msg.
This would require that we first split up the string
into an array of strings, each element contains a word.
We can then reverse order of the elements in the array.

> f1 = reverse . words

Note that the "." notation is used to pass the output of
a function as an input of another function. In this
case, the output of words becomes the input of reverse.
f1 can be mathematically expresses as:

f1 x = reverse(words(x))

Now, we want to reverse the spelling of EACH WORD in
msg (remember, msg is a string). Function f2 performs
this specific task. Note that function "map" applies
the same operation to every element in the list. 

> f2 = map reverse . words

f2 x = f(g(h(x)

Function map is referred to as a "higher order
function".  A higher order function either takes one or
more functions as its arguments or returns a function.
In this example, the map function takes the reverse
function as an argument.  We can mathematically express
f2 as:

f2 x = map(reverse(words(x))))

For example: max (4,5,6,8,2,1)

Now, we construct f3 that would take msg and reverse
the spelling of every word, then sort the result based
on the reversed spelling of each word.

> f3 = sort . map reverse . words

Next, we want to count the length of each word and
display it next to each word. We sort the result based
on the reversed spelling of each word. Function f4
accomplish this task. 

> f4 = sort
>		 . map (\s -> (reverse s, length s)) 
>		 . words

In this example, "\s" is a lambda expression. For this
example, "\s" is a function taking two arguments
(reverse s and length s) and return a tuple with the
two arguments in the two positions, accordingly.

Note that tuples have a fixed number of elements (e.g.,
two elements in f4). They don't need to be of the same
type (e.g., string and integer in f4). 

Now, we do the same as the prior example except that we
sort the result based on the length of each word.

> f5 = sortOn snd
>		 . map (\s -> (reverse s, length s)) 
>		 . words

In p0, we add a filter to only look for words that are
palindromes.

> p0 = sortOn snd
>      . map (\w -> (w,length w))
>      . filter (\s -> reverse s == s)
>      . words

In this case, the filter is reverse s is equal to s. 

================== In class exercise ==============

Let's say we want to create a function, t0 that takes a
string as an argument and display the length of each
word and the actual word as a tuple.  

From prior example, we learn that to present data as a
tuple, we would surround the corresponding data fields
with parentheses. For example, in p0, we have a tuple
that contains (w, length w). 

Thus, our t0 would be:

> t0 = map (\w -> (length w,w))
>      . words
 
What if we would like to display the data as the
following tuple: (~length w, w)? Note that ~ is for
negation. How would we modified the above code to
create t1? 

> -- t = map (\w -> (negate length w,w))
> --     . words

Let's investigate "negate" function. We would like to
negate the length of w so one possible solution is:

> t1 = map (\w -> (negate (length w),w))
> 		 . words

Another solution is:

> t2 = map (\w -> (negate $ length w,w))
> 		 . words

Note that "$" is used here; its usage is a bit tricky
to understand. Basically, a single $ can be used to
replace (). In this example, $ is replacing the
parentheses surrounding length w in t1. 

Let's further assume that we want to be able to select
an unary operator (e.g., absolute value) instead of
just negating. In this case, the function would take
two arguments: unary operation and string. Here is an
implementation of t3. 

> t3 f = map (\w -> (f $ length w,w))
> 		 . words

For uniformity, we can also have a parameter for the
string input, s. We will write t4 as "list
comprehension." 

> t4 f s = [(f $ length w, w) | w <- words s]

Note that we now replace map() with [ ]. We also have f and
s as parameters to the function. We use
| (for pipe) to pass w (output of words s) as the input
to the output function on the left side of the pipe.

We can also create a predicate so that only items on
the list that satisfy the predicate are passed on to
the output function. Here is t5. It only sends
palindromes to the output function. 

> t5 f s = [(f $ length w, w) | w <- words s, reverse w == w]


Please refer to the link below for more information
about list comprehension. 

http://learnyouahaskell.com/starting-out#im-a-list-comprehension
