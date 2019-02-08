module NewCounterNet.Static.Init exposing(..)
import NewCounterNet.Init as Init
import NewCounterNet.Static.Types exposing (NetState(..))
import NewCounterNet.Update as Update
import NewCounterNet.Static.Wrappers
import NewCounterNet.Static.ExtraTypes exposing(..)

init : NetState
init = SCounterRoom Init.init
