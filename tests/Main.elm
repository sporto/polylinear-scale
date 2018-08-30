module Main exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import PolylinearScaleTest


suite : Test
suite =
    PolylinearScaleTest.all
