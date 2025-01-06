module A exposing
    ( qq, qqq, qqqq, qqqqq, qqqqqq, qqqqqqq, qqqqqqqq, qqqqqqqqq, qqqqqqqqqq, qqqqqqqqqqq
    , q6, q7, q8, q9, q10, q11
    )

{-| Functions for navigating deeply-hierarchical nested values with optional properties.

The `A` module is specialized to operating on values that are _not_ a `Maybe a`, but contain accessors that are "and-then-able".

    import A
    import Q

    type alias User =
        { profile : Maybe { name : Maybe String, id : Int }


    toUserName : User -> Maybe String
    toUserName =
        A.qq .profile .name

    toUserId : User -> Maybe Int
    toUserId =
        A.qq .profile (Q.j .id)

@docs qq, qqq, qqqq, qqqqq, qqqqqq, qqqqqqq, qqqqqqqq, qqqqqqqqq, qqqqqqqqqq, qqqqqqqqqqq

@docs q6, q7, q8, q9, q10, q11

-}

import Q


{-| Apply two "and-then-able" functions in order to a value.
-}
qq : (a -> Maybe b) -> (b -> Maybe c) -> a -> Maybe c
qq a b =
    Q.q b << a


{-| Apply three "and-then-able" functions in order to a value.
-}
qqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> a
    -> Maybe d
qqq a b c =
    Q.qq b c << a


{-| Apply four "and-then-able" functions in order to a value.
-}
qqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> a
    -> Maybe e
qqqq a b c d =
    Q.qqq b c d << a


{-| Apply five "and-then-able" functions in order to a value.
-}
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


{-| Apply six "and-then-able" functions in order to a value.
-}
qqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> a
    -> Maybe g
qqqqqq a b c d e f =
    Q.qqqqq b c d e f << a


{-| Same as `qqqqqq`, just easier to read.
-}
q6 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> a
    -> Maybe g
q6 =
    qqqqqq


{-| Apply seven "and-then-able" functions in order to a value.
-}
qqqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> a
    -> Maybe h
qqqqqqq a b c d e f g =
    Q.qqqqqq b c d e f g << a


{-| Same as `qqqqqqq`, just easier to read.
-}
q7 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> a
    -> Maybe h
q7 =
    qqqqqqq


{-| Apply eight "and-then-able" functions in order to a value.
-}
qqqqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> a
    -> Maybe i
qqqqqqqq a b c d e f g h =
    Q.qqqqqqq b c d e f g h << a


{-| Same as `qqqqqqqq`, just easier to read.
-}
q8 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> a
    -> Maybe i
q8 =
    qqqqqqqq


{-| Apply nine "and-then-able" functions in order to a value.
-}
qqqqqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> (i -> Maybe j)
    -> a
    -> Maybe j
qqqqqqqqq a b c d e f g h i =
    Q.qqqqqqqq b c d e f g h i << a


{-| Same as `qqqqqqqqq`, just easier to read.
-}
q9 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> (i -> Maybe j)
    -> a
    -> Maybe j
q9 =
    qqqqqqqqq


{-| Apply ten "and-then-able" functions in order to a value.
-}
qqqqqqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> (i -> Maybe j)
    -> (j -> Maybe k)
    -> a
    -> Maybe k
qqqqqqqqqq a b c d e f g h i j =
    Q.qqqqqqqqq b c d e f g h i j << a


{-| Same as `qqqqqqqqqq`, just easier to read.
-}
q10 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> (i -> Maybe j)
    -> (j -> Maybe k)
    -> a
    -> Maybe k
q10 =
    qqqqqqqqqq


{-| Apply eleven "and-then-able" functions in order to a value.
-}
qqqqqqqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> (i -> Maybe j)
    -> (j -> Maybe k)
    -> (k -> Maybe l)
    -> a
    -> Maybe l
qqqqqqqqqqq a b c d e f g h i j k =
    Q.qqqqqqqqqq b c d e f g h i j k << a


{-| Same as `qqqqqqqqqqq`, just easier to read.
-}
q11 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> (h -> Maybe i)
    -> (i -> Maybe j)
    -> (j -> Maybe k)
    -> (k -> Maybe l)
    -> a
    -> Maybe l
q11 =
    qqqqqqqqqqq
