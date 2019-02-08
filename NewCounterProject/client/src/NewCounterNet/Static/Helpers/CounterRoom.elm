module NewCounterNet.Static.Helpers.CounterRoom exposing (..)
import Dict exposing (Dict)

import NewCounterNet.Static.ExtraTypes exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.Types

getCurrentCount : CounterRoom -> Int
getCurrentCount (CounterRoom currentCount)  = currentCount



updateCurrentCount : Int -> CounterRoom -> CounterRoom
updateCurrentCount newcurrentCount (CounterRoom currentCount)  = (CounterRoom newcurrentCount) 


alterCurrentCount : (Int -> Int) -> CounterRoom -> CounterRoom
alterCurrentCount f (CounterRoom currentCount)  = 
    let
        newcurrentCount = f currentCount
    in
        (CounterRoom newcurrentCount) 



