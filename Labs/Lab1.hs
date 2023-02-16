count::Integer -> Int
count n = tail_count $ abs n
    where tail_count n
              | n < 10 = match_digit n
              | otherwise = tail_count (n `div` 10) + match_digit (n `mod` 10)

          match_digit n
              | n `elem` [0, 3, 6, 9] = 1
              | otherwise = 0

kgcd::Int->Int->Int -> Int
kgcd m n k = check_for_length k $ reverse_divisors $ get_divisors $ craft_comprehension m n
    where check_for_length k l
              | length l < k = 0
              | otherwise = l!!(k - 1)
    
          reverse_divisors l = foldl(\acc x -> x:acc) [] l

          get_divisors l = filter(\elem -> elem /= 0) l

          craft_comprehension m n = [check_for_division elem | elem <- [1..(min m n)]]

          check_for_division elem
              | n `mod` elem == 0, m `mod` elem == 0 = elem
              | otherwise = 0

seconds::(Int, Int)->(Int, Int, Int) -> Int
seconds (d, mm) (h, m, s) = check_valid d mm h m s $ secs s + mins m + hours h + months mm + days d
    where secs s = s

          mins m = m * 60
          
          hours h = h * 3600

          months mm = convert_month_to_seconds (mm - 1)

          days d = (d - 1) * 86400

          convert_month_to_seconds mm
              | mm == 0 = 0
              | mm == 2 = (86400 * 28) + convert_month_to_seconds (mm - 1)
              | mm `elem` [1, 3, 5, 7, 8, 10, 12] = (86400 * 31) + convert_month_to_seconds (mm - 1)
              | mm `elem` [4, 6, 9, 11] = (86400 * 30) + convert_month_to_seconds (mm - 1)
              | otherwise = 0

          check_valid d mm h m s res
              | s < 0 = -1
              | s > 59 = -1
              | m < 0 = -1
              | m > 59 = -1
              | h < 0 = -1
              | h > 23 = -1
              | mm < 1 = -1
              | mm > 12 = -1
              | d < 0 = -1
              | mm `elem` [1, 3, 5, 7, 8, 10, 12] && d > 31 = -1
              | mm `elem` [2, 4, 6, 9, 11] && d > 30 = -1
              | otherwise = res

sumfab::(Int->Int->Int->Int)->Int->Int -> Int
sumfab f a b = tail_sumfab f a a b
    where tail_sumfab f a k b
              | k == b = f a b b
              | k /= b = f a k b + tail_sumfab f a (k+1) b
