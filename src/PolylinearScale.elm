module PolylinearScale exposing (DomainAndRange, polylinearScale)

{-|

@docs DomainAndRange, polylinearScale

-}


type alias DomainAndRange =
    ( Float, Float )


findCurrent : List DomainAndRange -> Float -> Maybe DomainAndRange
findCurrent items value =
    let
        find item acc =
            if value >= Tuple.first item then
                Just item
            else
                acc
    in
        List.foldl find Nothing items


findNext : List DomainAndRange -> Float -> Maybe DomainAndRange
findNext items value =
    let
        find item acc =
            if value - 0.01 < Tuple.first item then
                Just item
            else
                acc
    in
        List.foldr find Nothing items


{-|
    Create a polylinear scale. Map from the domain to the range.

        scale = polylinearScale [(0, 0), (100, 50), (300, 100)]

        scale 100 == 50
        scale 150 == 62.5
-}
polylinearScale : List DomainAndRange -> Float -> Maybe Float
polylinearScale list value =
    let
        maybeCurrent =
            findCurrent list value

        maybeNext =
            findNext list value
    in
        case ( maybeCurrent, maybeNext ) of
            ( Just current, Just next ) ->
                let
                    ( domainCurrent, rangeCurrent ) =
                        current

                    ( domainNext, rangeNext ) =
                        next

                    rangeDiff =
                        rangeNext - rangeCurrent

                    domainDiff =
                        domainNext - domainCurrent

                    ratio =
                        if domainDiff == 0 then
                            100
                        else
                            rangeDiff / domainDiff

                    result =
                        rangeCurrent + ratio * (value - domainCurrent)

                    _ =
                        Debug.log "rangeDiff" rangeDiff

                    _ =
                        Debug.log "domainDiff" domainDiff
                in
                    Just result

            _ ->
                Nothing
