
-----------------------------------------------------------------------------------------

-- ASKHSH 1
move :: Eq u => [u]->u->Int -> [u]
move s x n
    | not (contains s x) = s
    | n > 0 = move_element_right s x n
    | n < 0 = move_element_left s x n
    | otherwise = delete_and_return s x

contains :: Eq u => [u]->u -> Bool
contains [] x = False
contains (h:t) x
    | h == x = True
    | otherwise = contains t x

move_element_right :: Eq u => [u]->u->Int -> [u]
move_element_right (h:t) x n
    | h == x = move_right t x n
    | otherwise = [h] ++ move_element_right t x n

move_right :: Eq u => [u]->u->Int -> [u]
move_right [] x n
    | n > 0 = [x]
    | otherwise = []
move_right (h:t) x 1 = [h] ++ [x] ++ move_right t x (-1)
move_right (h:t) x n = [h] ++ move_right t x (n-1)

move_element_left:: Eq u => [u]->u->Int -> [u]
move_element_left s x n = move_element_left_ s [] x n

move_element_left_ :: Eq u => [u]->[u]->u->Int -> [u]
move_element_left_ (h:t) res x n
    | h == x && (mylength res + n) <= 0 = [x] ++ res ++ t
    | h == x = move_right res x (mylength res + n) ++ t
    | otherwise = move_element_left_ t (res ++ [h]) x n

mylength :: [u] -> Int
mylength [] = 0
mylength (h:t) = 1 + (mylength t)

delete_and_return :: Eq u => [u]->u -> [u]
delete_and_return (h:t) x
    | h == x = t
    | otherwise = [h] ++ delete_and_return t x

-----------------------------------------------------------------------------------------
     
-- ASKHSH 2

combine :: [u]->[v]->(u->v->w)->(u->v->w)->(Int->Bool) -> [w]
combine s t f g h = combine_ s t f g h 0

combine_ :: [u]->[v]->(u->v->w)->(u->v->w)->(Int->Bool)->Int -> [w]
combine_ [] _ _ _ _ _ = []
combine_ _ [] _ _ _ _ = []
combine_ (hs:ts) (ht:tt) f g h i
    | h (i+1) = [(f hs ht)] ++ combine_ ts tt f g h (i+1)
    | otherwise = [(g hs ht)] ++ combine_ ts tt f g h (i+1)
