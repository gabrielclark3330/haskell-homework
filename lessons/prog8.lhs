> import Data.Char
> import Data.List
> import System.IO
> import System.Environment
 
Agenda:

- File I/O
- Command line arguments
- Do statement
- Basic string to int conversion
- Getting ready for the second programming assignment.

> cutList :: Show a => Handle -> [a] -> IO ()
> cutList fh [] = return ()
> cutList fh (x:xs) = do
>  hPutStr fh (show(x) ++ "\n") 
>  cutList fh xs
>
>-- str = "Hello"
>
> main =
>    do -- provide the ability to execute instructions
>       -- in order
>     args <- getArgs
>     let inFile= args!!0  -- getting element args[0] 
>     let outFile= args!!1 -- getting element args[1]
>-- create in file handle
>     inh <- openFile inFile ReadMode
>-- create out file handle
>     outh <- openFile outFile WriteMode
>     content <- hGetContents inh
>     let str = [ a | a <- words content, length (a) == 1]
>     -- let creates local variable result that can be
>     -- used inside traceCut but not visible outside of
>     -- it
>     let nbr = map read str
>     print (sum nbr)
>     cutList outh (nbr)
>--     cutList stdout (nbr)
>     hClose inh 
>     hClose outh 

>-- to run using interactive mode use: set args spice.din spice.dout
>-- use :set +s to set the timer
