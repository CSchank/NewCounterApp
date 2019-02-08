module NewCounterNet.Static.Wrappers.HistoryRoom exposing(..)
import NewCounterNet.Static.Types.HistoryRoom exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)
import NewCounterNet.Static.Types exposing(..)
import Dict exposing (Dict)

unwrap : Msg -> OutgoingTransition
unwrap msg =
    case msg of
        (NewCounterNet.Static.Types.HistoryRoom.ChangeCounter increment)  -> (TChangeCounter increment) 
        NewCounterNet.Static.Types.HistoryRoom.GoToCounter  -> TGoToCounter 

