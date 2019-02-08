module NewCounterNet.Static.Wrappers.CounterRoom exposing(..)
import NewCounterNet.Static.Types.CounterRoom exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)
import NewCounterNet.Static.Types exposing(..)
import Dict exposing (Dict)

unwrap : Msg -> OutgoingTransition
unwrap msg =
    case msg of
        (NewCounterNet.Static.Types.CounterRoom.ChangeCounter increment)  -> (TChangeCounter increment) 
        NewCounterNet.Static.Types.CounterRoom.GoToHistory  -> TGoToHistory 

