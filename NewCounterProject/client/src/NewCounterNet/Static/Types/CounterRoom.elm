module NewCounterNet.Static.Types.CounterRoom exposing(..)
import NewCounterNet.Static.Types exposing(..)
import NewCounterNet.Static.ExtraTypes exposing(..)

type Msg  =
      ChangeCounter Int
    | GoToHistory
