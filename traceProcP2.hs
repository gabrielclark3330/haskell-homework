import Data.Char
import Data.List
import System.IO
import System.Environment

mapHexToDec :: Char -> Int
mapHexToDec '0' = 0
mapHexToDec '1' = 1
mapHexToDec '2' = 2
mapHexToDec '3' = 3
mapHexToDec '4' = 4
mapHexToDec '5' = 5
mapHexToDec '6' = 6
mapHexToDec '7' = 7
mapHexToDec '8' = 8
mapHexToDec '9' = 9
mapHexToDec 'a' = 10
mapHexToDec 'b' = 11
mapHexToDec 'c' = 12
mapHexToDec 'd' = 13
mapHexToDec 'e' = 14
mapHexToDec 'f' = 15

hexToDec :: [Char] -> Int -> Int
hexToDec [x] index = (16^index*(mapHexToDec x))
hexToDec (x:xs) index = (16^index*(mapHexToDec x)) + hexToDec xs (index+1)
hexToDecH arr = hexToDec (reverse arr) 0

cutList :: Show a => Handle -> [(a, a)] -> IO ()
cutList fh [] = return ()
cutList fh (x:xs) = do
 hPutStr fh (show(fst x) ++ " " ++ show(snd x) ++ "\n")
 cutList fh xs

bitShiftNum number = div number 2048

main = do
 args <- getArgs
 let inFile = args!!0
 let outFile = args!!1
 inh <- openFile inFile ReadMode
 outh <- openFile outFile WriteMode
 content <- hGetContents inh
 let hexStrings = [a | a <- words content, length (a)>1] -- get all the hexStrings
 
 let decArr = map hexToDecH hexStrings

 let pageArr = map bitShiftNum decArr

 let sortedDecArr = sort pageArr

 let grouped = group sortedDecArr

 let counts = map (\xs -> (length xs, head xs)) grouped

 let pageCountsFiltered = [a | a <- counts, (fst a)>99]

 cutList outh pageCountsFiltered
 print("done!")

 hClose inh
 hClose outh

