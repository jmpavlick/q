module Q exposing
    ( j, ope, nope
    , q, qq, qqq, qqqq, qqqqq, qqqqqq, qqqqqqq, qqqqqqqq, qqqqqqqqq, qqqqqqqqqq, qqqqqqqqqqq
    , q6, q7, q8, q9, q10, q11
    )

{-| Combinators for navigating deeply-hierarchial nested values with optional properties.

The `Q` module is specialized to operating on values that are a `Maybe a`.

    import Dict
    import Q
    import Time

    type alias User =
        { profile :
            Maybe
                { authProvider : Maybe String
                , signInHistory :
                    Result (List Time.Posix) (List Time.Posix)
                }
        }

    users : Dict.Dict Int User
    users =
        Dict.fromList []

    toAuthProvider : Int -> Maybe String
    toAuthProvider i =
        Q.qq .profile .authProvider <| Dict.get i users

    toLastSignInSuccess : Int -> Maybe Time.Posix
    toLastSignInSuccess i =
        Q.qqq .profile (Q.ope .signInHistory) List.head <|
            Dict.get i users

@docs j, ope, nope

@docs q, qq, qqq, qqqq, qqqqq, qqqqqq, qqqqqqq, qqqqqqqq, qqqqqqqqq, qqqqqqqqqq, qqqqqqqqqqq

@docs q6, q7, q8, q9, q10, q11

-}

import Maybe exposing (andThen)


{-| lift an accessor function `a -> b` to a "q" (i.e., `a -> Maybe b`)

    name : Maybe String
    name =
        qqq .user .profile (j .name) <|
            Just
                { user =
                    Just
                        { profile = { name = "John" } }
                }

-}
j : (a -> b) -> (a -> Maybe b)
j =
    (<<) Just


{-| for when you need to scooch right past an error (becuase you can't dip it in ranch)

    toLastSignInSuccess : Int -> Maybe Time.Posix
    toLastSignInSuccess i =
        qqq .profile (ope .signInHistory) List.head <|
            Dict.get i users

-}
ope : (a -> Result x b) -> (a -> Maybe b)
ope =
    (<<) Result.toMaybe


{-| for when you need to schooch right past a _success_

    -- Get the error message if sign in failed
    qq .profile (nope .signInHistory) user == Just "rate limited"

-}
nope : (a -> Result x b) -> (a -> Maybe x)
nope f a =
    case f a of
        Ok _ ->
            Nothing

        Err x ->
            Just x


{-| it's literally just `Maybe.andThen`
-}
q : (a -> Maybe b) -> Maybe a -> Maybe b
q =
    andThen


{-| apply two "and-then-able" functions in order to a `Maybe a`
-}
qq : (a -> Maybe b) -> (b -> Maybe c) -> Maybe a -> Maybe c
qq a b =
    q b << q a


{-| apply three "and-then-able" functions in order to a `Maybe a`
-}
qqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> Maybe a
    -> Maybe d
qqq a b c =
    q c << qq a b


{-| apply four "and-then-able" functions in order to a `Maybe a`
-}
qqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> Maybe a
    -> Maybe e
qqqq f g h i =
    q i << qqq f g h


{-| apply five "and-then-able" functions in order to a `Maybe a`
-}
qqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> Maybe a
    -> Maybe f
qqqqq a b c d e =
    q e << qqqq a b c d


{-| apply six "and-then-able" functions in order to a `Maybe a`
-}
qqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> Maybe a
    -> Maybe g
qqqqqq a b c d e f =
    q f << qqqqq a b c d e


{-| same as `qqqqqq`, just easier to read
-}
q6 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> Maybe a
    -> Maybe g
q6 =
    qqqqqq


{-| apply seven "and-then-able" functions in order to a `Maybe a`
-}
qqqqqqq :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> Maybe a
    -> Maybe h
qqqqqqq a b c d e f g =
    q g << qqqqqq a b c d e f


{-| same as `qqqqqqq`, just easier to read
-}
q7 :
    (a -> Maybe b)
    -> (b -> Maybe c)
    -> (c -> Maybe d)
    -> (d -> Maybe e)
    -> (e -> Maybe f)
    -> (f -> Maybe g)
    -> (g -> Maybe h)
    -> Maybe a
    -> Maybe h
q7 =
    qqqqqqq


{-| apply eight "and-then-able" functions in order to a `Maybe a`
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
    -> Maybe a
    -> Maybe i
qqqqqqqq a b c d e f g h =
    q h << qqqqqqq a b c d e f g


{-| same as `qqqqqqqq`, just easier to read
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
    -> Maybe a
    -> Maybe i
q8 =
    qqqqqqqq


{-| apply nine "and-then-able" functions in order to a `Maybe a`
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
    -> Maybe a
    -> Maybe j
qqqqqqqqq a b c d e f g h i =
    q i << qqqqqqqq a b c d e f g h


{-| same as `qqqqqqqqq`, just easier to read
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
    -> Maybe a
    -> Maybe j
q9 =
    qqqqqqqqq


{-| apply ten "and-then-able" functions in order to a `Maybe a`
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
    -> Maybe a
    -> Maybe k
qqqqqqqqqq a b c d e f g h i j_ =
    q j_ << qqqqqqqqq a b c d e f g h i


{-| same as `qqqqqqqqqq`, just easier to read
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
    -> Maybe a
    -> Maybe k
q10 =
    qqqqqqqqqq


{-| apply eleven "and-then-able" functions in order to a `Maybe a`
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
    -> Maybe a
    -> Maybe l
qqqqqqqqqqq a b c d e f g h i j_ k =
    q k << qqqqqqqqqq a b c d e f g h i j_


{-| same as `qqqqqqqqqqq`, just easier to read
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
    -> Maybe a
    -> Maybe l
q11 =
    qqqqqqqqqqq
