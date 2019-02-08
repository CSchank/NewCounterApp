module Static.Update exposing(..)
import NewCounterNet.Static.Update as NewCounterNet

import Static.Types exposing(..)
import Maybe

update : TopLevelData -> NetIncomingMessage -> NetModel -> (NetModel, Maybe (Cmd NetOutgoingTransition))
update tld netInMsg state =
        case (netInMsg,state) of
            (NewCounterNetInMsg msg, NewCounterNet m) ->
                let
                    (newNewCounterNetState, mcmd) = NewCounterNet.update tld msg m
                    newClientState = NewCounterNet newNewCounterNetState
                in (newClientState, Maybe.map (Cmd.map NewCounterNetOTrans) mcmd)



