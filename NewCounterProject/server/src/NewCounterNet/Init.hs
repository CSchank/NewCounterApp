module NewCounterNet.Init where
import NewCounterNet.Static.Types

-- the initial states of each place in this net
initHistoryRoom :: HistoryRoom
initHistoryRoom = HistoryRoom []

initCounterRoom :: CounterRoom
initCounterRoom = CounterRoom 0


