{-# LANGUAGE ScopedTypeVariables, OverloadedStrings #-}

module Utils.Utils where

import Data.Char (ord,chr)
import qualified Data.Text as T
import Static.ServerTypes
import Static.Types
import           Control.Concurrent.STM         (TQueue, atomically, readTQueue,
                                                 writeTQueue, STM, newTQueue)
import qualified Data.Map.Strict as Dict
import Static.Dict
import qualified Data.TMap as TM
import Data.Maybe (fromJust,isJust)
import qualified Data.IntMap.Strict as IM'


(|>) :: a -> (a -> b) -> b
(|>) x f = f x

infixl 0 |>

(<|) :: (a -> b) -> a -> b
(<|) f x = f x

infixr 0 <|

data Result error value = 
      Err error 
    | Ok value

toFloat :: Integral a => a -> Double
toFloat = fromIntegral

rMap :: (a -> value) -> Result x a -> Result x value
rMap fn ra =
    case ra of 
        Err x -> Err x
        Ok a -> Ok $ fn a

rMap1 :: (a -> value) -> Result x a -> Result x value
rMap1 = rMap


rMap2 :: (a -> b -> value) -> Result x a -> Result x b -> Result x value
rMap2 fn ra rb =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b -> Ok $ fn a b

rMap3 :: (a -> b -> c -> value) -> Result x a -> Result x b -> Result x c -> Result x value
rMap3 fn ra rb rc =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> Ok $ fn a b c

rMap4 :: (a -> b -> c -> d -> value) -> Result x a -> Result x b -> Result x c -> Result x d -> Result x value
rMap4 fn ra rb rc rd =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> Ok $ fn a b c d

rMap5 :: (a -> b -> c -> d -> e -> value) -> Result x a -> Result x b -> Result x c -> Result x d -> Result x e -> Result x value
rMap5 fn ra rb rc rd re =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> 
                                    case re of 
                                        Err x -> Err x
                                        Ok e -> Ok $ fn a b c d e

rMap6 :: (a -> b -> c -> d -> e -> f -> value) -> Result x a -> Result x b -> Result x c -> Result x d -> Result x e -> Result x f -> Result x value
rMap6 fn ra rb rc rd re rf =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> 
                                    case re of 
                                        Err x -> Err x
                                        Ok e ->
                                            case rf of 
                                                Err x -> Err x
                                                Ok f -> Ok $ fn a b c d e f

rMap7 :: (a -> b -> c -> d -> e -> f -> g -> value) -> Result x a -> Result x b -> Result x c -> Result x d -> Result x e -> Result x f -> Result x g -> Result x value
rMap7 fn ra rb rc rd re rf rg =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> 
                                    case re of 
                                        Err x -> Err x
                                        Ok e ->
                                            case rf of 
                                                Err x -> Err x
                                                Ok f -> 
                                                    case rg of 
                                                        Err x -> Err x
                                                        Ok g -> Ok $ fn a b c d e f g

rMap8 :: (a -> b -> c -> d -> e -> f -> g -> h -> value)
      -> Result x a
      -> Result x b
      -> Result x c
      -> Result x d
      -> Result x e
      -> Result x f
      -> Result x g
      -> Result x h 
      -> Result x value
rMap8 fn ra rb rc rd re rf rg rh =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> 
                                    case re of 
                                        Err x -> Err x
                                        Ok e ->
                                            case rf of 
                                                Err x -> Err x
                                                Ok f -> 
                                                    case rg of 
                                                        Err x -> Err x
                                                        Ok g ->
                                                            case rh of 
                                                                Err x -> Err x
                                                                Ok h -> Ok $ fn a b c d e f g h

rMap9 :: (a -> b -> c -> d -> e -> f -> g -> h -> i -> value)
      -> Result x a
      -> Result x b
      -> Result x c
      -> Result x d
      -> Result x e
      -> Result x f
      -> Result x g
      -> Result x h
      -> Result x i
      -> Result x value
rMap9 fn ra rb rc rd re rf rg rh ri =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> 
                                    case re of 
                                        Err x -> Err x
                                        Ok e ->
                                            case rf of 
                                                Err x -> Err x
                                                Ok f -> 
                                                    case rg of 
                                                        Err x -> Err x
                                                        Ok g ->
                                                            case rh of 
                                                                Err x -> Err x
                                                                Ok h ->
                                                                    case ri of 
                                                                        Err x -> Err x
                                                                        Ok i -> Ok $ fn a b c d e f g h i

rMap10 :: (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> value)
      -> Result x a
      -> Result x b
      -> Result x c
      -> Result x d
      -> Result x e
      -> Result x f
      -> Result x g
      -> Result x h
      -> Result x i
      -> Result x j
      -> Result x value
rMap10 fn ra rb rc rd re rf rg rh ri rj =
    case ra of 
        Err x -> Err x
        Ok a -> 
            case rb of 
                Err x -> Err x
                Ok b ->
                    case rc of 
                        Err x -> Err x
                        Ok c -> 
                            case rd of 
                                Err x -> Err x
                                Ok d -> 
                                    case re of 
                                        Err x -> Err x
                                        Ok e ->
                                            case rf of 
                                                Err x -> Err x
                                                Ok f -> 
                                                    case rg of 
                                                        Err x -> Err x
                                                        Ok g ->
                                                            case rh of 
                                                                Err x -> Err x
                                                                Ok h ->
                                                                    case ri of 
                                                                        Err x -> Err x
                                                                        Ok i ->
                                                                            case rj of 
                                                                                Err x -> Err x
                                                                                Ok j -> Ok $ fn a b c d e f g h i j

clamp :: Ord number => number -> number -> number -> number
clamp a b x = min b (max a x)

randThen :: (a -> Result x b) -> Result x a -> Result x b
randThen callback result =
    case result of
      Ok value ->
        callback value

      Err msg ->
        Err msg

rwithDefault :: a -> Result x a -> a
rwithDefault def result =
  case result of
    Ok a ->
        a

    Err _ ->
        def

tConcat :: [T.Text] -> T.Text
tConcat = T.concat

sConcat :: [String] -> String
sConcat = concat


encodeInt :: Int -> Int -> Int -> T.Text
encodeInt low high n =
    let
        encodeInt_ :: Int -> [Char]
        encodeInt_ nn =
            let 
                b = 64
                r = nn `mod` b
                m = nn `div` b
            in    
                if nn < 64 then [chr <| r + 48]
                else (chr <| r + 48) : encodeInt_ m
    in
        T.pack $ encodeInt_ (clamp low high n - low)

decodeInt :: Int -> Int -> T.Text -> Result T.Text Int
decodeInt low high s =
    let 
        decodeInt_ m s_ = case s_ of
                            f:rest -> (ord f - 48) * m + decodeInt_ (m*64) rest
                            []      -> 0
        n = (decodeInt_ 1 $ T.unpack s) + low
    in
        if n >= low && n <= high then  Ok <| n
        else                           Err <| T.concat ["Could not decode ", T.pack $ show n, " as it is outside the range [", T.pack $ show low, ",", T.pack $ show high, "]."]

decodeList :: forall a . [T.Text] -> ((Result T.Text a, [T.Text]) -> (Result T.Text a, [T.Text])) -> (Result T.Text [a], [T.Text])
decodeList ls decodeFn =
    let 
        aR :: Result T.Text a -> Result T.Text [a] -> Result T.Text [a]
        aR aRes laRes =
            rMap2 (\a la -> la ++ [a]) aRes laRes
        n =
            rwithDefault 0 <| case ls of 
                nTxt:rest -> decodeInt 0 16777215 nTxt
                []           -> Err "Could not decode number of items in list."

        decodeList' :: (Result T.Text [a],[T.Text]) -> Int -> (Result T.Text [a],[T.Text])
        decodeList' (resL, mainLs) _ = 
            let 
                (newRes, newLs) = decodeFn (Err "", mainLs)
            in
                (aR newRes resL, newLs)
    in
        foldl decodeList' (Ok [], drop 1 ls) [1..n]

decodeBool :: [T.Text] -> (Result T.Text Bool, [T.Text])
decodeBool ls =
    case ls of
        "T":rest -> (Ok True, rest)
        "F":rest -> (Ok False, rest)
        _ -> (Err "Error decoding boolean value",[])

decodeString :: [T.Text] -> (Result T.Text String, [T.Text])
decodeString ls =
    case ls of
        fst:rest -> (Ok $ T.unpack fst, rest)
        _ -> (Err "Error decoding string value",[])

decodeMaybe :: [T.Text] -> ((Result T.Text a, [T.Text]) -> (Result T.Text a, [T.Text])) -> (Result T.Text (Maybe a), [T.Text])
decodeMaybe ls decodeFn =
    case ls of
        ("J":rest) -> 
            let
                (newRes, newLs) = decodeFn (Err "", rest)
            in
                (rMap Just newRes,newLs)
        ("N":rest) ->
            (Ok Nothing, rest)
        _ -> (Err "Ran out of items or error while decoding a Maybe.",[])

decodeDict :: Ord a => (Result T.Text [(a,b)], [T.Text]) -> (Result T.Text (Dict a b), [T.Text])
decodeDict (res,lst) =
    (rMap Dict.fromList res, lst)
        
giveReceivingQueue :: TQueue a -> (TQueue b -> a) -> STM (TQueue b)
giveReceivingQueue commandQueue signalConstructor = do
    channel <- newTQueue
    writeTQueue commandQueue (signalConstructor channel)
    return channel

lLength :: Foldable t => t a -> Int
lLength = length

pFst = fst

lFoldl :: (a -> b -> b) -> b -> [a] -> b
lFoldl f init lst = foldl (flip f) init lst

lRange a b = [a..b]

cmdMap :: (a -> b) -> Cmd a -> Cmd b
cmdMap f ca =
    case ca of 
        Cmd msg -> Cmd (fmap f msg)
        StateCmd msg -> StateCmd (fmap f . msg)

processCmd :: Cmd NetTransition -> TQueue CentralMessage -> NetState player -> IO ()
processCmd cmd centralMsgQ ns = do
    case cmd of
        Cmd msg -> do
            result <- msg
            atomically $ writeTQueue centralMsgQ $ ReceivedMessage Nothing result
        StateCmd toMsg -> do
            result <- toMsg ((safeFromJust "processCmd") $ TM.lookup $ pluginStates ns)
            atomically $ writeTQueue centralMsgQ $ ReceivedMessage Nothing result


safeFromJust msg j = 
    if isJust j then
        fromJust j
    else
        error $ "not isJust: " ++ msg

mapSnd :: (a -> b) -> [(c, a)] -> [(c, b)]
mapSnd f l =
    map (\(c,a) -> (c,f a)) l

insertList :: [(IM'.Key, a)] -> IM'.IntMap a -> IM'.IntMap a
insertList l im =
    foldl (\m (i,a) -> IM'.insert i a m) im l
{-
processCmd :: Cmd a -> IO ()
processCmd cmd =
    case cmd of
-}