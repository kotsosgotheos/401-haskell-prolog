--------------
-- ASKHSH 1 --
--------------
mylength :: [u] -> Int
mylength [] = 0
mylength (x:xs) = (+1) (mylength xs)

myzip :: [a]->[b] -> [(a, b)]
myzip (a:as) (b:bs) = (a, b):myzip as bs
myzip _ _ = []

mymap :: (Int -> Int)->[Int] -> [Int]
mymap _ [] = []
mymap f (x:xs) = f x : mymap f xs

quicksort :: [(Int, Int)] -> [(Int, Int)]
quicksort [] = []
quicksort (x:xs) = quicksort [y | y <- xs, fst y <= fst x] ++ [x] ++ quicksort [y | y <- xs, fst y > fst x]

findlast :: [(Int, Int)] -> Int
findlast [] = -1
findlast (x:xs)
    | null xs = 1
    | fst x == fst (xs!!0) = findlast xs
    | otherwise = snd x

nearest :: [Int]->Int -> Int
nearest s n = findlast (quicksort (myzip (mymap (\elem -> abs (elem - n)) s) [1..mylength s]))

--------------
-- ASKHSH 2 --
--------------
myfoldl :: (Int->Int -> Int)->Int->[Int] -> Int
myfoldl _ i [] = i
myfoldl f i (x:xs) = x `f` (myfoldl f i xs)

mytake :: Int->[Int] -> [Int]
mytake n _ | n <= 0 = []
mytake _ [] = []
mytake n (x:xs) = x:mytake (n - 1) xs

smoothened :: [Int]->Int -> [Int]
smoothened [] _ = []
smoothened s k = [(myfoldl (\acc next -> acc + next) 0 (mytake k s)) `div` k]

iteratenums :: [Int]->[Int]->Int->[Int] -> [Int]
iteratenums [] _ _ final = final
iteratenums z@(_:zs) s@(_:ss) k final = final ++ smoothened s k ++ iteratenums zs ss k final

smooth :: [Int]->Int -> [Int]
smooth [] _ = []
smooth s k = iteratenums (mytake ((mylength s) - k + 1) s) s k []

--------------
-- ASKHSH 3 --
--------------
swap' :: String->String->String->Int->String -> String
swap' w1 w2 [] 0 res = res ++ w1
swap' w1 w2 [] 1 res = res ++ w2 ++ " " ++ w1
-- swap' w1 w2 [] _ res = ""
swap' w1 w2 (s:ss) num res
    | s == ' ' = swap' w1 w2 ss (num + 1) res
    | num == 0 = swap' (w1 ++ [s]) w2 ss num res
    | num == 1 = swap' w1 (w2 ++ [s]) ss num res
    | num == 2 = swap' [s] "" ss 0 (res ++ w2 ++ " " ++ w1 ++ " ")
    | otherwise = res

swap :: String -> String
swap [] = ""
swap s = swap' "" "" s 0 ""

--------------
-- ASKHSH 4 --
--------------
apply :: [(u, Int)]->(u->Int -> v)->[v] -> [v]
apply [] _ final = final
apply (s:ss) f final = final ++ [f (fst s) (snd s)] ++ apply ss f final

mapi :: [u]->(u->Int -> v) -> [v]
mapi s f = apply (myzip s [1..mylength s]) f []
