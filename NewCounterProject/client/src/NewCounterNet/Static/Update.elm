module NewCounterNet.Static.Update exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.Wrappers exposing(..)
import NewCounterNet.Static.FromSuperPlace exposing (FromSuperPlace)
import NewCounterNet.Update exposing(..)
import Dict

update : FromSuperPlace -> IncomingMessage -> NetState -> (NetState,Maybe (Cmd OutgoingTransition))
update fsp trans state =
    case (trans,state) of
        ((MChangedCounter _) , SCounterRoom st) -> (SCounterRoom <| updateCounterRoomChangedCounterCounterRoom fsp (wrapChangedCounter trans) st, Nothing)
        ((MUpdateHistory _) , SHistoryRoom st) -> (SHistoryRoom <| updateHistoryRoomUpdateHistoryHistoryRoom fsp (wrapUpdateHistory trans) st, Nothing)

        ((MWentToCounter _) , SHistoryRoom st) -> (SCounterRoom <| updateHistoryRoomWentToCounterCounterRoom fsp (wrapWentToCounter trans) st, Nothing)

        ((MWentToHistory _) , SCounterRoom st) -> (SHistoryRoom <| updateCounterRoomWentToHistoryHistoryRoom fsp (wrapWentToHistory trans) st, Nothing)


        _ -> (state, Nothing)
