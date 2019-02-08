module NewCounterNet.Static.Encode exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)

import Utils.Utils exposing(..)
import Static.Types
encodeOutgoingTransition : OutgoingTransition -> String
encodeOutgoingTransition outgoingtransition = 
    case outgoingtransition of
        TChangeCounter increment -> 
            let
                incrementTxt = encodeInt -1 1 increment
            in
                tConcat ["TChangeCounter\u{0000}", incrementTxt]
        TGoToCounter ->                 tConcat ["TGoToCounter\u{0000}"]
        TGoToHistory ->                 tConcat ["TGoToHistory\u{0000}"]


--extra types encoders
encodeCounterHistory : CounterHistory -> String
encodeCounterHistory counterhistory = 
    case counterhistory of
        CounterHistory currentCount time -> 
            let
                currentCountTxt = encodeInt 0 99999999 currentCount
                timeTxt = encodeInt 0 9999999999999 time
            in
                tConcat ["CounterHistory\u{0000}", currentCountTxt,"\u{0000}",timeTxt]



