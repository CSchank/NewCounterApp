{-# LANGUAGE OverloadedStrings #-}
module NewCounterNet.Static.Decode where
import NewCounterNet.Static.Types

import Utils.Utils
import qualified Data.Text as T
decodeTransition  ::  (Result T.Text Transition, [T.Text]) -> (Result T.Text Transition, [T.Text])
decodeTransition (lastRes,transitionTxts) = 
    case transitionTxts of
        ("TChangeCounter" : rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (incrementTxt : ll4) -> (decodeInt (-1) (1) incrementTxt |> randThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing Transition",[]))
                 |>
                        (\(r4,l5) -> (rMap1 TChangeCounter r4,l5))
        ("TGoToCounter" : rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| TGoToCounter ,l4))
        ("TGoToHistory" : rest) ->
            (Err "",rest) |> 
                    (\(r3,l4) -> (Ok <| TGoToHistory ,l4))

        _ -> (Err <| tConcat ["Incorrect input, could not decode value of type Transition from string \"", tConcat transitionTxts, "\""],[])

-- extra type decoders
decodeCounterHistory  ::  (Result T.Text CounterHistory, [T.Text]) -> (Result T.Text CounterHistory, [T.Text])
decodeCounterHistory (lastRes,counterhistoryTxts) = 
    case counterhistoryTxts of
        ("CounterHistory" : rest) ->
            (Err "",rest) |> 
                \(r3,l4) ->
                        (case l4 of
                            (currentCountTxt : ll4) -> (decodeInt (0) (99999999) currentCountTxt |> randThen Ok,ll4)
                            [] -> (Err "Ran out of string to process while parsing CounterHistory",[]))
                 |>
                    \(r4,l5) ->
                            (case l5 of
                                (timeTxt : ll5) -> (decodeInt (0) (9999999999999) timeTxt |> randThen Ok,ll5)
                                [] -> (Err "Ran out of string to process while parsing CounterHistory",[]))
                     |>
                            (\(r5,l6) -> (rMap2 CounterHistory r4 r5,l6))

        _ -> (Err <| tConcat ["Incorrect input, could not decode value of type CounterHistory from string \"", tConcat counterhistoryTxts, "\""],[])


