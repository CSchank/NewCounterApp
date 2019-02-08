module Static.View exposing(..)
import NewCounterNet.Static.View as NewCounterNet

import Static.Types exposing(..)
import Html exposing(Html)
view : NetModel -> Html NetOutgoingTransition
view model =
    case model of
        NewCounterNet m -> Html.map NewCounterNetOTrans <| NewCounterNet.view m

title : NetModel -> String
title model =
    case model of
        NewCounterNet m -> NewCounterNet.title m

