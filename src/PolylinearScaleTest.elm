module PolylinearScaleTest exposing (..)

import PolylinearScale exposing (polylinearScale)
import Expect exposing (Expectation)
import Test exposing (..)


all : Test
all =
    let
        linearScale =
            [ ( 0, 100 ), ( 100, 200 ) ]

        scale =
            [ ( 0, 0 ), ( 100, 50 ), ( 300, 100 ) ]

        inputs =
            [ ( "Min", scale, 0, Just 0.0 )
            , ( "End of first", scale, 99, Just 49.5 )
            , ( "Start of second", scale, 100, Just 50.0 )
            , ( "In second", scale, 150, Just 62.5 )
            , ( "End of second", scale, 299, Just 99.75 )
            , ( "Max", scale, 300, Just 100.0 )
            , ( "Under", scale, -1, Nothing )
            , ( "Over", scale, 301, Nothing )
            , ( "Empty scale", [], 1, Nothing )
            , ( "One member scale", [ ( 1, 100 ) ], 1, Just 100 )
            , ( "Linear scale min", linearScale, 0, Just 100 )
            , ( "Linear scale middle", linearScale, 50, Just 150 )
            , ( "Linear scale max", linearScale, 100, Just 200 )
            ]

        makeTest ( testCase, scale, input, expected ) =
            test testCase <|
                \() ->
                    Expect.equal expected (polylinearScale scale input)
    in
        List.map makeTest inputs
            |> describe "polylinearScale"
