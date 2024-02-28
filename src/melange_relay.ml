include Types
module ConnectionHandler = ConnectionHandler
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
[@@mel.module "relay-runtime"]

external generateUniqueClientID : unit -> dataId = "generateUniqueClientID"
[@@mel.module "relay-runtime"]

external isClientID : dataId -> bool = "isClientID" [@@mel.module "relay-runtime"]

type nonrec featureFlags =
  { mutable delayCleanupOfPendingPreloadQueries : bool
        [@mel.as "DELAY_CLEANUP_OF_PENDING_PRELOAD_QUERIES"]
  ; mutable enableClientEdges : bool [@mel.as "ENABLE_CLIENT_EDGES"]
  ; mutable enableVariableConnectionKey : bool
        [@mel.as "ENABLE_VARIABLE_CONNECTION_KEY"]
  ; mutable enablePartialRenderingDefault : bool
        [@mel.as "ENABLE_PARTIAL_RENDERING_DEFAULT"]
  ; mutable enableReactFlightComponentField : bool
        [@mel.as "ENABLE_REACT_FLIGHT_COMPONENT_FIELD"]
  ; mutable enableRelayResolvers : bool [@mel.as "ENABLE_RELAY_RESOLVERS"]
  ; mutable enableGetFragmentIdentifierOptimization : bool
        [@mel.as "ENABLE_GETFRAGMENTIDENTIFIER_OPTIMIZATION"]
  ; mutable enableFriendlyQueryNameGqlUrl : bool
        [@mel.as "ENABLE_FRIENDLY_QUERY_NAME_GQL_URL"]
  ; mutable enableLoadQueryRequestDeduping : bool
        [@mel.as "ENABLE_LOAD_QUERY_REQUEST_DEDUPING"]
  ; mutable enableDoNotWrapLiveQuery : bool
        [@mel.as "ENABLE_DO_NOT_WRAP_LIVE_QUERY"]
  ; mutable enableNotifySubscription : bool [@mel.as "ENABLE_NOTIFY_SUBSCRIPTION"]
  ; mutable enableContainersSubscribeOnCommit : bool
        [@mel.as "ENABLE_CONTAINERS_SUBSCRIBE_ON_COMMIT"]
  ; mutable enableQueryRendererOffscreenSupport : bool
        [@mel.as "ENABLE_QUERY_RENDERER_OFFSCREEN_SUPPORT"]
  ; mutable maxDataIdLength : int option [@mel.as "MAX_DATA_ID_LENGTH"]
  ; mutable refactorSuspenseResource : bool [@mel.as "REFACTOR_SUSPENSE_RESOURCE"]
  ; mutable stringInternLevel : int [@mel.as "STRING_INTERN_LEVEL"]
  ; mutable useReactCache : bool [@mel.as "USE_REACT_CACHE"]
  }

external relayFeatureFlags : featureFlags = "RelayFeatureFlags"
[@@mel.module "relay-runtime"]

external convertObj :
   'a
  -> string Js.Dict.t Js.Dict.t Js.Dict.t
  -> 'b
  -> 'c
  -> 'd
  = "traverser"
[@@mel.module "./utils"]

module ReadOnlyRecordSourceProxy = struct
  type nonrec t

  external get : t -> dataId:dataId -> RecordProxy.t option = "get"
  [@@mel.send] [@@mel.return nullable]

  external getRoot : t -> RecordProxy.t = "getRoot" [@@mel.send]
end

module Context = struct
  type nonrec t
  type nonrec contextShape = < environment : Environment.t > Js.t

  external context : contextShape option React.Context.t = "ReactRelayContext"
  [@@mel.module "react-relay"]

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
[@@mel.module "react-relay"]

external commitLocalUpdate :
   environment:Environment.t
  -> updater:(RecordSourceSelectorProxy.t -> unit)
  -> unit
  = "commitLocalUpdate"
[@@mel.module "relay-runtime"]

external useSubscribeToInvalidationState :
   dataId array
  -> (unit -> unit)
  -> Disposable.t
  = "useSubscribeToInvalidationState"
[@@mel.module "react-relay"]

module Internal = Internal
