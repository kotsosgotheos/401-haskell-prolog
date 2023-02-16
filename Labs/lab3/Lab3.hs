part_size :: Int->String -> [String]
part_size 0 _ = []
part_size n "" = []
part_size n w = (take n w):(part_size n (drop n w)) -- ++ part_size n (drop n w)

partition_rec :: Int->String -> [[String]]
partition_rec 0 w = []
partition_rec n w = (part_size n w):(partition_rec (n - 1) w)

partition :: String -> [[String]]
partition "" = []
partition w = partition_rec ((length w) - 1) w
