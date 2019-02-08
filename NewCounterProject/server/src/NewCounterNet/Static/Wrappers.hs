module NewCounterNet.Static.Wrappers where
import Static.Dict
import Data.Map.Strict as Dict
import NewCounterNet.Static.Types

unwrapChangedCounter :: ChangedCounter -> ClientMessage
unwrapChangedCounter (ChangedCounter currentCount)  = (MChangedCounter currentCount) 


unwrapUpdateHistory :: UpdateHistory -> ClientMessage
unwrapUpdateHistory (UpdateHistory newEntry)  = (MUpdateHistory newEntry) 


unwrapWentToCounter :: WentToCounter -> ClientMessage
unwrapWentToCounter (WentToCounter currentCount)  = (MWentToCounter currentCount) 


unwrapWentToHistory :: WentToHistory -> ClientMessage
unwrapWentToHistory (WentToHistory counterHistoryList)  = (MWentToHistory counterHistoryList) 



wrapChangedCounter :: ClientMessage -> ChangedCounter
wrapChangedCounter x__ =
    case x__ of
        (MChangedCounter currentCount)  -> (ChangedCounter currentCount) 
        _ -> ChangedCounter 0


wrapUpdateHistory :: ClientMessage -> UpdateHistory
wrapUpdateHistory x__ =
    case x__ of
        (MUpdateHistory newEntry)  -> (UpdateHistory newEntry) 
        _ -> UpdateHistory (CounterHistory 0 0)


wrapWentToCounter :: ClientMessage -> WentToCounter
wrapWentToCounter x__ =
    case x__ of
        (MWentToCounter currentCount)  -> (WentToCounter currentCount) 
        _ -> WentToCounter 0


wrapWentToHistory :: ClientMessage -> WentToHistory
wrapWentToHistory x__ =
    case x__ of
        (MWentToHistory counterHistoryList)  -> (WentToHistory counterHistoryList) 
        _ -> WentToHistory []



unwrapHistoryRoomPlayer :: HistoryRoomPlayer -> Player
unwrapHistoryRoomPlayer HistoryRoomPlayer  = PHistoryRoomPlayer 


unwrapCounterRoomPlayer :: CounterRoomPlayer -> Player
unwrapCounterRoomPlayer CounterRoomPlayer  = PCounterRoomPlayer 



wrapHistoryRoomPlayer :: Player -> HistoryRoomPlayer
wrapHistoryRoomPlayer x__ =
    case x__ of
        PHistoryRoomPlayer  -> HistoryRoomPlayer 
        _ -> HistoryRoomPlayer 


wrapCounterRoomPlayer :: Player -> CounterRoomPlayer
wrapCounterRoomPlayer x__ =
    case x__ of
        PCounterRoomPlayer  -> CounterRoomPlayer 
        _ -> CounterRoomPlayer 



unwrapChangeCounterfromCounterRoom :: ChangeCounterfromCounterRoom -> (Player, Maybe ClientMessage)
unwrapChangeCounterfromCounterRoom trans =
    case trans of
        (ChangeCounter_CounterRoomtoCounterRoom player msg)  -> (unwrapCounterRoomPlayer player, Just $ unwrapChangedCounter msg)



unwrapChangeCounterfromHistoryRoom :: ChangeCounterfromHistoryRoom -> (Player, Maybe ClientMessage)
unwrapChangeCounterfromHistoryRoom trans =
    case trans of
        (ChangeCounter_HistoryRoomtoHistoryRoom player msg)  -> (unwrapHistoryRoomPlayer player, Just $ unwrapUpdateHistory msg)




unwrapGoToCounterfromHistoryRoom :: GoToCounterfromHistoryRoom -> (Player, Maybe ClientMessage)
unwrapGoToCounterfromHistoryRoom trans =
    case trans of
        (GoToCounter_Stay_HistoryRoom player)  -> (unwrapHistoryRoomPlayer player, Nothing)
        (GoToCounter_HistoryRoomtoCounterRoom player msg)  -> (unwrapCounterRoomPlayer player, Just $ unwrapWentToCounter msg)




unwrapGoToHistoryfromCounterRoom :: GoToHistoryfromCounterRoom -> (Player, Maybe ClientMessage)
unwrapGoToHistoryfromCounterRoom trans =
    case trans of
        (GoToHistory_Stay_CounterRoom player)  -> (unwrapCounterRoomPlayer player, Nothing)
        (GoToHistory_CounterRoomtoHistoryRoom player msg)  -> (unwrapHistoryRoomPlayer player, Just $ unwrapWentToHistory msg)





unwrapChangeCounter :: ChangeCounter -> Transition
unwrapChangeCounter (ChangeCounter increment)  = (TChangeCounter increment) 


unwrapGoToCounter :: GoToCounter -> Transition
unwrapGoToCounter GoToCounter  = TGoToCounter 


unwrapGoToHistory :: GoToHistory -> Transition
unwrapGoToHistory GoToHistory  = TGoToHistory 



wrapChangeCounter :: Transition -> ChangeCounter
wrapChangeCounter x__ =
    case x__ of
        (TChangeCounter increment)  -> (ChangeCounter increment) 
        _ -> ChangeCounter (-1)


wrapGoToCounter :: Transition -> GoToCounter
wrapGoToCounter x__ =
    case x__ of
        TGoToCounter  -> GoToCounter 
        _ -> GoToCounter 


wrapGoToHistory :: Transition -> GoToHistory
wrapGoToHistory x__ =
    case x__ of
        TGoToHistory  -> GoToHistory 
        _ -> GoToHistory 



