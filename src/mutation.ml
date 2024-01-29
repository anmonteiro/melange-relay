open Types

type nonrec 'response updaterFn =
  RecordSourceSelectorProxy.t -> 'response -> unit

type nonrec optimisticUpdaterFn = RecordSourceSelectorProxy.t -> unit

type nonrec ('response, 'rawResponse, 'variables) useMutationConfig =
  { onError : (mutationError -> unit) option [@mel.optional]
  ; onCompleted : ('response -> mutationError array option -> unit) option
        [@mel.optional]
  ; onUnsubscribe : (unit -> unit) option [@mel.optional]
  ; optimisticResponse : 'rawResponse option [@mel.optional]
  ; optimisticUpdater : optimisticUpdaterFn option [@mel.optional]
  ; updater : 'response updaterFn option [@mel.optional]
  ; variables : 'variables
  ; uploadables : uploadables option [@mel.optional]
  }
[@@deriving jsProperties, getSet]

type nonrec ('m, 'variables, 'response, 'rawResponse) commitMutationConfigRaw =
  { mutation : 'm mutationNode
  ; variables : 'variables
  ; onCompleted :
      ('response -> mutationError array Js.Nullable.t -> unit) option
        [@mel.optional]
  ; onError : (mutationError -> unit) option [@mel.optional]
  ; optimisticResponse : 'rawResponse option [@mel.optional]
  ; optimisticUpdater : optimisticUpdaterFn option [@mel.optional]
  ; updater : 'response updaterFn option [@mel.optional]
  ; uploadables : uploadables option [@mel.optional]
  }
[@@deriving jsProperties, getSet]

external commitMutation_ :
   Environment.t
  -> ('m, 'variables, 'response, 'rawResponse) commitMutationConfigRaw
  -> Disposable.t
  = "commitMutation"
[@@mel.module "relay-runtime"]

let commitMutation
    ~(convertVariables : 'variables -> 'variables)
    ~(node : 'm)
    ~(convertResponse : 'response -> 'response)
    ~(convertWrapRawResponse : 'rawResponse -> 'rawResponse)
    ~(environment : Environment.t)
    ~(variables : 'variables)
    ?optimisticUpdater
    ?(optimisticResponse : 'rawResponse option)
    ?updater
    ?onCompleted
    ?onError
    ?uploadables
    ()
  =
  (* Commits the current mutation. Use this outside of React's render. If you're
     inside render, you should use `Mutation.use` instead, which is more
     convenient. ### Optimistic updates Remember to annotate your mutation with
     `@raw_response_type` if you want to do optimistic updates. That'll make
     Relay emit the required type information for covering everything needed
     when doing optimistic updates.*)
  commitMutation_
    environment
    (commitMutationConfigRaw
       ~mutation:node
       ?onCompleted:
         (match onCompleted with
         | Some cb ->
           Some
             (fun res err ->
               cb (res |. convertResponse) (err |. Js.Nullable.toOption))
         | None -> None)
       ?onError
       ?optimisticResponse:
         (match optimisticResponse with
         | Some optimisticResponse ->
           Some (optimisticResponse |. convertWrapRawResponse)
         | None -> None)
       ?optimisticUpdater
       ?updater:
         (match updater with
         | Some updater ->
           Some
             (fun store response -> updater store (response |. convertResponse))
         | None -> None)
       ?uploadables
       ~variables:(variables |. convertVariables)
       ())

type nonrec ('m, 'variables, 'response, 'rawResponse) useMutationConfigRaw =
  { onError : (mutationError -> unit) option [@mel.optional]
  ; onCompleted :
      ('response -> mutationError array Js.Nullable.t -> unit) option
        [@mel.optional]
  ; onUnsubscribe : (unit -> unit) option [@mel.optional]
  ; optimisticResponse : 'rawResponse option [@mel.optional]
  ; optimisticUpdater : optimisticUpdaterFn option [@mel.optional]
  ; updater : 'response updaterFn option [@mel.optional]
  ; variables : 'variables
  ; uploadables : uploadables option [@mel.optional]
  }
[@@deriving jsProperties, getSet]

external useMutation_ :
   'm
  -> (('m, 'variables, 'response, 'rawResponse) useMutationConfigRaw
      -> Disposable.t)
     * bool
  = "useMutation"
[@@mel.module "react-relay"]

(* React hook for commiting this mutation.

   ### Optimistic updates Remember to annotate your mutation with
   `@raw_response_type` if you want to do optimistic updates. That'll make Relay
   emit the required type information for covering everything needed when doing
   optimistic updates.*)
let useMutation
    ~(convertVariables : 'variables -> 'variables)
    ~(node : 'm)
    ~(convertResponse : 'response -> 'response)
    ~(convertWrapRawResponse : 'rawResponse -> 'rawResponse)
    ()
  =
  let mutate, mutating = useMutation_ node in
  ( React.useMemo1
      (fun ()
           ~(variables : 'variables)
           ?optimisticUpdater
           ?(optimisticResponse : 'rawResponse option)
           ?updater
           ?onCompleted
           ?onError
           ?uploadables
           () ->
        mutate
          (useMutationConfigRaw
             ?onCompleted:
               (match onCompleted with
               | Some cb ->
                 Some
                   (fun res err ->
                     cb (res |. convertResponse) (err |. Js.Nullable.toOption))
               | None -> None)
             ?onError
             ?optimisticResponse:
               (match optimisticResponse with
               | Some optimisticResponse ->
                 Some (optimisticResponse |. convertWrapRawResponse)
               | None -> None)
             ?optimisticUpdater
             ?updater:
               (match updater with
               | Some updater ->
                 Some
                   (fun store response ->
                     updater store (response |. convertResponse))
               | None -> None)
             ?uploadables
             ~variables:(variables |. convertVariables)
             ()))
      [| mutate |]
  , mutating )
