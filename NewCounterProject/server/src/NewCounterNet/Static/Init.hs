module NewCounterNet.Static.Init where
import NewCounterNet.Static.Types (Player)
import NewCounterNet.Init as Init
import NewCounterNet.Update as Update
import NewCounterNet.Static.Wrappers
import NewCounterNet.Static.Plugins (initPlugins)
import Static.ServerTypes
import qualified Data.IntMap as IM'
import qualified Data.TMap as TM

init :: IO (NetState Player)
init = do
    ip <- initPlugins
    return $ NetState
        {
          playerStates = IM'.empty
        , placeStates = TM.insert initHistoryRoom $ TM.insert initCounterRoom $ TM.empty
        , pluginStates = ip
        }
