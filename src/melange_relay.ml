include Types
module RecordProxy = RecordProxy
module RecordSourceSelectorProxy = RecordSourceSelectorProxy
module MissingFieldHandler = MissingFieldHandler
module Observable = Observable
module Network = Network
module RecordSource = RecordSource
module Store = Store
module Disposable = Disposable
module RequiredFieldLogger = RequiredFieldLogger
module Environment = Environment
module FetchPolicy = FetchPolicy
module Mutation = Mutation
module Query = Query
module Fragment = Fragment
module RelayResolvers = RelayResolvers
module Subscriptions = Subscriptions

external dataIdToString : dataId -> string = "%identity"
external makeDataId : string -> dataId = "%identity"
external makeArguments : < .. > Js.t -> arguments = "%identity"
external makeUploadables : 'file Js.Dict.t -> uploadables = "%identity"
external unwrapUploadables : uploadables -> 'file Js.Dict.t = "%identity"

external generateClientID :
   dataId:dataId
  -> storageKey:string
  -> ?index:int
  -> unit
  -> dataId
  = "generateClientID"
[@@module "relay-runtime"]

external generateUniqueClientID : unit -> dataId = "generateUniqueClientID"
[@@module "relay-runtime"]

external isClientID : dataId -> bool = "isClientID" [@@module "relay-runtime"]

type nonrec featureFlags =
  { mutable delayCleanupOfPendingPreloadQueries : bool
        [@as "DELAY_CLEANUP_OF_PENDING_PRELOAD_QUERIES"]
  ; mutable enableClientEdges : bool [@as "ENABLE_CLIENT_EDGES"]
  ; mutable enableVariableConnectionKey : bool
        [@as "ENABLE_VARIABLE_CONNECTION_KEY"]
  ; mutable enablePartialRenderingDefault : bool
        [@as "ENABLE_PARTIAL_RENDERING_DEFAULT"]
  ; mutable enableReactFlightComponentField : bool
        [@as "ENABLE_REACT_FLIGHT_COMPONENT_FIELD"]
  ; mutable enableRelayResolvers : bool [@as "ENABLE_RELAY_RESOLVERS"]
  ; mutable enableGetFragmentIdentifierOptimization : bool
        [@as "ENABLE_GETFRAGMENTIDENTIFIER_OPTIMIZATION"]
  ; mutable enableFriendlyQueryNameGqlUrl : bool
        [@as "ENABLE_FRIENDLY_QUERY_NAME_GQL_URL"]
  ; mutable enableLoadQueryRequestDeduping : bool
        [@as "ENABLE_LOAD_QUERY_REQUEST_DEDUPING"]
  ; mutable enableDoNotWrapLiveQuery : bool
        [@as "ENABLE_DO_NOT_WRAP_LIVE_QUERY"]
  ; mutable enableNotifySubscription : bool [@as "ENABLE_NOTIFY_SUBSCRIPTION"]
  ; mutable enableContainersSubscribeOnCommit : bool
        [@as "ENABLE_CONTAINERS_SUBSCRIBE_ON_COMMIT"]
  ; mutable enableQueryRendererOffscreenSupport : bool
        [@as "ENABLE_QUERY_RENDERER_OFFSCREEN_SUPPORT"]
  ; mutable maxDataIdLength : int option [@as "MAX_DATA_ID_LENGTH"]
  ; mutable refactorSuspenseResource : bool [@as "REFACTOR_SUSPENSE_RESOURCE"]
  ; mutable stringInternLevel : int [@as "STRING_INTERN_LEVEL"]
  ; mutable useReactCache : bool [@as "USE_REACT_CACHE"]
  }

external relayFeatureFlags : featureFlags = "RelayFeatureFlags"
[@@module "relay-runtime"]

external convertObj :
   'a
  -> string Js.Dict.t Js.Dict.t Js.Dict.t
  -> 'b
  -> 'c
  -> 'd
  = "traverser"
[@@module "./utils"]

module ReadOnlyRecordSourceProxy = struct
  type nonrec t

  external get : t -> dataId:dataId -> RecordProxy.t option = "get"
  [@@send] [@@return nullable]

  external getRoot : t -> RecordProxy.t = "getRoot" [@@send]
end

module ConnectionHandler = struct
  external getConnection :
     record:RecordProxy.t
    -> key:string
    -> ?filters:arguments
    -> unit
    -> RecordProxy.t option
    = "getConnection"
  [@@module "relay-runtime"] [@@scope "ConnectionHandler"] [@@return nullable]

  external createEdge :
     store:RecordSourceSelectorProxy.t
    -> connection:RecordProxy.t
    -> node:RecordProxy.t
    -> edgeType:string
    -> RecordProxy.t
    = "createEdge"
  [@@module "relay-runtime"] [@@scope "ConnectionHandler"]

  external insertEdgeBefore :
     connection:RecordProxy.t
    -> newEdge:RecordProxy.t
    -> ?cursor:string
    -> unit
    -> unit
    = "insertEdgeBefore"
  [@@module "relay-runtime"] [@@scope "ConnectionHandler"]

  external insertEdgeAfter :
     connection:RecordProxy.t
    -> newEdge:RecordProxy.t
    -> ?cursor:string
    -> unit
    -> unit
    = "insertEdgeAfter"
  [@@module "relay-runtime"] [@@scope "ConnectionHandler"]

  external deleteNode :
     connection:RecordProxy.t
    -> nodeId:dataId
    -> unit
    = "deleteNode"
  [@@module "relay-runtime"] [@@scope "ConnectionHandler"]

  external getConnectionID :
     dataId
    -> string
    -> 'filters
    -> dataId
    = "getConnectionID"
  [@@module "relay-runtime"] [@@scope "ConnectionHandler"]
end

module Context = struct
  type nonrec t
  type nonrec contextShape = < environment : Environment.t > Js.t

  external context : contextShape option React.Context.t = "ReactRelayContext"
  [@@module "react-relay"]

  module Provider = struct
    let make ~(environment : Environment.t) ~children =
      let provider = React.Context.provider context in
      React.createElement
        provider
        [%obj { value = Some [%obj { environment }]; children }]
    [@@react.component]
  end
end

exception EnvironmentNotFoundInContext

let useEnvironmentFromContext () =
  let context = React.useContext Context.context in
  match context with
  | Some ctx -> ctx##environment
  | None -> raise EnvironmentNotFoundInContext

type nonrec loadQueryConfig =
  { fetchKey : string option
  ; fetchPolicy : string option
  ; networkCacheConfig : cacheConfig option
  }

external loadQuery :
   Environment.t
  -> 'a queryNode
  -> 'variables
  -> loadQueryConfig
  -> 'queryResponse
  = "loadQuery"
[@@module "react-relay"]

module type MakeLoadQueryConfig = sig
  type nonrec variables
  type nonrec loadedQueryRef
  type nonrec response
  type nonrec node

  val query : node queryNode
  val convertVariables : variables -> variables
end

module MakeLoadQuery (C : MakeLoadQueryConfig) = struct
  let (load :
        environment:Environment.t
        -> variables:C.variables
        -> ?fetchPolicy:FetchPolicy.t
        -> ?fetchKey:string
        -> ?networkCacheConfig:cacheConfig
        -> unit
        -> C.loadedQueryRef)
    =
   fun ~environment ~variables ?fetchPolicy ?fetchKey ?networkCacheConfig () ->
    loadQuery
      environment
      C.query
      (variables |. C.convertVariables)
      { fetchKey
      ; fetchPolicy = fetchPolicy |. FetchPolicy.map
      ; networkCacheConfig
      }

  type nonrec 'response rawPreloadToken =
    { source : 'response Observable.t Js.Nullable.t }

  external tokenToRaw :
     C.loadedQueryRef
    -> C.response rawPreloadToken
    = "%identity"

  let queryRefToObservable token =
    let raw = token |. tokenToRaw in
    raw.source |. Js.Nullable.toOption

  let queryRefToPromise token =
    Js.Promise.make (fun ~resolve ~reject:_ ->
        match token |. queryRefToObservable with
        | None -> resolve (Error ()) [@u]
        | Some o ->
          let open Observable in
          let (_ : subscription) =
            o
            |. subscribe
                 (makeObserver ~complete:(fun () -> (resolve (Ok ()) [@u])) ())
          in
          ())
end

external commitLocalUpdate :
   environment:Environment.t
  -> updater:(RecordSourceSelectorProxy.t -> unit)
  -> unit
  = "commitLocalUpdate"
[@@module "relay-runtime"]

external useSubscribeToInvalidationState :
   dataId array
  -> (unit -> unit)
  -> Disposable.t
  = "useSubscribeToInvalidationState"
[@@module "react-relay"]
