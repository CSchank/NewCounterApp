module Static.Decode exposing(..)
import Static.Types exposing(..)
import Utils.Utils exposing(..)
import NewCounterNet.Static.Decode


decodeIncomingMessage : String -> NetModel -> Result String NetIncomingMessage
decodeIncomingMessage txt clientNet =
    case clientNet of
        NewCounterNet _ -> rMap NewCounterNetInMsg <| Tuple.first <| NewCounterNet.Static.Decode.decodeIncomingMessage (Err "",String.split "\u{0000}" txt)
