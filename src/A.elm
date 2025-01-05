module A exposing (..)

import Q


m : (a -> b) -> Maybe a -> Maybe b
m =
    Maybe.map


qq : (a -> Maybe b) -> (b -> Maybe c) -> a -> Maybe c
qq a b =
    Q.q b << a


qqq : (a -> Maybe b) -> (b -> Maybe c) -> (c -> Maybe d) -> a -> Maybe d
qqq a b c =
    Q.qq b c << a


qqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> a
    -> Maybe e
qqqq a b c d =
    Q.qqq b c d << a


qqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> a
    -> Maybe f
qqqqq a b c d e =
    Q.qqqq b c d e << a
