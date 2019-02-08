module NewCounterNet.Update where
import NewCounterNet.Static.Types
import NewCounterNet.Static.FromSuperPlace
import NewCounterNet.Static.Helpers.HistoryRoom as HistoryRoom
import NewCounterNet.Static.Helpers.CounterRoom as CounterRoom

import NewCounterNet.Static.Helpers.HistoryRoomPlayer as HistoryRoomPlayer
import NewCounterNet.Static.Helpers.CounterRoomPlayer as CounterRoomPlayer

import Static.List
import Utils.Utils
import Static.ServerTypes

-- function called when new client connects (do not delete)
clientConnect :: FromSuperPlace -> ClientID -> CounterRoom -> (CounterRoom, CounterRoomPlayer)
clientConnect fsp clientID counterRoom =
    (counterRoom, CounterRoomPlayer)

-- functions called when a client disconnects (do not delete)
clientDisconnectFromCounterRoom :: FromSuperPlace -> ClientID -> CounterRoom -> CounterRoomPlayer -> CounterRoom
clientDisconnectFromCounterRoom fsp clientID counterRoom counterRoomPlayer =
    counterRoom

clientDisconnectFromHistoryRoom :: FromSuperPlace -> ClientID -> HistoryRoom -> HistoryRoomPlayer -> HistoryRoom
clientDisconnectFromHistoryRoom fsp clientID historyRoom historyRoomPlayer =
    historyRoom


-- functions for each transition
updateChangeCounter :: FromSuperPlace -> 
    ClientID ->
    ChangeCounter ->
    CounterRoom -> 
    HistoryRoom -> 
    List CounterRoomPlayer -> 
    List HistoryRoomPlayer -> 
    ( HistoryRoom,
      CounterRoom,
      (ClientID, CounterRoomPlayer) -> ChangeCounterfromCounterRoom,
      (ClientID, HistoryRoomPlayer) -> ChangeCounterfromHistoryRoom
    )
updateChangeCounter fsp clientId (ChangeCounter increment) counterRoom historyRoom lstCounterRoom lstHistoryRoom =
    let
        time = currentTime fsp --get the current time from the server
        
        newCount = CounterRoom.getCurrentCount counterRoom + increment
        newHistoryEntry = CounterHistory newCount time
        
        fromCounterRoom :: (ClientID, CounterRoomPlayer) -> ChangeCounterfromCounterRoom
        fromCounterRoom (pId, pcounterRoom) =
            ChangeCounter_CounterRoomtoCounterRoom pcounterRoom (ChangedCounter newCount)

        fromHistoryRoom :: (ClientID, HistoryRoomPlayer) -> ChangeCounterfromHistoryRoom
        fromHistoryRoom (pId, phistoryRoom) = 
            ChangeCounter_HistoryRoomtoHistoryRoom phistoryRoom (UpdateHistory newHistoryEntry)

    in
        (historyRoom
            |> HistoryRoom.alterCounterHistoryList ((:) newHistoryEntry)
        , counterRoom
            |> CounterRoom.updateCurrentCount newCount
        , fromCounterRoom
        , fromHistoryRoom
        )

updateGoToCounter :: FromSuperPlace -> 
    ClientID ->
    GoToCounter ->
    HistoryRoom -> 
    CounterRoom -> 
    List HistoryRoomPlayer -> 
    ( HistoryRoom,
      CounterRoom,
      (ClientID, HistoryRoomPlayer) -> GoToCounterfromHistoryRoom
    )
updateGoToCounter fsp clientId GoToCounter historyRoom counterRoom lstHistoryRoom =
    let
        fromHistoryRoom :: (ClientID, HistoryRoomPlayer) -> GoToCounterfromHistoryRoom
        fromHistoryRoom (pId, phistoryRoom) =
            if pId == clientId then -- if this is the player who clicked the button
                GoToCounter_HistoryRoomtoCounterRoom 
                    CounterRoomPlayer 
                    (WentToCounter $ CounterRoom.getCurrentCount counterRoom)
            else -- anyone else stays
                GoToCounter_Stay_HistoryRoom phistoryRoom
    in
        (historyRoom, counterRoom, fromHistoryRoom)

updateGoToHistory :: FromSuperPlace -> 
    ClientID ->
    GoToHistory ->
    CounterRoom -> 
    HistoryRoom -> 
    List CounterRoomPlayer -> 
    ( CounterRoom,
      HistoryRoom,
      (ClientID, CounterRoomPlayer) -> GoToHistoryfromCounterRoom
    )
updateGoToHistory fsp clientId GoToHistory counterRoom historyRoom lstCounterRoom =
    let
        fromCounterRoom :: (ClientID, CounterRoomPlayer) -> GoToHistoryfromCounterRoom
        fromCounterRoom (pId, pcounterRoom) = 
            if pId == clientId then
                GoToHistory_CounterRoomtoHistoryRoom 
                    HistoryRoomPlayer 
                    (WentToHistory $ HistoryRoom.getCounterHistoryList historyRoom)
            else
                GoToHistory_Stay_CounterRoom pcounterRoom
    in
        (counterRoom, historyRoom, fromCounterRoom)


