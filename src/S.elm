module S exposing (s2, s3, s4, s5, s6, s7, s8, s9, s10, s11)

{-| The "S" is for "spread".

As in, "spread" some argument with _n_ maps over an _n_-ary function.

`S` is actually kind of cool, and some people may find it genuinely useful. Look at this:

    type alias Permission =
        { canLogIn : Bool
        , canSendInvite : Bool
        , canReadActivityLogs : Bool
        , canTeleport : Bool
        }

    isAdmin : Permission -> Bool
    isAdmin =
        S.s4 (\a b c d -> List.all [ a, b, c ] || d)
            .canLogIn
            .canSendInvite
            .canReadActivityLogs
            .canTeleport

Maybe, that is not the _greatest_ example - but sometimes we need to use one value as an input
to more than one intermediate value, and then operate on those intermediate values within the same
scope - you can do that with `S`.

@docs s2, s3, s4, s5, s6, s7, s8, s9, s10, s11

-}


{-| Spread the same arg with 2 maps over a two-arg function.
-}
s2 : (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
s2 map2 toB toC a =
    map2 (toB a) (toC a)


{-| Spread the same arg with 3 maps over a three-arg function.
-}
s3 :
    (b -> c -> d -> e)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> a
    -> e
s3 map3 b c d a =
    map3 (b a) (c a) (d a)


{-| Spread the same arg with 4 maps over a four-arg function.
-}
s4 :
    (b -> c -> d -> e -> f)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> a
    -> f
s4 map4 toB toC toD toE a =
    map4 (toB a) (toC a) (toD a) (toE a)


{-| Spread the same arg with 5 maps over a five-arg function.
-}
s5 :
    (b -> c -> d -> e -> f -> g)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> a
    -> g
s5 map5 toB toC toD toE toF a =
    map5 (toB a) (toC a) (toD a) (toE a) (toF a)


{-| Spread the same arg with 6 maps over a six-arg function.
-}
s6 :
    (b -> c -> d -> e -> f -> g -> h)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> (a -> g)
    -> a
    -> h
s6 map6 toB toC toD toE toF toG a =
    map6 (toB a) (toC a) (toD a) (toE a) (toF a) (toG a)


{-| Spread the same arg with 7 maps over a seven-arg function.
-}
s7 :
    (b -> c -> d -> e -> f -> g -> h -> i)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> (a -> g)
    -> (a -> h)
    -> a
    -> i
s7 map7 toB toC toD toE toF toG toH a =
    map7 (toB a) (toC a) (toD a) (toE a) (toF a) (toG a) (toH a)


{-| Spread the same arg with 8 maps over an eight-arg function.
-}
s8 :
    (b -> c -> d -> e -> f -> g -> h -> i -> j)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> (a -> g)
    -> (a -> h)
    -> (a -> i)
    -> a
    -> j
s8 map8 toB toC toD toE toF toG toH toI a =
    map8 (toB a) (toC a) (toD a) (toE a) (toF a) (toG a) (toH a) (toI a)


{-| Spread the same arg with 9 maps over a nine-arg function.
-}
s9 :
    (b -> c -> d -> e -> f -> g -> h -> i -> j -> k)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> (a -> g)
    -> (a -> h)
    -> (a -> i)
    -> (a -> j)
    -> a
    -> k
s9 map9 toB toC toD toE toF toG toH toI toJ a =
    map9 (toB a) (toC a) (toD a) (toE a) (toF a) (toG a) (toH a) (toI a) (toJ a)


{-| Spread the same arg with 10 maps over a ten-arg function.
-}
s10 :
    (b -> c -> d -> e -> f -> g -> h -> i -> j -> k -> l)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> (a -> g)
    -> (a -> h)
    -> (a -> i)
    -> (a -> j)
    -> (a -> k)
    -> a
    -> l
s10 map10 toB toC toD toE toF toG toH toI toJ toK a =
    map10 (toB a) (toC a) (toD a) (toE a) (toF a) (toG a) (toH a) (toI a) (toJ a) (toK a)


{-| Spread the same arg with 11 maps over an eleven-arg function.
-}
s11 :
    (b -> c -> d -> e -> f -> g -> h -> i -> j -> k -> l -> m)
    -> (a -> b)
    -> (a -> c)
    -> (a -> d)
    -> (a -> e)
    -> (a -> f)
    -> (a -> g)
    -> (a -> h)
    -> (a -> i)
    -> (a -> j)
    -> (a -> k)
    -> (a -> l)
    -> a
    -> m
s11 map11 toB toC toD toE toF toG toH toI toJ toK toL a =
    map11 (toB a) (toC a) (toD a) (toE a) (toF a) (toG a) (toH a) (toI a) (toJ a) (toK a) (toL a)
