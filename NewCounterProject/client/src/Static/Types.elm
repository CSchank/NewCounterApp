module Static.Types exposing(..)
import NewCounterNet.Static.Types


type alias TopLevelData = ()
-- a type identifying all of the nets in the server
type NetModel  =
      NewCounterNet NewCounterNet.Static.Types.NetState
-- a union type of all the nets and their incoming transitions
type NetIncomingMessage  =
      NewCounterNetInMsg NewCounterNet.Static.Types.IncomingMessage
-- a union type of all the nets and their outgoing transitions
type NetOutgoingTransition  =
      NewCounterNetOTrans NewCounterNet.Static.Types.OutgoingTransition
