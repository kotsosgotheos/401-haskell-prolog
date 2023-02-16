mysqrt :: Int -> Int
mysqrt n = aux n
    where
        aux x
            | x*x > n = aux (x - 1)
            | otherwise = x

gcdEuc :: Int -> Int -> Int
gcdEuc m n
    | m==n
        = n
    | m<n
        = gcdEuc (n-m) m
    | otherwise
        = gcdEuc (m-n) n

mylcm :: Int->Int -> Int
mylcm a b = (a `div` (gcdEuc a b)) * b

checkForFactor::Int->Int -> Int
checkForFactor n i
    | (n `mod` i == 0) && (mylcm i (n `div` i) == n) = i
    | otherwise = n

findFirstFactor::Int->Int->Int -> Int
findFirstFactor n x ans
    | x > mysqrt n = checkForFactor n (x + 1)
    | otherwise = findFirstFactor n (x + 1) (checkForFactor n (x + 1))

ab::Int->(Int, Int)
ab n = ((n `div` f), f)
    where f = findFirstFactor n (n-1) 0

sum2021_::Integer->Integer->Integer -> Integer
sum2021_ m n i
    |i>n 
        =0
    | otherwise 
        =(n+i)^m + sum2021_ m n (i+1)
    
sum2021::Integer ->Integer ->Integer
sum2021 m n =sum2021_ m n m
