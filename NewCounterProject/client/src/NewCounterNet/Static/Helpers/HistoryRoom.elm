module NewCounterNet.Static.Helpers.HistoryRoom exposing (..)
import Dict exposing (Dict)

import NewCounterNet.Static.ExtraTypes exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.Types

getCounterHistoryList : HistoryRoom -> (List CounterHistory)
getCounterHistoryList (HistoryRoom counterHistoryList)  = counterHistoryList



updateCounterHistoryList : (List CounterHistory) -> HistoryRoom -> HistoryRoom
updateCounterHistoryList newcounterHistoryList (HistoryRoom counterHistoryList)  = (HistoryRoom newcounterHistoryList) 


alterCounterHistoryList : ((List CounterHistory) -> (List CounterHistory)) -> HistoryRoom -> HistoryRoom
alterCounterHistoryList f (HistoryRoom counterHistoryList)  = 
    let
        newcounterHistoryList = f counterHistoryList
    in
        (HistoryRoom newcounterHistoryList) 



