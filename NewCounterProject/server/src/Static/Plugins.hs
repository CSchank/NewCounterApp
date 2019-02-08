module Static.Plugins where
import NewCounterNet.Static.Types as NewCounterNet

import Static.ServerTypes
import Static.Types
import Data.Maybe (fromJust)
import Control.Concurrent.STM (TQueue, atomically, writeTQueue)
import Data.TMap as TM (TMap,lookup)
import Utils.Utils as Utils

processCmd :: TQueue CentralMessage -> Maybe (Cmd NetTransition) -> NetTransition -> ServerState -> IO ()
processCmd centralMessageQueue mCmd nTrans state =
    case mCmd of
        Just cmd ->
            case nTrans of
                NewCounterNetTrans {} ->
                      Utils.processCmd cmd centralMessageQueue (safeFromJust "plugins" $ TM.lookup $ serverState state :: NetState NewCounterNet.Player)


        Nothing -> return ()
