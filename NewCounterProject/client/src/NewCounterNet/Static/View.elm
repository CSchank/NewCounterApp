module NewCounterNet.Static.View exposing(..)
import Html exposing(Html)
import Static.Types exposing (NetModel)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.View.HistoryRoom
import NewCounterNet.View.CounterRoom

import NewCounterNet.Static.Wrappers.HistoryRoom
import NewCounterNet.Static.Wrappers.CounterRoom


view : NetState -> Html OutgoingTransition
view ns =
    case ns of
        SHistoryRoom m -> Html.map NewCounterNet.Static.Wrappers.HistoryRoom.unwrap <| NewCounterNet.View.HistoryRoom.view m
        SCounterRoom m -> Html.map NewCounterNet.Static.Wrappers.CounterRoom.unwrap <| NewCounterNet.View.CounterRoom.view m

title : NetState -> String
title ns =
    case ns of
        SHistoryRoom m -> NewCounterNet.View.HistoryRoom.title m
        SCounterRoom m -> NewCounterNet.View.CounterRoom.title m

