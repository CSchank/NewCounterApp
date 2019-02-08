module NewCounterNet.Static.Wrappers exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)
import NewCounterNet.Static.Types exposing(..)

import Dict exposing (Dict)
wrapChangedCounter : IncomingMessage -> ChangedCounter
wrapChangedCounter x__ =
    case x__ of
        (MChangedCounter currentCount)  -> (ChangedCounter currentCount) 
        _ -> ChangedCounter 0


wrapUpdateHistory : IncomingMessage -> UpdateHistory
wrapUpdateHistory x__ =
    case x__ of
        (MUpdateHistory newEntry)  -> (UpdateHistory newEntry) 
        _ -> UpdateHistory (CounterHistory 0 0)


wrapWentToCounter : IncomingMessage -> WentToCounter
wrapWentToCounter x__ =
    case x__ of
        (MWentToCounter currentCount)  -> (WentToCounter currentCount) 
        _ -> WentToCounter 0


wrapWentToHistory : IncomingMessage -> WentToHistory
wrapWentToHistory x__ =
    case x__ of
        (MWentToHistory counterHistoryList)  -> (WentToHistory counterHistoryList) 
        _ -> WentToHistory []



unwrapChangeCounter : ChangeCounter -> OutgoingTransition
unwrapChangeCounter (ChangeCounter increment)  = (TChangeCounter increment) 


unwrapGoToCounter : GoToCounter -> OutgoingTransition
unwrapGoToCounter GoToCounter  = TGoToCounter 


unwrapGoToHistory : GoToHistory -> OutgoingTransition
unwrapGoToHistory GoToHistory  = TGoToHistory 



