module NewCounterNet.Static.Standalone.CounterRoom exposing(..)
import Html exposing(..)
import Browser exposing(..)
import NewCounterNet.View.CounterRoom as View
import NewCounterNet.Static.Types exposing (..)
import NewCounterNet.Static.ExtraTypes exposing (..)
import NewCounterNet.Static.Types.CounterRoom exposing (Msg)
import Dict exposing (Dict)
import Json.Decode as D

main : Program () CounterRoom Msg
main = Browser.document { init = \_ -> (model, Cmd.none), view = \m -> { body = [View.view m], title = View.title m }, update = \_ m -> (m,Cmd.none), subscriptions = \_ -> Sub.none }

--Change the model here to preview your state
model : CounterRoom
model = CounterRoom 0
