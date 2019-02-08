module NewCounterNet.Static.Helpers.HistoryRoom where

import Static.Dict


import NewCounterNet.Static.Types
import NewCounterNet.Static.Types
import Static.List
getCounterHistoryList :: HistoryRoom -> (List CounterHistory)
getCounterHistoryList (HistoryRoom counterHistoryList)  = counterHistoryList



updateCounterHistoryList :: (List CounterHistory) -> HistoryRoom -> HistoryRoom
updateCounterHistoryList newcounterHistoryList (HistoryRoom counterHistoryList)  = (HistoryRoom newcounterHistoryList) 


alterCounterHistoryList :: ((List CounterHistory) -> (List CounterHistory)) -> HistoryRoom -> HistoryRoom
alterCounterHistoryList f (HistoryRoom counterHistoryList)  = 
    let
        newcounterHistoryList = f counterHistoryList
    in
        (HistoryRoom newcounterHistoryList) 



