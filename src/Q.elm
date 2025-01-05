module Q exposing (..)


q : (a -> Maybe b) -> Maybe a -> Maybe b
q =
    Maybe.andThen


qq : (a -> Maybe b) -> (b -> Maybe c) -> Maybe a -> Maybe c
qq a b =
    q b << q a


qqq : (a -> Maybe b) -> (b -> Maybe c) -> (c -> Maybe d) -> Maybe a -> Maybe d
qqq a b c =
    q c << qq a b


qqqq : (a -> Maybe b) -> (b -> Maybe c) -> (c -> Maybe d) -> (d -> Maybe e) -> Maybe a -> Maybe e
qqqq f g h i =
    q i << qqq f g h


qqqqq : (a -> Maybe b) -> (b -> Maybe c) -> (c -> Maybe d) -> (d -> Maybe e) -> (e -> Maybe f) -> Maybe a -> Maybe f
qqqqq a b c d e =
    q e << qqqq a b c d
