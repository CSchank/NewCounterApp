module NewCounterNet.View.HistoryRoom exposing(..)
import NewCounterNet.Static.Types.HistoryRoom exposing(Msg(..))
import NewCounterNet.Static.Types exposing(HistoryRoom(..))
import NewCounterNet.Static.Helpers.HistoryRoom exposing(..)
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
import Bootstrap.Table as Table
import Time exposing(..)

est = customZone (-5 * 60) []

timeToString : Int -> String
timeToString timestamp = 
    let
        posixTS = millisToPosix timestamp --the posix time, needed for inputs below
        year = toYear est posixTS
        month = toMonth est posixTS
        day = toDay est posixTS
        hour = toHour est posixTS
        minute = toMinute est posixTS
        second = toSecond est posixTS
        monthToInt : Month -> Int
        monthToInt m =
            case m of
                Jan -> 1
                Feb -> 2
                Mar -> 3
                Apr -> 4
                May -> 5
                Jun -> 6
                Jul -> 7
                Aug -> 8
                Sep -> 9
                Oct -> 10
                Nov -> 11
                Dec -> 12
    in
    String.fromInt year ++ "/" ++ 
    String.fromInt (monthToInt month) ++ "/" ++ 
    String.fromInt day ++ ", " ++ 
    String.fromInt hour ++ ":" ++ 
    (if minute < 10 then "0" else "") ++ String.fromInt minute ++ ":" ++
    (if second < 10 then "0" else "") ++ String.fromInt second

view : HistoryRoom -> Html Msg
view historyRoom =
    let
        oneRow : CounterHistory -> Table.Row Msg
        oneRow (CounterHistory count time) =
            Table.tr []
                [ Table.td [] [ text (String.fromInt count) ]
                , Table.td [] [ text (timeToString time) ]
                ]
    in
    div [style "margin" "5px"]
        [
            CDN.stylesheet
        ,   h1 [] [text "History Room"]
        ,   Button.button 
                        [ 
                            Button.primary
                        ,   Button.onClick GoToCounter
                        ,   Button.attrs [style "margin" "5px"]
                        ] [ text "Counter Room" ]
        ,   Table.table
                { options = [ Table.striped, Table.hover, Table.bordered, Table.responsiveMd ]
                , thead =  Table.simpleThead
                    [ Table.th [] [ text "Updated Counter" ]
                    , Table.th [] [ text "Time" ]
                    ]
                , tbody =
                    Table.tbody []
                        (List.map oneRow <| getCounterHistoryList historyRoom)
                }
        ]

title : HistoryRoom -> String
title historyRoom =
    "History Room | Counter App"