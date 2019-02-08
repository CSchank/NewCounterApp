module NewCounterNet.Static.Types where
import Data.Typeable (Typeable)
import Static.List
import Static.Dict

-- the initial state of all places in this net
-- place states and place player states
data HistoryRoom  =
      HistoryRoom (List CounterHistory {-counter-}) {-counterHistoryList-}
    deriving(Ord,Eq,Show,Typeable)

data HistoryRoomPlayer  =
      HistoryRoomPlayer
    deriving(Ord,Eq,Show,Typeable)


data CounterRoom  =
      CounterRoom Int {-currentCount-}
    deriving(Ord,Eq,Show,Typeable)

data CounterRoomPlayer  =
      CounterRoomPlayer
    deriving(Ord,Eq,Show,Typeable)



-- outgoing client message types
data ChangedCounter  =
      ChangedCounter Int {-currentCount-}
    deriving(Ord,Eq,Show)
data UpdateHistory  =
      UpdateHistory CounterHistory {-newEntry-}
    deriving(Ord,Eq,Show)
data WentToCounter  =
      WentToCounter Int {-currentCount-}
    deriving(Ord,Eq,Show)
data WentToHistory  =
      WentToHistory (List CounterHistory {-counter-}) {-counterHistoryList-}
    deriving(Ord,Eq,Show)
data ClientMessage  =
      MChangedCounter Int {-currentCount-}
    | MUpdateHistory CounterHistory {-newEntry-}
    | MWentToCounter Int {-currentCount-}
    | MWentToHistory (List CounterHistory {-counter-}) {-counterHistoryList-}
    deriving(Ord,Eq,Show)

-- individual transition types
data ChangeCounterfromCounterRoom  =
      ChangeCounter_CounterRoomtoCounterRoom CounterRoomPlayer ChangedCounter
    deriving(Ord,Eq,Show)
data ChangeCounterfromHistoryRoom  =
      ChangeCounter_HistoryRoomtoHistoryRoom HistoryRoomPlayer UpdateHistory
    deriving(Ord,Eq,Show)

data GoToCounterfromHistoryRoom  =
      GoToCounter_Stay_HistoryRoom HistoryRoomPlayer
    | GoToCounter_HistoryRoomtoCounterRoom CounterRoomPlayer WentToCounter
    deriving(Ord,Eq,Show)

data GoToHistoryfromCounterRoom  =
      GoToHistory_Stay_CounterRoom CounterRoomPlayer
    | GoToHistory_CounterRoomtoHistoryRoom HistoryRoomPlayer WentToHistory
    deriving(Ord,Eq,Show)


-- main transition types
data Transition  =
      TChangeCounter Int {-increment-}
    | TGoToCounter
    | TGoToHistory
    deriving(Ord,Eq,Show)
data ChangeCounter  =
      ChangeCounter Int {-increment-}
    deriving(Ord,Eq,Show)
data GoToCounter  =
      GoToCounter
    deriving(Ord,Eq,Show)
data GoToHistory  =
      GoToHistory
    deriving(Ord,Eq,Show)

-- player state union type
data Player  =
      PHistoryRoomPlayer
    | PCounterRoomPlayer
    deriving(Ord,Eq,Show)
-- extra server types
data CounterHistory  =
      CounterHistory Int {-currentCount-} Int {-time-}
    deriving(Ord,Eq,Show)


-- the FromSuperPlace type
