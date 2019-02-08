module Static.Types where
import NewCounterNet.Static.Types


-- a type identifying all of the nets in the server
data NetModel  =
      NewCounterNet
    deriving(Show,Ord,Eq)
-- a union type of all the nets and their transitions
data NetTransition  =
      NewCounterNetTrans NewCounterNet.Static.Types.Transition
    deriving(Show,Ord,Eq)
-- a union type of all the nets and their transitions
data NetOutgoingMessage  =
      NewCounterNetOMsg NewCounterNet.Static.Types.ClientMessage
    deriving(Show,Ord,Eq)
