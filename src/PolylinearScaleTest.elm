module PolylinearScaleTest exposing (all)

import Expect exposing (Expectation)
import PolylinearScale exposing (polylinearScale)
import Test exposing (..)


makeTest testCase scale input expected =
    test testCase <|
        \() ->
            Expect.equal expected (polylinearScale scale input)


all : Test
all =
    let
        linearScale =
            [ ( 0, 100 ), ( 100, 200 ) ]

        scale =
            [ ( 0, 0 ), ( 100, 50 ), ( 300, 100 ) ]
    in
    describe "polylinearScale"
        [ makeTest
            "Min"
            scale
            0
            (Just 0.0)
        , makeTest
            "End of first"
            scale
            99
            (Just 49.5)
        , makeTest
            "Start of second"
            scale
            100
            (Just 50.0)
        , makeTest
            "In second"
            scale
            150
            (Just 62.5)
        , makeTest
            "End of second"
            scale
            299
            (Just 99.75)
        , makeTest
            "Max"
            scale
            300
            (Just 100.0)
        , makeTest
            "Under"
            scale
            -1
            Nothing
        , makeTest
            "Over"
            scale
            301
            Nothing
        , makeTest
            "Empty scale"
            []
            1
            Nothing
        , makeTest
            "One member scale"
            [ ( 1, 100 ) ]
            1
            (Just 100)
        , makeTest
            "Linear scale min"
            linearScale
            0
            (Just 100)
        , makeTest
            "Linear scale middle"
            linearScale
            50
            (Just 150)
        , makeTest
            "Linear scale max"
            linearScale
            100
            (Just 200)
        ]
