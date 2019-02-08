{-# LANGUAGE OverloadedStrings #-}

module ClientServerSpec where

import Types
import TypeHelpers

--directory to output the generated files
outputDirectory = "NewCounterProject"
--where the generator is
generatorRoot = "../elm-haskell-state-diagram"


currentCount = edt (ElmIntRange 0 99999999) "currentCount" "the current counter state"
time = edt (ElmIntRange 0 9999999999999) "time" "the time that the counter was changed"

counterHistoryList = edt (ElmList $ edt (ElmType "CounterHistory") "counter" "") "counterHistoryList" ""

counterHistoryType :: ElmCustom
counterHistoryType = ec -- helper to make custom types
                "CounterHistory" -- name of type (Elm syntax rules)
                [("CounterHistory",
                            [
                              currentCount
                            , time
                            ]
                 )
                ]

exampleNet :: Net
exampleNet =
    let
        placeOne =
            HybridPlace "HistoryRoom" 
                    [counterHistoryList] --server state
                    []                   --player state
                    [counterHistoryList] --client state
                    Nothing
                    (Nothing, Nothing)
                    Nothing

        placeTwo =
            HybridPlace "CounterRoom"
                    [currentCount] --server state
                    []             --player state
                    [currentCount] --client state
                    Nothing
                    (Nothing, Nothing)
                    Nothing

        changeCounter =                 
            NetTransition

                (constructor "ChangeCounter" [edt (ElmIntRange (-1) 1) "increment" "the amount to change by"])
                
                [ ("CounterRoom", Just ("CounterRoom", constructor "ChangedCounter" [currentCount]))
                , ("HistoryRoom", Just ("HistoryRoom", constructor "UpdateHistory" [edt (ElmType "CounterHistory") "newEntry" "the newest entry in the history"]))
                ]

                Nothing

        goToCounter =                 
            NetTransition
                (constructor "GoToCounter" [])
                [("HistoryRoom", Just ("CounterRoom", constructor "WentToCounter" [currentCount]))
                ,("HistoryRoom", Nothing)
                ]
                Nothing

        goToHistory =                 
            NetTransition
                (constructor "GoToHistory" [])
                [("CounterRoom", Just ("HistoryRoom", constructor "WentToHistory" [counterHistoryList]))
                ,("CounterRoom", Nothing)
                ]
                Nothing
    in
        HybridNet
            "NewCounterNet"
            "CounterRoom"
            [placeOne, placeTwo]
            [(ClientOnlyTransition,changeCounter),(ClientOnlyTransition,goToCounter),(ClientOnlyTransition,goToHistory)]
            []


clientServerApp :: ClientServerApp
clientServerApp =
    ( "NewCounterNet"            --starting net for a client
    , [exampleNet]             --all the nets in this client/server app
    , [counterHistoryType]              --extra client types used in states or messages
    )
