module NewCounterNet.Static.Update where
import NewCounterNet.Static.Types
import NewCounterNet.Static.Wrappers
import NewCounterNet.Static.FromSuperPlace (FromSuperPlace(..))
import NewCounterNet.Update as Update
import qualified Data.TMap as TM
import Static.ServerTypes
import qualified Data.IntMap.Strict as IM'
import Data.Maybe (fromJust, isJust, mapMaybe)
import Utils.Utils

-- player processing functions
processChangeCounterPlayer :: ((ClientID, CounterRoomPlayer) -> ChangeCounterfromCounterRoom) -> ((ClientID, HistoryRoomPlayer) -> ChangeCounterfromHistoryRoom) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processChangeCounterPlayer fromCounterRoom fromHistoryRoom (cId,player) = case player of
    PCounterRoomPlayer  -> let (np, mCm) = (unwrapChangeCounterfromCounterRoom $ fromCounterRoom (cId,wrapCounterRoomPlayer player)) in ((cId, np), (cId, mCm))
    PHistoryRoomPlayer  -> let (np, mCm) = (unwrapChangeCounterfromHistoryRoom $ fromHistoryRoom (cId,wrapHistoryRoomPlayer player)) in ((cId, np), (cId, mCm))


processGoToCounterPlayer :: ((ClientID, HistoryRoomPlayer) -> GoToCounterfromHistoryRoom) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processGoToCounterPlayer fromHistoryRoom (cId,player) = case player of
    PHistoryRoomPlayer  -> let (np, mCm) = (unwrapGoToCounterfromHistoryRoom $ fromHistoryRoom (cId,wrapHistoryRoomPlayer player)) in ((cId, np), (cId, mCm))


processGoToHistoryPlayer :: ((ClientID, CounterRoomPlayer) -> GoToHistoryfromCounterRoom) -> (ClientID, Player) -> ((ClientID, Player), (ClientID, Maybe ClientMessage))
processGoToHistoryPlayer fromCounterRoom (cId,player) = case player of
    PCounterRoomPlayer  -> let (np, mCm) = (unwrapGoToHistoryfromCounterRoom $ fromCounterRoom (cId,wrapCounterRoomPlayer player)) in ((cId, np), (cId, mCm))



-- player splitting functions
splitChangeCounterPlayers :: [(ClientID,Player)] -> ([(ClientID,CounterRoomPlayer)],[(ClientID,HistoryRoomPlayer)])
splitChangeCounterPlayers players = foldl (\t@(fromCounterRoomlst,fromHistoryRoomlst) pl -> case pl of
    (cId,p@(PCounterRoomPlayer {})) -> ((cId,wrapCounterRoomPlayer p):fromCounterRoomlst,fromHistoryRoomlst)
    (cId,p@(PHistoryRoomPlayer {})) -> (fromCounterRoomlst,(cId,wrapHistoryRoomPlayer p):fromHistoryRoomlst)

    _ -> t) ([],[]) players

splitGoToCounterPlayers :: [(ClientID,Player)] -> ([(ClientID,HistoryRoomPlayer)])
splitGoToCounterPlayers players = foldl (\t@(fromHistoryRoomlst) pl -> case pl of
    (cId,p@(PHistoryRoomPlayer {})) -> ((cId,wrapHistoryRoomPlayer p):fromHistoryRoomlst)

    _ -> t) ([]) players

splitGoToHistoryPlayers :: [(ClientID,Player)] -> ([(ClientID,CounterRoomPlayer)])
splitGoToHistoryPlayers players = foldl (\t@(fromCounterRoomlst) pl -> case pl of
    (cId,p@(PCounterRoomPlayer {})) -> ((cId,wrapCounterRoomPlayer p):fromCounterRoomlst)

    _ -> t) ([]) players


-- process player connect
clientConnect :: FromSuperPlace -> ClientID -> NetState Player -> NetState Player
clientConnect fsp clientID state =
    let
        (counterRoom,counterRoomPlayer) = Update.clientConnect fsp clientID (safeFromJust "client connect Net" $ TM.lookup $ placeStates state)
    in
        state { placeStates = TM.insert counterRoom $ placeStates state, playerStates = IM'.insert clientID (unwrapCounterRoomPlayer counterRoomPlayer) (playerStates state) }

-- process player disconnects
disconnect :: FromSuperPlace -> ClientID -> NetState Player -> NetState Player
disconnect fsp clientID state =
    let
        player = safeFromJust "disconnect" $ IM'.lookup clientID $ players
        places = placeStates state
        players = playerStates state
        newPlaces = case player of
            PHistoryRoomPlayer {} -> (flip TM.insert) places $ clientDisconnectFromHistoryRoom fsp clientID (safeFromJust "clientDisconnectFrom" $ TM.lookup places) (wrapHistoryRoomPlayer player)
            PCounterRoomPlayer {} -> (flip TM.insert) places $ clientDisconnectFromCounterRoom fsp clientID (safeFromJust "clientDisconnectFrom" $ TM.lookup places) (wrapCounterRoomPlayer player)

        newPlayers = IM'.delete clientID players
    in
        state { playerStates = newPlayers, placeStates = newPlaces }

update :: TopLevelData -> Maybe ClientID -> Transition -> NetState Player -> (NetState Player,[(ClientID,ClientMessage)],Maybe (Cmd Transition))
update tld mClientID trans state =
    let
        places = placeStates state
        players = playerStates state
        (newPlaces, newPlayers, clientMessages, cmd) = 
            case trans of
                (TChangeCounter increment) ->
                    let
                        (counterRoomPlayerLst,historyRoomPlayerLst) = splitChangeCounterPlayers (IM'.toList players)
                        (counterRoom,historyRoom,fromCounterRoom,fromHistoryRoom) = updateChangeCounter tld (fromJust mClientID) (wrapChangeCounter trans) ((safeFromJust "place lookup") $ TM.lookup places) ((safeFromJust "place lookup") $ TM.lookup places) (map snd counterRoomPlayerLst) (map snd historyRoomPlayerLst)
                        newPlaces = TM.insert counterRoom $ TM.insert historyRoom places
                        (newPlayers, clientMessages) = unzip $ map (processChangeCounterPlayer fromCounterRoom fromHistoryRoom) (mapSnd unwrapCounterRoomPlayer counterRoomPlayerLst++mapSnd unwrapHistoryRoomPlayer historyRoomPlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)

                TGoToCounter ->
                    let
                        (historyRoomPlayerLst) = splitGoToCounterPlayers (IM'.toList players)
                        (historyRoom,counterRoom,fromHistoryRoom) = updateGoToCounter tld (fromJust mClientID) (wrapGoToCounter trans) ((safeFromJust "place lookup") $ TM.lookup places) ((safeFromJust "place lookup") $ TM.lookup places) (map snd historyRoomPlayerLst)
                        newPlaces = TM.insert historyRoom $ TM.insert counterRoom places
                        (newPlayers, clientMessages) = unzip $ map (processGoToCounterPlayer fromHistoryRoom) (mapSnd unwrapHistoryRoomPlayer historyRoomPlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)

                TGoToHistory ->
                    let
                        (counterRoomPlayerLst) = splitGoToHistoryPlayers (IM'.toList players)
                        (counterRoom,historyRoom,fromCounterRoom) = updateGoToHistory tld (fromJust mClientID) (wrapGoToHistory trans) ((safeFromJust "place lookup") $ TM.lookup places) ((safeFromJust "place lookup") $ TM.lookup places) (map snd counterRoomPlayerLst)
                        newPlaces = TM.insert counterRoom $ TM.insert historyRoom places
                        (newPlayers, clientMessages) = unzip $ map (processGoToHistoryPlayer fromCounterRoom) (mapSnd unwrapCounterRoomPlayer counterRoomPlayerLst)
                    in
                        (newPlaces, newPlayers, clientMessages, Nothing)


    in
        (state
           {
                placeStates = newPlaces
           ,    playerStates = insertList newPlayers $ players
           }
        , mapMaybe (\(a,b) -> if isJust b then Just (a,fromJust b) else Nothing) clientMessages
        , cmd)
