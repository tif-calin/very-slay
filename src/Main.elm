module Main exposing (..)

import Browser
import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Config =
    { hexRadius : Float
    }


type alias Model =
    { hexgrid : List ( Float, Float )
    , config : Config
    }


init : Model
init =
    { hexgrid =
        [ ( 0, 0 )
        , ( 0, 1 )
        , ( 0, 2 )
        , ( 0, 3 )
        , ( 1, 0 )
        , ( 1, 1 )
        , ( 1, 2 )
        , ( 1, 3 )
        , ( 2, 0 )
        , ( 2, 1 )
        , ( 3, 0 )
        , ( 3, 1 )
        ]
    , config =
        { hexRadius = 36
        }
    }



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    model



-- VIEW


view : Model -> Html Msg
view model =
    let
        renderHexagon ( x, y ) =
            let
                hexagonPoints radius =
                    let
                        angle =
                            pi / 3

                        point i =
                            ( radius * cos (angle * i), radius * sin (angle * i) )
                    in
                    String.join " "
                        (List.map
                            (\( x0, y0 ) -> String.fromFloat x0 ++ "," ++ String.fromFloat y0)
                            (List.map point (List.map toFloat (List.range 0 5)))
                        )
            in
            g
                [ transform
                    ("translate("
                        ++ String.fromFloat ((x + (1 / sqrt 2)) * 1.5 * (model.config.hexRadius + (sqrt 2 / 3)))
                        ++ ","
                        ++ String.fromFloat
                            ((y
                                + 0.5
                                + (0.5 * toFloat (modBy 2 (round x)))
                             )
                                * (1 + (1 / sqrt 2))
                                * (model.config.hexRadius + 1)
                            )
                        ++ ")"
                    )
                ]
                [ polygon
                    [ points (hexagonPoints model.config.hexRadius)
                    , fill "#ddd"
                    , stroke "black"
                    , strokeWidth "1"
                    ]
                    []
                ]
    in
    svg
        [ width "100%", height "100%" ]
        (List.map renderHexagon model.hexgrid)
