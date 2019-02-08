module Static.Encode where
import NewCounterNet.Static.Encode as NewCounterNet

import Static.ServerTypes
import Data.Text as T
import Static.Types

encodeOutgoingMessage :: NetOutgoingMessage -> T.Text
encodeOutgoingMessage netTrans =
    case netTrans of
        NewCounterNetOMsg msg -> NewCounterNet.encodeClientMessage msg

