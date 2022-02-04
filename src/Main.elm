port module Main exposing (..)

import Platform as P


main =
    P.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { fileContents : FileContents
    }


type Msg
    = NoOp
    | ReceiveFile FileContents
    | Log String
    | PrintModel
    | FileContents


type alias FileContents =
    String


init : () -> ( Model, Cmd Msg )
init _ =
    ( { fileContents = "" }, log "Init from elm!" )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ReceiveFile contents ->
            ( { model
                | fileContents = contents
              }
            , log <| "File contents loaded into Model\n"
            )

        Log str ->
            ( model, log str )

        PrintModel ->
            ( model, log <| Debug.toString model )

        FileContents ->
            ( model, log model.fileContents )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ receiveFile ReceiveFile
        , showModel (\_ -> PrintModel)
        , fileContents (\_ -> FileContents)
        ]


port receiveFile : (FileContents -> msg) -> Sub msg


port showModel : (() -> msg) -> Sub msg


port fileContents : (() -> msg) -> Sub msg


port log : String -> Cmd msg
