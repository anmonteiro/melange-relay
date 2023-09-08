open Types

type nonrec 'response updaterFn =
  RecordSourceSelectorProxy.t -> 'response -> unit

type nonrec ('node, 'variables, 'response) subscriptionConfig =
  { subscription : 'node subscriptionNode
  ; variables : 'variables
  ; onCompleted : (unit -> unit) option [@mel.optional]
  ; onError : (Js.Exn.t -> unit) option [@mel.optional]
  ; onNext : ('response -> unit) option [@mel.optional]
  ; updater : 'response updaterFn option [@mel.optional]
  }
[@@deriving abstract]

external requestSubscription_ :
   Environment.t
  -> ('node, 'variables, 'response) subscriptionConfig
  -> Disposable.t
  = "requestSubscription"
[@@module "relay-runtime"]

let subscribe
    ~node
    ~(convertVariables : 'variables -> 'variables)
    ~(convertResponse : 'response -> 'response)
    ~(environment : Environment.t)
    ~(variables : 'variables)
    ?onCompleted
    ?onError
    ?onNext
    ?updater
    ()
  =
  requestSubscription_
    environment
    (subscriptionConfig
       ?onCompleted
       ~subscription:node
       ~variables:(variables |. convertVariables)
       ?onError
       ?onNext:
         (match onNext with
         | Some onNext ->
           Some (fun response -> onNext (response |. convertResponse))
         | None -> None)
       ?updater:
         (match updater with
         | Some updater ->
           Some
             (fun store response -> updater store (response |. convertResponse))
         | None -> None)
       ())
