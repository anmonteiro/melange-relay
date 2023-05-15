type nonrec arguments
type nonrec allFieldsMasked = < > Js.t
type nonrec any
type nonrec 'node queryNode
type nonrec 'node fragmentNode
type nonrec 'node mutationNode
type nonrec 'node subscriptionNode
type nonrec 'fragments fragmentRefs
type nonrec dataId
type nonrec recordSourceRecords = Js.Json.t
type nonrec uploadables

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

let (optArrayOfNullableToOptArrayOfOpt :
      'a Js.Nullable.t array option -> 'a option array option)
  =
 fun x ->
  match x with
  | None -> None
  | Some arr -> Some (arr |. Belt.Array.map Js.Nullable.toOption)

external storeRootId : dataId = "ROOT_ID" [@@module "relay-runtime"]
external storeRootType : string = "ROOT_TYPE" [@@module "relay-runtime"]

module RecordProxy = struct
  type nonrec t

  external copyFieldsFrom : t -> sourceRecord:t -> unit = "copyFieldsFrom"
    [@@send]

  external getDataId : t -> dataId = "getDataID" [@@send]

  external getLinkedRecord :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t option
    = "getLinkedRecord"
    [@@send] [@@return nullable]

  external getLinkedRecords :
     t
    -> string
    -> arguments option
    -> t Js.Nullable.t array option
    = "getLinkedRecords"
    [@@send] [@@return nullable]

  let getLinkedRecords t ~name ?arguments () : t option array option =
    getLinkedRecords t name arguments |. optArrayOfNullableToOptArrayOfOpt

  external getOrCreateLinkedRecord :
     t
    -> name:string
    -> typeName:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "getOrCreateLinkedRecord"
    [@@send]

  external getType : t -> string = "getType" [@@send]

  external getValueString :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> string option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueStringArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> string option array option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueInt :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> int option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueIntArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> int option array option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueFloat :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> float option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueFloatArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> float option array option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueBool :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> bool option
    = "getValue"
    [@@send] [@@return nullable]

  external getValueBoolArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> bool option array option
    = "getValue"
    [@@send] [@@return nullable]

  external setLinkedRecord :
     t
    -> record:t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setLinkedRecord"
    [@@send]

  external setLinkedRecordToUndefined :
     t
    -> (_[@as {json|undefined|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setLinkedRecordToNull :
     t
    -> (_[@as {json|null|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setLinkedRecords :
     t
    -> records:t option array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setLinkedRecords"
    [@@send]

  external setLinkedRecordsToUndefined :
     t
    -> (_[@as {json|undefined|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setLinkedRecordsToNull :
     t
    -> (_[@as {json|null|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueToUndefined :
     t
    -> (_[@as {json|undefined|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueToNull :
     t
    -> (_[@as {json|null|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueString :
     t
    -> value:string
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueStringArray :
     t
    -> value:string array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueInt :
     t
    -> value:int
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueIntArray :
     t
    -> value:int array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueFloat :
     t
    -> value:float
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueFloatArray :
     t
    -> value:float array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueBool :
     t
    -> value:bool
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external setValueBoolArray :
     t
    -> value:bool array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
    [@@send]

  external invalidateRecord : t -> unit = "invalidateRecord" [@@send]
end

module RecordSourceSelectorProxy = struct
  type nonrec t

  external create :
     t
    -> dataId:dataId
    -> typeName:string
    -> RecordProxy.t
    = "create"
    [@@send]

  external delete : t -> dataId:dataId -> unit = "delete" [@@send]

  external get : t -> dataId:dataId -> RecordProxy.t option = "get"
    [@@send] [@@return nullable]

  external getRoot : t -> RecordProxy.t = "getRoot" [@@send]

  external getRootField :
     t
    -> fieldName:string
    -> RecordProxy.t option
    = "getRootField"
    [@@send] [@@return nullable]

  external getPluralRootField :
     t
    -> fieldName:string
    -> RecordProxy.t Js.Nullable.t array option
    = "getPluralRootField"
    [@@send] [@@return nullable]

  let getPluralRootField t ~fieldName : RecordProxy.t option array option =
    getPluralRootField t ~fieldName |. optArrayOfNullableToOptArrayOfOpt

  external invalidateStore : t -> unit = "invalidateStore" [@@send]
end

module ReadOnlyRecordSourceProxy = struct
  type nonrec t

  external get : t -> dataId:dataId -> RecordProxy.t option = "get"
    [@@send] [@@return nullable]

  external getRoot : t -> RecordProxy.t = "getRoot" [@@send]
end

module MissingFieldHandler = struct
  [@@@warning "-30"]

  type nonrec t

  type nonrec normalizationArgumentWrapped =
    { kind : [ `ListValue | `Literal | `ObjectValue | `Variable ] }

  type normalizationListValueArgument =
    { name : string
    ; items : normalizationArgumentWrapped Js.Nullable.t array
    }

  and normalizationLiteralArgument =
    { name : string
    ; type_ : string Js.Nullable.t [@as "type"]
    ; value : Js.Json.t
    }

  and normalizationObjectValueArgument =
    { name : string
    ; fields : normalizationArgumentWrapped array Js.Nullable.t
    }

  and normalizationVariableArgument =
    { name : string
    ; type_ : string Js.Nullable.t [@as "type"]
    ; variableName : string
    }

  type nonrec normalizationArgument =
    | ListValue of normalizationListValueArgument
    | Literal of normalizationLiteralArgument
    | ObjectValue of normalizationObjectValueArgument
    | Variable of normalizationVariableArgument

  let unwrapNormalizationArgument wrapped =
    match wrapped.kind with
    | `ListValue -> ListValue (Obj.magic wrapped)
    | `Literal -> Literal (Obj.magic wrapped)
    | `ObjectValue -> ObjectValue (Obj.magic wrapped)
    | `Variable -> Variable (Obj.magic wrapped)

  type nonrec normalizationScalarField =
    { alias : string Js.Nullable.t
    ; name : string
    ; args : normalizationArgumentWrapped array Js.Nullable.t
    ; storageKey : string Js.Nullable.t
    }

  let makeScalarMissingFieldHandler handle =
    Obj.magic [%obj { kind = `scalar; handle }]

  type nonrec normalizationLinkedField =
    { alias : string Js.Nullable.t
    ; name : string
    ; storageKey : string Js.Nullable.t
    ; args : normalizationArgument array Js.Nullable.t
    ; concreteType : string Js.Nullable.t
    ; plural : bool
    ; selections : Js.Json.t array
    }

  let makeLinkedMissingFieldHandler handle =
    Obj.magic [%obj { kind = `linked; handle }]

  let makePluralLinkedMissingFieldHandler handle =
    Obj.magic [%obj { kind = `pluralLinked; handle }]
end

let nodeInterfaceMissingFieldHandler =
  MissingFieldHandler.makeLinkedMissingFieldHandler
    (fun field record args _store ->
      match
        Js.Nullable.toOption record, field##name, Js.Nullable.toOption args##id
      with
      | Some record, "node", argsId
        when record |. RecordProxy.getType = storeRootType ->
        argsId
      | _ -> None)

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

type nonrec operationDescriptor

module Disposable = struct
  type nonrec t

  external dispose : t -> unit = "dispose" [@@send]
  external ignore : t -> unit = "%ignore"
end

type nonrec cacheConfig =
  { force : bool option
  ; poll : int option
  ; liveConfigId : string option
  ; transactionId : string option
  }

module Observable = struct
  type nonrec 'response t

  type nonrec subscription =
    { unsubscribe : unit -> unit
    ; closed : bool
    }

  type nonrec 'response sink =
    { next : ('response -> unit[@bs])
    ; error : (Js.Exn.t -> unit[@bs])
    ; complete : (unit -> unit[@bs])
    ; closed : bool
    }

  type nonrec 'response observer

  external makeObserver :
     ?start:((subscription[@uncurry]) -> unit)
    -> ?next:(('response[@uncurry]) -> unit)
    -> ?error:((Js.Exn.t[@uncurry]) -> unit)
    -> ?complete:((unit[@uncurry]) -> unit)
    -> ?unsubscribe:(((subscription[@uncurry]) -> unit)[@ns.namedArgLoc])
    -> unit
    -> 'response observer
    = ""
    [@@obj]

  external make :
     ('response sink -> subscription option)
    -> 'response t
    = "create"
    [@@module "relay-runtime"] [@@scope "Observable"]

  external subscribe :
     'response t
    -> 'response observer
    -> subscription
    = "subscribe"
    [@@send]

  external toPromise : 't t -> 't Js.Promise.t = "toPromise" [@@send]
end

module Network = struct
  type nonrec t

  type nonrec operation =
    { id : string
    ; text : string
    ; name : string
    ; operationKind : string
    }

  type nonrec subscribeFn =
    operation -> Js.Json.t -> cacheConfig -> Js.Json.t Observable.t

  type nonrec fetchFunctionPromise =
    operation
    -> Js.Json.t
    -> cacheConfig
    -> uploadables Js.Nullable.t
    -> Js.Json.t Js.Promise.t

  type nonrec fetchFunctionObservable =
    operation
    -> Js.Json.t
    -> cacheConfig
    -> uploadables Js.Nullable.t
    -> Js.Json.t Observable.t

  external makePromiseBased :
     fetchFunction:fetchFunctionPromise
    -> ?subscriptionFunction:subscribeFn
    -> unit
    -> t
    = "create"
    [@@module "relay-runtime"] [@@scope "Network"]

  external makeObservableBased :
     observableFunction:fetchFunctionObservable
    -> ?subscriptionFunction:subscribeFn
    -> unit
    -> t
    = "create"
    [@@module "relay-runtime"] [@@scope "Network"]
end

module RecordSource = struct
  type nonrec t

  external make : ?records:recordSourceRecords -> unit -> t = "RecordSource"
    [@@module "relay-runtime"] [@@new]

  external toJSON : t -> recordSourceRecords = "toJSON" [@@send]
end

module Store = struct
  type nonrec t

  type nonrec storeConfig =
    { gcReleaseBufferSize : int option
    ; queryCacheExpirationTime : int option
    }

  external make : RecordSource.t -> storeConfig -> t = "Store"
    [@@module "relay-runtime"] [@@new]

  let make ~source ?gcReleaseBufferSize ?queryCacheExpirationTime () =
    make source { gcReleaseBufferSize; queryCacheExpirationTime }

  external getSource : t -> RecordSource.t = "getSource" [@@send]
  external publish : t -> RecordSource.t -> unit = "publish" [@@send]
  external holdGC : t -> unit = "holdGC" [@@send]
end

module RequiredFieldLogger = struct
  type kind =
    [ `missing_field_log [@bs.as "missing_field.log"]
    | `missing_field_throw [@bs.as "missing_field.throw"]
    ]
  [@@bs.deriving { jsConverter = newType }]

  type nonrec arg =
    { kind : abs_kind
    ; owner : string
    ; fieldPath : string
    }

  type nonrec js = arg -> unit
  type nonrec t = kind:kind -> owner:string -> fieldPath:string -> unit

  let toJs : t -> js =
   fun f arg ->
    f ~kind:(kindFromJs arg.kind) ~owner:arg.owner ~fieldPath:arg.fieldPath
end

module Environment = struct
  type nonrec t

  type nonrec 'a environmentConfig =
    { network : Network.t
    ; store : Store.t
    ; getDataID : nodeObj:'a -> typeName:string -> string [@optional]
    ; treatMissingFieldsAsNull : bool [@optional]
    ; missingFieldHandlers : MissingFieldHandler.t array
    ; requiredFieldLogger : RequiredFieldLogger.js [@optional]
    ; isServer : bool [@optional]
    }
  [@@deriving abstract]

  external make : 'a environmentConfig -> t = "Environment"
    [@@module "relay-runtime"] [@@new]

  let make
      ~network
      ~store
      ?getDataID
      ?treatMissingFieldsAsNull
      ?missingFieldHandlers
      ?requiredFieldLogger
      ?isServer
      ()
    =
    make
      (environmentConfig
         ~network
         ~store
         ?getDataID
         ?treatMissingFieldsAsNull
         ~missingFieldHandlers:
           (match missingFieldHandlers with
           | Some handlers ->
             handlers
             |. Belt.Array.concat [| nodeInterfaceMissingFieldHandler |]
           | None -> [| nodeInterfaceMissingFieldHandler |])
         ?requiredFieldLogger:
           (requiredFieldLogger |. Belt.Option.map RequiredFieldLogger.toJs)
         ?isServer
         ())

  external getStore : t -> Store.t = "getStore" [@@send]

  external commitPayload :
     t
    -> operationDescriptor
    -> 'payload
    -> unit
    = "commitPayload"
    [@@send]

  external retain : t -> operationDescriptor -> Disposable.t = "retain" [@@send]
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

type nonrec fetchPolicy =
  | StoreOnly
  | StoreOrNetwork
  | StoreAndNetwork
  | NetworkOnly

let mapFetchPolicy x =
  match x with
  | Some StoreOnly -> Some "store-only"
  | Some StoreOrNetwork -> Some "store-or-network"
  | Some StoreAndNetwork -> Some "store-and-network"
  | Some NetworkOnly -> Some "network-only"
  | None -> None

type nonrec fetchQueryFetchPolicy =
  | NetworkOnly
  | StoreOrNetwork

let mapFetchQueryFetchPolicy x =
  match x with
  | Some StoreOrNetwork -> Some "store-or-network"
  | Some NetworkOnly -> Some "network-only"
  | None -> None

type nonrec fetchQueryOptions =
  { networkCacheConfig : cacheConfig option
  ; fetchPolicy : string option
  }

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
        -> ?fetchPolicy:fetchPolicy
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
      ; fetchPolicy = fetchPolicy |. mapFetchPolicy
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
        | None -> resolve (Error ()) [@bs]
        | Some o ->
          let open Observable in
          let (_ : subscription) =
            o
            |. subscribe
                 (makeObserver ~complete:(fun () -> (resolve (Ok ()) [@bs])) ())
          in
          ())
end

type nonrec mutationError = { message : string }

exception Mutation_failed of mutationError array

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
