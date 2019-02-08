module Static.Init exposing (..)
import Static.Types exposing(..)
import NewCounterNet.Static.Init

init : (NetModel, Cmd NetOutgoingTransition)
init = (NewCounterNet NewCounterNet.Static.Init.init, Cmd.none)
