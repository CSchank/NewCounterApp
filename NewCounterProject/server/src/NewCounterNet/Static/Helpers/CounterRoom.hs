module NewCounterNet.Static.Helpers.CounterRoom where

import Static.Dict


import NewCounterNet.Static.Types
import NewCounterNet.Static.Types
import Static.List
getCurrentCount :: CounterRoom -> Int
getCurrentCount (CounterRoom currentCount)  = currentCount



updateCurrentCount :: Int -> CounterRoom -> CounterRoom
updateCurrentCount newcurrentCount (CounterRoom currentCount)  = (CounterRoom newcurrentCount) 


alterCurrentCount :: (Int -> Int) -> CounterRoom -> CounterRoom
alterCurrentCount f (CounterRoom currentCount)  = 
    let
        newcurrentCount = f currentCount
    in
        (CounterRoom newcurrentCount) 



