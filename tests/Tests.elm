module Tests exposing (suite)

{-| Tests for the Q module
-}

import A
import Expect
import Q
import Test exposing (Test)


suite : Test
suite =
    Test.describe "Tests"
        [ qTests
        ]


qTests : Test
qTests =
    Test.describe "for Q"
        [ Test.test "qq with a value" <|
            \_ ->
                Expect.equal (Just 1) <|
                    Q.qq .a .b (Just { a = Just { b = Just 1 } })
        , Test.test "qq with no value" <|
            \_ ->
                Expect.equal Nothing <|
                    Q.qq .a .b (Just { a = Just { b = Nothing } })
        ]
