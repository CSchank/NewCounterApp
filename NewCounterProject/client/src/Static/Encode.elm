module Static.Encode exposing(..)
import NewCounterNet.Static.Encode as NewCounterNet

import Static.Types exposing(NetOutgoingTransition(..))

encodeOutgoingTransition : NetOutgoingTransition -> String
encodeOutgoingTransition netTrans =
    case netTrans of
        NewCounterNetOTrans msg -> NewCounterNet.encodeOutgoingTransition msg

