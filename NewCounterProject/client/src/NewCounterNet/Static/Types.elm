module NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)
import Dict exposing(Dict)

-- the types of all places in the net
-- place states
type HistoryRoom  =
      HistoryRoom (List CounterHistory {-counter-}) {-counterHistoryList-}


type CounterRoom  =
      CounterRoom Int {-currentCount-}



-- union place type
type NetState  =
      SHistoryRoom HistoryRoom
    | SCounterRoom CounterRoom
-- server transition types
type OutgoingTransition  =
      TChangeCounter Int
    | TGoToCounter
    | TGoToHistory
type ChangeCounter  =
      ChangeCounter Int
type GoToCounter  =
      GoToCounter
type GoToHistory  =
      GoToHistory

-- outgoing server message types
type ChangedCounter  =
      ChangedCounter Int {-currentCount-}
type UpdateHistory  =
      UpdateHistory CounterHistory {-newEntry-}
type WentToCounter  =
      WentToCounter Int {-currentCount-}
type WentToHistory  =
      WentToHistory (List CounterHistory {-counter-}) {-counterHistoryList-}
type IncomingMessage  =
      MChangedCounter Int {-currentCount-}
    | MUpdateHistory CounterHistory {-newEntry-}
    | MWentToCounter Int {-currentCount-}
    | MWentToHistory (List CounterHistory {-counter-}) {-counterHistoryList-}


