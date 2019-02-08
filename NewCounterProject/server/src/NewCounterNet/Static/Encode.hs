{-# LANGUAGE OverloadedStrings #-}
module NewCounterNet.Static.Encode where
import NewCounterNet.Static.Types

import Utils.Utils
import qualified Data.Text as T
import Static.Types
import Data.Map.Strict as Dict
encodeClientMessage :: ClientMessage -> T.Text
encodeClientMessage clientmessage = 
    case clientmessage of
        MChangedCounter currentCount -> 
            let
                currentCountTxt = encodeInt 0 99999999 currentCount
            in
                tConcat ["MChangedCounter\0", currentCountTxt]
        MUpdateHistory newEntry -> 
            let
                newEntryTxt = encodeCounterHistory newEntry
            in
                tConcat ["MUpdateHistory\0", newEntryTxt]
        MWentToCounter currentCount -> 
            let
                currentCountTxt = encodeInt 0 99999999 currentCount
            in
                tConcat ["MWentToCounter\0", currentCountTxt]
        MWentToHistory counterHistoryList -> 
            let
                counterHistoryListTxt =
                    let
                        encodecounterHistoryList_ _ (str4,counterHistoryListList) =
                            case counterHistoryListList of
                                counter : rest ->
                                    let
                                        counterTxt = encodeCounterHistory counter
                                    in
                                        (tConcat [str4,"\0",counterTxt], rest)
                                [] -> (str4,counterHistoryListList)
                        encodecounterHistoryList ls =
                            lFoldl encodecounterHistoryList_ ("",ls) (lRange 0 (lLength counterHistoryList))
                    in
                        tConcat [encodeInt 0 16777216 <| lLength counterHistoryList, pFst <| encodecounterHistoryList counterHistoryList]
            in
                tConcat ["MWentToHistory\0", counterHistoryListTxt]


-- extra type encoders
encodeCounterHistory :: CounterHistory -> T.Text
encodeCounterHistory counterhistory = 
    case counterhistory of
        CounterHistory currentCount time -> 
            let
                currentCountTxt = encodeInt 0 99999999 currentCount
                timeTxt = encodeInt 0 9999999999999 time
            in
                tConcat ["CounterHistory\0", currentCountTxt,"\0",timeTxt]



