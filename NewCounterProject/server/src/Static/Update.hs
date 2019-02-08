module Static.Update where
import NewCounterNet.Static.Update as NewCounterNet

import Static.Types
import qualified Data.TMap as TM
import Static.ServerTypes
import Utils.Utils
import Data.Maybe (fromJust,mapMaybe,isJust)

update :: TopLevelData -> Maybe ClientID -> NetTransition -> ServerState -> (ServerState, [(ClientID,NetOutgoingMessage)], Maybe (Cmd NetTransition))
update tld mClientID netTrans state =
    case netTrans of
        NewCounterNetTrans msg ->
            let
                (newNetState, clientMessages, mCmd) = NewCounterNet.update tld mClientID msg (safeFromJust "update case" $ TM.lookup $ serverState state)
                cmd = fmap (\m -> cmdMap NewCounterNetTrans m) mCmd
                cMsgs = map (\(cId,m) -> (cId,NewCounterNetOMsg m)) clientMessages
                newServerState = state { serverState = TM.insert newNetState (serverState state) }
            in (newServerState, cMsgs, cmd)


clientConnect :: TopLevelData -> ClientID -> ServerState -> ServerState
clientConnect tld clientID state =
    let
        newNetState = NewCounterNet.clientConnect tld clientID (safeFromJust "client connect" $ TM.lookup $ serverState state)
    in
        state { serverState = TM.insert newNetState $ serverState state }

disconnect :: TopLevelData -> ClientID -> NetModel -> ServerState -> ServerState
disconnect tld clientID netModel state =
    let
        newNetState =
            case netModel of
                NewCounterNet {} -> NewCounterNet.disconnect tld clientID (safeFromJust "top level disconnect" $ TM.lookup $ serverState state)

    in
        state { serverState = TM.insert newNetState $ serverState state }
