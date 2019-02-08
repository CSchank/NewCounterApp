module NewCounterNet.Update exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.FromSuperPlace exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)
import NewCounterNet.Static.Helpers.HistoryRoom as HistoryRoom
import NewCounterNet.Static.Helpers.CounterRoom as CounterRoom
import Utils.Utils
import Debug exposing(todo)

updateHistoryRoomUpdateHistoryHistoryRoom : FromSuperPlace -> UpdateHistory -> HistoryRoom -> HistoryRoom
updateHistoryRoomUpdateHistoryHistoryRoom fsp (UpdateHistory newEntry)  historyRoom =
    historyRoom
        |> HistoryRoom.alterCounterHistoryList (\historyList -> newEntry :: historyList)

updateCounterRoomChangedCounterCounterRoom : FromSuperPlace -> ChangedCounter -> CounterRoom -> CounterRoom
updateCounterRoomChangedCounterCounterRoom fsp (ChangedCounter currentCount)  counterRoom =
    counterRoom 
        |> CounterRoom.updateCurrentCount currentCount


updateHistoryRoomWentToCounterCounterRoom : FromSuperPlace -> WentToCounter -> HistoryRoom -> CounterRoom
updateHistoryRoomWentToCounterCounterRoom fsp (WentToCounter currentCount)  historyRoom =
    CounterRoom currentCount


updateCounterRoomWentToHistoryHistoryRoom : FromSuperPlace -> WentToHistory -> CounterRoom -> HistoryRoom
updateCounterRoomWentToHistoryHistoryRoom fsp (WentToHistory counterHistoryList)  counterRoom =
    HistoryRoom counterHistoryList



