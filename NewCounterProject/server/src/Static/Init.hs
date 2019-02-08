module Static.Init where
import Static.Types
import NewCounterNet.Static.Init


init = NewCounterNet.Static.Init.init
-- reference to the initial Net
initNet :: NetModel
initNet = NewCounterNet
