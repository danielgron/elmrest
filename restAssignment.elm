import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Debug

type Msg
  = NewCount (Result Http.Error String)
  | GetCount
  | SetCount

type alias Model
  = { url : String }

view : Model -> Html Msg
view model =
    div []
      [ button [ onClick GetCount ] [ text ("Number is now: " ++ model.url)]
      ,button [ onClick SetCount ] [ text ("Set number: " )]
      ]

decodeCount : Decode.Decoder String
decodeCount = Decode.at ["value"] Decode.string




getCount : Cmd Msg
getCount =
  let
    url = "http://localhost:8084/elmAssignmentRest/api/counter"
  in
    Http.send NewCount (Http.get url decodeCount)

sendPutToServer : String -> Cmd Msg
sendPutToServer message =
  let
    request = Http.request
      { method = "PUT"
      , headers = []
      , url = "http://localhost:8084/elmAssignmentRest/api/counter/" ++ message
      , body = Http.emptyBody
      , expect = Http.expectString
      , timeout = Nothing
      , withCredentials = False
      }
  in
    Http.send NewCount request


--setCount : Int -> Cmd Msg
--setCount value =
--  let
--    url = "http://localhost:8084/elmAssignmentRest/api/counter/" ++ (toString value)
--  in
--    Http.send NewCount (put url emptyBody)

update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case (Debug.log "Debug " message) of
    NewCount (Ok value) -> (Model value, Cmd.none)
    NewCount (Err error) -> (Model "Fuck this shit", Cmd.none)
    GetCount -> (model, getCount)
    SetCount -> (model, sendPutToServer "1")

main =
  Html.program
    { init = (Model "99", Cmd.none)
    , view = view
    , update = update
    , subscriptions = \x -> Sub.none }
