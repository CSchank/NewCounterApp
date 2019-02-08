module NewCounterNet.Static.Decode exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)

import Utils.Utils exposing(..)
decodeIncomingMessage  :  (Result String IncomingMessage, List String) -> (Result String IncomingMessage, List String)
decodeIncomingMessage (lastRes,incomingmessageTxts) = 
    case incomingmessageTxts of
        ("MChangedCounter" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (currentCountTxt :: ll4) -> (decodeInt (0) (99999999) currentCountTxt |> randThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing IncomingMessage",[]))
                 |>
                        (\(r4,l5) -> (rMap1 MChangedCounter r4,l5))
        ("MUpdateHistory" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                    decodeCounterHistory (r3,l4)
                 |>
                        (\(r4,l5) -> (rMap1 MUpdateHistory r4,l5))
        ("MWentToCounter" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (currentCountTxt :: ll4) -> (decodeInt (0) (99999999) currentCountTxt |> randThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing IncomingMessage",[]))
                 |>
                        (\(r4,l5) -> (rMap1 MWentToCounter r4,l5))
        ("MWentToHistory" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                (\(r4,l5) ->
                        decodeCounterHistory (r4,l5)) |>
                    decodeList l4
                 |>
                        (\(r4,l5) -> (rMap1 MWentToHistory r4,l5))

        _ -> (Err <| tConcat ["Incorrect input, could not decode value of type IncomingMessage from string \"", tConcat incomingmessageTxts, "\""],[])

--extra types decoders
decodeCounterHistory  :  (Result String CounterHistory, List String) -> (Result String CounterHistory, List String)
decodeCounterHistory (lastRes,counterhistoryTxts) = 
    case counterhistoryTxts of
        ("CounterHistory" :: rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (currentCountTxt :: ll4) -> (decodeInt (0) (99999999) currentCountTxt |> randThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing CounterHistory",[]))
                 |>
                    \(r4,l5) ->
                            (case l5 of
                                (timeTxt :: ll5) -> (decodeInt (0) (9999999999999) timeTxt |> randThen Ok,ll5)
                                [] -> (Err "Ran out of string to process while parsing CounterHistory",[]))
                     |>
                            (\(r5,l6) -> (rMap2 CounterHistory r4 r5,l6))

        _ -> (Err <| tConcat ["Incorrect input, could not decode value of type CounterHistory from string \"", tConcat counterhistoryTxts, "\""],[])


