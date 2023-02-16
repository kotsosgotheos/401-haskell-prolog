l1 -> [1,2,3,4,5]

result :: [Int] -> [Int]
result l1 = map l1 dbl

result l1 -> ...

dlb :: Int -> Int
dlb x = 2 * x

map l1 dlb = 
[1,2,3,4,5] -> [dbl 1, dbl 2, dbl 3, dbl 4, dbl 5] = [2,4,6,8,10]

l2 = [4,7,2,3,8]

f :: Int -> Int
f x = x + 3


greater_that_zero :: Int -> Bool
greater_that_zero x = x > 0

l1 = [-4, 5, 3, 42, -9, 0, -1]
filter l1 greater_that_zero = [5,3,42,0]

l2 = ["vivian", "thanasis", "obvilios", "nikolaos", "paris", "ioanna", "kostas"]

f :: [Char] -> Bool
f x = x find "o" >= 2

filter l2 f = ["obvilios", "nikolaos"]



l1 = [1,2,3,4,5]

add :: Int -> Int
add a b = a + b

fold l1 add = 15
fold [1,2,3,4,5] add = [1,2,3,4,5]:[] = [2,3,4,5]:[1] = [3,4,5]:[1+2] = [4,5]:[1+2+3] ... []:[1+2+3+4+5]= 
[]:[15] = 15














dlb :: Int -> Int
dlb x = 2 * x

greater_that_zero :: Int -> Bool
greater_that_zero x = x > 0

add :: Int -> Int
add a b = a + b

l1 = [1, 2, -3, -4, 5, -1, -2, 3, 4, -5]

l2 = fold [2,4,10,6,8] add

map l1 dbl = [2, 4, -6, -8, 10, -2, -4, 6, 8, -10]
filter [...] greater_than_zero = [2,4,10,6,8]


l2 = 30

[(4,0), (3,2), (6,1), (2,2)]
map getPoints [] = 

fold add [3,3,3,1] = 10

[(3,2), (9,1), (4,4), (0,3), (5,2), (1,3)]

[1, 8, 0, -3, 3, -2] -> [8,3,1,0,-2,-3]
