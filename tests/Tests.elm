module Tests exposing (suite)

{-| Tests for the Q module
-}

import A
import Dict
import Expect
import Q
import S
import Test exposing (Test)
import Time


type alias Opt1 q =
    { a : Maybe q }


opt1 : Maybe q -> Opt1 q
opt1 v =
    { a = v }


type alias Opt2 q =
    Opt1 { b : Maybe q }


opt2 : Maybe q -> Opt2 q
opt2 v =
    opt1 <| Just { b = v }


type alias Opt3 q =
    Opt2 { c : Maybe q }


opt3 : Maybe q -> Opt3 q
opt3 v =
    opt2 <| Just { c = v }


type alias Opt4 q =
    Opt3 { d : Maybe q }


opt4 : Maybe q -> Opt4 q
opt4 v =
    opt3 <| Just { d = v }


type alias Opt5 q =
    Opt4 { e : Maybe q }


opt5 : Maybe q -> Opt5 q
opt5 v =
    opt4 <| Just { e = v }


type alias Opt6 q =
    Opt5 { f : Maybe q }


opt6 : Maybe q -> Opt6 q
opt6 v =
    opt5 <| Just { f = v }


type alias Opt7 q =
    Opt6 { g : Maybe q }


opt7 : Maybe q -> Opt7 q
opt7 v =
    opt6 <| Just { g = v }


type alias Opt8 q =
    Opt7 { h : Maybe q }


opt8 : Maybe q -> Opt8 q
opt8 v =
    opt7 <| Just { h = v }


type alias Opt9 q =
    Opt8 { i : Maybe q }


opt9 : Maybe q -> Opt9 q
opt9 v =
    opt8 <| Just { i = v }


type alias Opt10 q =
    Opt9 { j : Maybe q }


opt10 : Maybe q -> Opt10 q
opt10 v =
    opt9 <| Just { j = v }


type alias Opt11 q =
    Opt10 { k : Maybe q }


opt11 : Maybe q -> Opt11 q
opt11 v =
    opt10 <| Just { k = v }


type alias User =
    { profile :
        Maybe
            { authProvider : Maybe String
            , signInHistory : Result String (List Time.Posix)

            -- ope: Q.qqq .profile (Q.ope .signInHistory) List.head user == Just firstSignIn
            -- nope: Q.qq .profile (\p -> Q.nope .signInHistory p) user == Just "rate limited"
            }
    }


users : Dict.Dict Int User
users =
    Dict.fromList
        [ ( 1
          , { profile =
                Just
                    { authProvider = Just "google"
                    , signInHistory = Ok [ Time.millisToPosix 1000 ]
                    }
            }
          )
        , ( 2
          , { profile =
                Just
                    { authProvider = Just "github"
                    , signInHistory = Err "rate limited"
                    }
            }
          )
        ]


qExampleTests : Test
qExampleTests =
    Test.describe "Q examples"
        [ Test.test "can get auth provider" <|
            \_ ->
                Expect.equal (Just "google") <|
                    Q.qq .profile .authProvider <|
                        Dict.get 1 users
        , Test.test "can get successful sign in with ope" <|
            \_ ->
                Expect.equal (Just (Time.millisToPosix 1000)) <|
                    Q.qqq .profile (Q.ope .signInHistory) List.head <|
                        Dict.get 1 users
        , Test.test "can get error message with nope" <|
            \_ ->
                Expect.equal (Just "rate limited") <|
                    Q.qq .profile (\p -> Q.nope .signInHistory p) <|
                        Dict.get 2 users
        ]


suite : Test
suite =
    Test.describe "Tests"
        [ qTests
        , aTests
        , sTests
        , qExampleTests
        ]


qTests : Test
qTests =
    Test.describe "for Q"
        [ Test.test "Q.qq with a value" <|
            \_ ->
                Expect.equal (Just 1) <|
                    Q.qq .a .b (Just { a = Just { b = Just 1 } })
        , Test.test "Q.qq with no value" <|
            \_ ->
                Expect.equal Nothing <|
                    Q.qq .a .b (Just { a = Just { b = Nothing } })
        , Test.test "Q.qqq (q3) with a value" <|
            \_ ->
                Expect.equal (Just 333) <|
                    Q.qqq .a .b .c (Just (opt3 (Just 333)))
        , Test.test "Q.qqqq (q4) with a value" <|
            \_ ->
                Expect.equal (Just 444) <|
                    Q.qqqq .a .b .c .d (Just (opt4 (Just 444)))
        , Test.test "Q.qqqqq (q5) with a value" <|
            \_ ->
                Expect.equal (Just 555) <|
                    Q.qqqqq .a .b .c .d .e (Just (opt5 (Just 555)))
        , Test.test "Q.qqqqqq (q6) with a value" <|
            \_ ->
                Expect.equal (Just 666) <|
                    Q.qqqqqq .a .b .c .d .e .f (Just (opt6 (Just 666)))
        , Test.test "Q.qqqqqqqq (q8) with a value" <|
            \_ ->
                Expect.equal (Just 888) <|
                    Q.qqqqqqqq .a .b .c .d .e .f .g .h (Just (opt8 (Just 888)))
        , Test.test "Q.qqqqqqqqqq (q10) with a value" <|
            \_ ->
                Expect.equal (Just 1010) <|
                    Q.qqqqqqqqqq .a .b .c .d .e .f .g .h .i .j (Just (opt10 (Just 1010)))
        , Test.test "Q.qqqqqqqqqqq (q11) with a value" <|
            \_ ->
                Expect.equal (Just 1111) <|
                    Q.qqqqqqqqqqq .a .b .c .d .e .f .g .h .i .j .k (Just (opt11 (Just 1111)))
        ]


aTests : Test
aTests =
    Test.describe "for A"
        [ Test.test "A.qq with a value" <|
            \_ ->
                Expect.equal (Just 1) <|
                    A.qq .a .b { a = Just { b = Just 1 } }
        , Test.test "qq with no value" <|
            \_ ->
                Expect.equal Nothing <|
                    A.qq .a .b { a = Just { b = Nothing } }
        , Test.test "qqq (q3) with a value" <|
            \_ ->
                Expect.equal (Just 333) <|
                    A.qqq .a .b .c (opt3 (Just 333))
        , Test.test "qqqq (q4) with a value" <|
            \_ ->
                Expect.equal (Just 444) <|
                    A.qqqq .a .b .c .d (opt4 (Just 444))
        , Test.test "qqqqq (q5) with a value" <|
            \_ ->
                Expect.equal (Just 555) <|
                    A.qqqqq .a .b .c .d .e (opt5 (Just 555))
        , Test.test "qqqqqq (q6) with a value" <|
            \_ ->
                Expect.equal (Just 666) <|
                    A.qqqqqq .a .b .c .d .e .f (opt6 (Just 666))
        , Test.test "qqqqqqqq (q8) with a value" <|
            \_ ->
                Expect.equal (Just 888) <|
                    A.qqqqqqqq .a .b .c .d .e .f .g .h (opt8 (Just 888))
        , Test.test "qqqqqqqqqq (q10) with a value" <|
            \_ ->
                Expect.equal (Just 1010) <|
                    A.qqqqqqqqqq .a .b .c .d .e .f .g .h .i .j (opt10 (Just 1010))
        , Test.test "qqqqqqqqqqq (q11) with a value" <|
            \_ ->
                Expect.equal (Just 1111) <|
                    A.qqqqqqqqqqq .a .b .c .d .e .f .g .h .i .j .k (opt11 (Just 1111))
        ]


sTests : Test
sTests =
    Test.describe "for S"
        [ Test.test "s2 spreads a function with two values" <|
            \_ ->
                Expect.ok <|
                    Result.fromMaybe () <|
                        S.s2 (Maybe.map2 Tuple.pair)
                            (A.qq .a .b)
                            (A.qq .a .b)
                            (opt2 (Just ()))
        , Test.test "s3 spreads a function with three values" <|
            \_ ->
                Expect.ok <|
                    Result.fromMaybe () <|
                        S.s3 (Maybe.map3 (\_ _ _ -> ()))
                            (A.qq .a .b)
                            (A.qqq .a .b .c)
                            (A.qq .a .b)
                            (opt3 (Just ()))
        , Test.test "s4 spreads a function with four values" <|
            \_ ->
                Expect.ok <|
                    Result.fromMaybe () <|
                        S.s4 (Maybe.map4 (\_ _ _ _ -> ()))
                            (A.qq .a .b)
                            (A.qqq .a .b .c)
                            (A.qq .a .b)
                            (A.qqqq .a .b .c .d)
                            (opt4 (Just ()))
        , Test.describe "nobody reads the test suite and that's a goddamned shame"
            [ permissionTestIsGod
            , permissionTestIsNotGod
            ]
        ]


permissionTestIsGod : Test
permissionTestIsGod =
    Test.test "user should not be God if he is not God" <|
        \_ ->
            Expect.equal false <|
                isGod userDict 0


permissionTestIsNotGod : Test
permissionTestIsNotGod =
    Test.test "user should be God if he is God" <|
        \_ ->
            Expect.equal true <|
                isGod userDict 1


type alias Flag =
    Maybe ()


true : Flag
true =
    Just ()


false : Flag
false =
    Nothing


{-| if you ever see anybody do permissions like this, please hurt them
-}
type alias Permission =
    { role : Maybe { user : Flag, organizer : Flag, admin : Flag, superAdmin : Flag }
    , userFlags :
        Maybe
            { canLogIn :
                Maybe
                    { withoutInvitation : Flag
                    }
            , canDeclineMeeting : Flag
            }
    , organizerFlags :
        Maybe
            { canProposeAddMember : Flag
            , canCallMeeting : Flag
            , canCancelMeeting : Flag
            }
    , adminFlags :
        Maybe
            { canAddUser : Flag
            , canAcceptAddUserProposal : Flag
            , canRemoveUser :
                Maybe
                    { canRemoveUser : Flag
                    , canRemoveOrganizer : Flag
                    }
            }
    , superAdminFlags :
        Maybe
            { canAddUser : Flag
            , canAcceptAddUserProposal : Flag
            , canRemoveUser :
                Maybe
                    { canRemoveUser : Flag
                    , canRemoveOrganizer : Flag
                    , canRemoveAdmin : Flag
                    }
            , canTerminateWorkspace : Flag
            , canTeleport : Flag
            }
    }


{-| i just wanted to find a way that i could demonstrate what it looks like to use this in anger, that's all
-}
isGod : Dict.Dict Int { user : String, permission : Permission } -> Int -> Flag
isGod dict k =
    S.s5 (\a b c d e -> Q.qqqq (always a) (always b) (always c) (always d) e)
        -- has all roles
        (S.s4 (\a b c d -> Q.qqq (always a) (always b) (always c) d)
            (Q.qq .role .user)
            (Q.qq .role .organizer)
            (Q.qq .role .admin)
            (Q.qq .role .superAdmin)
        )
        -- has all user flags
        (S.s2 (\a b -> Q.q (always a) b)
            (Q.qqq .userFlags .canLogIn .withoutInvitation)
            (Q.qq .userFlags .canDeclineMeeting)
        )
        -- has all organier flags
        (S.s3 (\a b c -> Q.qq (always a) (always b) c)
            (Q.qq .organizerFlags .canProposeAddMember)
            (Q.qq .organizerFlags .canCallMeeting)
            (Q.qq .organizerFlags .canCancelMeeting)
        )
        -- has all admin flags
        (S.s4 (\a b c d -> Q.qqq (always a) (always b) (always c) d)
            (Q.qq .adminFlags .canAddUser)
            (Q.qq .adminFlags .canAcceptAddUserProposal)
            (Q.qqq .adminFlags .canRemoveUser .canRemoveUser)
            (Q.qqq .adminFlags .canRemoveUser .canRemoveOrganizer)
        )
        -- has all super admin flags
        (S.s7 (\a b c d e f g -> Q.qqqqqq (always a) (always b) (always c) (always d) (always e) (always f) g)
            (Q.qq .superAdminFlags .canAddUser)
            (Q.qq .superAdminFlags .canAcceptAddUserProposal)
            (Q.qqq .superAdminFlags .canRemoveUser .canRemoveUser)
            (Q.qqq .superAdminFlags .canRemoveUser .canRemoveOrganizer)
            (Q.qqq .superAdminFlags .canRemoveUser .canRemoveAdmin)
            (Q.qq .superAdminFlags .canTerminateWorkspace)
            (Q.qq .superAdminFlags .canTeleport)
        )
        (Q.q (Q.j .permission) <| Dict.get k dict)


userDict : Dict.Dict Int { user : String, permission : Permission }
userDict =
    Dict.fromList
        [ ( 0, { user = "not God", permission = notGod } )
        , ( 1, { user = "God", permission = god } )
        ]


notGod : Permission
notGod =
    { role = Just { user = true, organizer = true, admin = true, superAdmin = true }
    , userFlags =
        Just
            { canLogIn = Just { withoutInvitation = true }
            , canDeclineMeeting = true
            }
    , organizerFlags =
        Just
            { canProposeAddMember = true
            , canCallMeeting = true
            , canCancelMeeting = true
            }
    , adminFlags =
        Just
            { canAddUser = true
            , canAcceptAddUserProposal = true
            , canRemoveUser =
                Just
                    { canRemoveUser = true
                    , canRemoveOrganizer = true
                    }
            }
    , superAdminFlags =
        Just
            { canAddUser = true
            , canAcceptAddUserProposal = true
            , canRemoveUser =
                Just
                    { canRemoveUser = true
                    , canRemoveOrganizer = true
                    , canRemoveAdmin = true
                    }
            , canTerminateWorkspace = true
            , canTeleport = false
            }
    }


god : Permission
god =
    { role = Just { user = true, organizer = true, admin = true, superAdmin = true }
    , userFlags =
        Just
            { canLogIn = Just { withoutInvitation = true }
            , canDeclineMeeting = true
            }
    , organizerFlags =
        Just
            { canProposeAddMember = true
            , canCallMeeting = true
            , canCancelMeeting = true
            }
    , adminFlags =
        Just
            { canAddUser = true
            , canAcceptAddUserProposal = true
            , canRemoveUser =
                Just
                    { canRemoveUser = true
                    , canRemoveOrganizer = true
                    }
            }
    , superAdminFlags =
        Just
            { canAddUser = true
            , canAcceptAddUserProposal = true
            , canRemoveUser =
                Just
                    { canRemoveUser = true
                    , canRemoveOrganizer = true
                    , canRemoveAdmin = true
                    }
            , canTerminateWorkspace = true
            , canTeleport = true
            }
    }
