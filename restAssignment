import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode

type Msg
  = NewGif (Result Http.Error String)
  | GetGif

type alias Model
  = { url : String }

view : Model -> Html Msg
view model =
    div []
      [ button [ onClick GetGif ] [ text "Gif moar gif"]
      , img [ src model.url] [] ]

decodeGifUrl : Decode.Decoder String
decodeGifUrl = Decode.at ["data", "image_url"] Decode.string

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Http.send NewGif (Http.get url decodeGifUrl)

update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  case message of
    NewGif (Ok value) -> (Model value, Cmd.none)
    NewGif (Err _) -> (model, Cmd.none)
    GetGif -> (model, getRandomGif "funny+cats")

main =
  Html.program
    { init = (Model "", Cmd.none)
    , view = view
    , update = update
    , subscriptions = \x -> Sub.none }
