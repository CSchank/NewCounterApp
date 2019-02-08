module NewCounterNet.View.CounterRoom exposing(..)
import NewCounterNet.Static.Types.CounterRoom exposing(Msg(..))
import NewCounterNet.Static.Types exposing(CounterRoom(..))
import NewCounterNet.Static.Helpers.CounterRoom exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)

import Html exposing(..)
import Debug exposing(todo)

--elm bootstrap
import Html.Attributes exposing (..)
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Form.Select as Select
import Bootstrap.Form.Checkbox as Checkbox
import Bootstrap.Form.Radio as Radio
import Bootstrap.Form.Textarea as Textarea
import Bootstrap.Form.Fieldset as Fieldset
import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col

view : CounterRoom -> Html Msg
view counterRoom =
    div [style "margin" "5px"]
        [
            CDN.stylesheet
        ,   h1 [] [text "Counter Room"]
        ,   h3 [] [text <| "Current count: " ++ String.fromInt (getCurrentCount counterRoom)]
        ,   div []
            [Button.button 
                        [ 
                            Button.primary
                        ,   Button.onClick (ChangeCounter 1)
                        ,   Button.attrs [style "margin" "5px", style "width" "40px"]
                        ,   Button.small
                        ] [ text "+" ]
        ,   Button.button 
                        [ 
                            Button.primary
                        ,   Button.onClick (ChangeCounter -1)
                        ,   Button.attrs [style "margin" "5px", style "width" "40px"]
                        ,   Button.small
                        ] [ text "-" ]]
        ,   Button.button 
                        [ 
                            Button.primary
                        ,   Button.onClick GoToHistory
                        ,   Button.attrs [style "margin" "5px"]
                        ] [ text "History Room" ]
        ]

title : CounterRoom -> String
title counterRoom =
    "Counter Room | Counter App"
