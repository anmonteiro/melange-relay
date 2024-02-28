type nonrec arguments
(** Abstract type for arguments, used when selecting fields on `RecordProxy` and
    friends when interacting with the store imperatively.*)

type nonrec uploadables
(** Abstract type for uploadables.

    Constructing an `uploadables`: Use [makeUploadable]:
    [makeUploadable [%mel.obj { someFile = theFileYouWantToUpload }]] to
    construct an `uploadables`, and then pass it to your mutation via the
    `uploadables` prop.

    Please note that you'll need to handle _sending_ the uploadables to your
    server yourself in the network layer.
    [Here's an
   example](https://github.com/facebook/relay/issues/1844#issuecomment-316893590)
    in regular JS that you can adapt to ReScript as you need/want. *)

type nonrec allFieldsMasked = < > Js.t
(** If you see this, it means that all fields have been masked in this
    selection, which is why it contains no data. Relay uses
    [_data
   masking_](https://relay.dev/docs/en/thinking-in-relay.html#data-masking)
    to hide data you haven't explicitly asked for, even if it exists on the
    object.*)

type nonrec any
(** Abstract helper type to signify something that could not be generated in a
    type-safe way.*)

type nonrec 'node queryNode
(** A query node, used internally by Relay. These are runtime artifacts produced
    by the Relay compiler.*)

type nonrec 'node fragmentNode
(** A fragment node, used internally by Relay. These are runtime artifacts
    produced by the Relay compiler.*)

type nonrec 'node mutationNode
(** A mutation node, used internally by Relay. These are runtime artifacts
    produced by the Relay compiler.*)

type nonrec 'node subscriptionNode
(** A subscription node, used internally by Relay. These are runtime artifacts
    produced by the Relay compiler.*)

type nonrec 'fragments fragmentRefs
(** This type shows all of the fragments that has been spread on this particular
    object.*)

type nonrec dataId
(** The type of the id Relay uses to identify records in its store.*)

external dataIdToString : dataId -> string = "%identity"
(** Turns a `dataId` into a `string`.*)

external makeDataId : string -> dataId = "%identity"
(** Turns a `string` into a `dataId`.*)

external makeArguments : < .. > Js.t -> arguments = "%identity"
(** Construct an `arguments` object for use with certain Relay store APIs.

    Usage: Use it like this:
    [makeArguments [%mel.obj { someArgument = someValue, anotherArgument= anotherValue }]]. *)

external makeUploadables : 'file Js.Dict.t -> uploadables = "%identity"
(** Construct an `uploadables` object from a `Js.Dict` with your desired file
    format, that you can use for uploads via Relay.*)

external unwrapUploadables : uploadables -> 'file Js.Dict.t = "%identity"
(** Unwraps `uploadables` into a Js.Dict.t with your expected file type, so you
    can use that dict to attach the provided files to your request.*)

external generateClientID :
   dataId:dataId
  -> storageKey:string
  -> ?index:int
  -> unit
  -> dataId
  = "generateClientID"
[@@mel.module "relay-runtime"]
(** This generates a `dataId` for use on the _client_ side. However, this is
    farily low level, and what you're probably really looking for is
    `generateUniqueClientID` that'll let you generate a new, unique `dataId`
    that you can use for client side only records (like when doing optimistic
    updates).*)

external generateUniqueClientID : unit -> dataId = "generateUniqueClientID"
[@@mel.module "relay-runtime"]
(** This generates a unique `dataId` that's safe to use on the _client_ side.
    Useful when doing optimistic updates and you need to create IDs that the
    optimistic update can use.*)

external isClientID : dataId -> bool = "isClientID"
[@@mel.module "relay-runtime"]
(** Checks whether the provided `dataId` is guaranteed to be a client side only
    id.*)

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
  ; mutable refactorSuspenseResource : bool
        [@mel.as "REFACTOR_SUSPENSE_RESOURCE"]
  ; mutable stringInternLevel : int [@mel.as "STRING_INTERN_LEVEL"]
  ; mutable useReactCache : bool [@mel.as "USE_REACT_CACHE"]
  }
(** Relay feature flags. Mutate this record as soon as your application boots to
    enable/disable features.*)

external relayFeatureFlags : featureFlags = "RelayFeatureFlags"
[@@mel.module "relay-runtime"]
(** Relay feature flags. Mutate this record as soon as your application boots to
    enable/disable features.*)

type nonrec recordSourceRecords = Js.Json.t
(** Representing all records in the store serialized to JSON in a way that you
    can use to re-hydrate the store.

    See `RecordSource.toJSON` for how to produce it.*)

external convertObj :
   'a
  -> string Js.Dict.t Js.Dict.t Js.Dict.t
  -> 'b
  -> 'c
  -> 'd
  = "traverser"
[@@mel.module "./utils"]
(** Internal, do not use.*)

(** Read the following section on working with the Relay store:
    https://relay.dev/docs/en/relay-store*)
module RecordProxy : sig
  type nonrec t
  (** Read the following section on working with the Relay store:
      https://relay.dev/docs/en/relay-store*)

  external copyFieldsFrom : t -> sourceRecord:t -> unit = "copyFieldsFrom"
  [@@mel.send]
  (** Copies all fields from one `RecordProxy` to another.*)

  external getDataId : t -> dataId = "getDataID"
  [@@mel.send]
  (** Gets the \`dataId\` for a particular record.*)

  external getLinkedRecord :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t option
    = "getLinkedRecord"
  [@@mel.send] [@@mel.return nullable]
  (** Gets a single linked record. A linked record is another object in the
      store, and not a scalar field like an int or float.*)

  val getLinkedRecords :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t option array option
  (** Gets an array of linked records, for when a field is a list (meaning a
      link to multiple records).*)

  external getOrCreateLinkedRecord :
     t
    -> name:string
    -> typeName:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "getOrCreateLinkedRecord"
  [@@mel.send]
  (** This returns an existing linked record, or creates one at the configured
      place if one does not already exist.*)

  external getType : t -> string = "getType"
  [@@mel.send]
  (** Returns the `__typename` of this particular record.*)

  external getValueString :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> string option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be a string.*)

  external getValueStringArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> string option array option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be an array of strings.*)

  external getValueInt :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> int option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be an int.*)

  external getValueIntArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> int option array option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be an array of ints.*)

  external getValueFloat :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> float option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be a float.*)

  external getValueFloatArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> float option array option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be an array of floats.*)

  external getValueBool :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> bool option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be a boolean.*)

  external getValueBoolArray :
     t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> bool option array option
    = "getValue"
  [@@mel.send] [@@mel.return nullable]
  (** Returns a field value, expecting it to be an array of booleans.*)

  external setLinkedRecord :
     t
    -> record:t
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setLinkedRecord"
  [@@mel.send]
  (** Sets a `RecordProxy.t` as the linked record for a particular field.*)

  external setLinkedRecords :
     t
    -> records:t option array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setLinkedRecords"
  [@@mel.send]
  (** Sets an array of `RecordProxy.t` as the linked records for a particular
      field.*)

  external setValueString :
     t
    -> value:string
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets a string as field value.*)

  external setValueStringArray :
     t
    -> value:string array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets an array of strings as field value.*)

  external setValueInt :
     t
    -> value:int
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets an int as field value.*)

  external setValueIntArray :
     t
    -> value:int array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets an array of ints as field value.*)

  external setValueFloat :
     t
    -> value:float
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets a float as field value.*)

  external setValueFloatArray :
     t
    -> value:float array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets an array of floats as field value.*)

  external setValueBool :
     t
    -> value:bool
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets a boolean as field value.*)

  external setValueBoolArray :
     t
    -> value:bool array
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets an array of booleans as field value.*)

  external setValueToUndefined :
     t
    -> (_[@mel.as {json|undefined|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets the field value to `undefined` (meaning Relay will treat it as
      missing data).*)

  external setValueToNull :
     t
    -> (_[@mel.as {json|null|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets the field value to `null`.*)

  external setLinkedRecordToUndefined :
     t
    -> (_[@mel.as {json|undefined|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets this linked record to `undefined` (meaning Relay will treat it as
      missing data).*)

  external setLinkedRecordToNull :
     t
    -> (_[@mel.as {json|null|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets this linked record to `null`.*)

  external setLinkedRecordsToUndefined :
     t
    -> (_[@mel.as {json|undefined|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets the field holding these linked records to `undefined` (meaning Relay
      will treat it as missing data).*)

  external setLinkedRecordsToNull :
     t
    -> (_[@mel.as {json|null|json}])
    -> name:string
    -> ?arguments:arguments
    -> unit
    -> t
    = "setValue"
  [@@mel.send]
  (** Sets the field holding these linked records to `null`.*)

  external invalidateRecord : t -> unit = "invalidateRecord"
  [@@mel.send]
  (** Invalidates this record.

      Invalidating a record means that the _next_ time Relay evaluates this
      record, it'll be treated as missing.

      _Beware_ that this doesn't mean that queries using this record will
      refetch immediately. Rather, it'll happen the next time the query
      _renders_. Have a look at `useSubscribeToInvalidationState`, that'll allow
      you to subscribe to whenever records are invalidated, if you're looking
      for a way to refetch immediately as something invalidates.*)
end

(** RecordSourceSelectorProxy and RecordSourceProxy are the two modules
    representing the store, with various capabilities.*)
module RecordSourceSelectorProxy : sig
  type nonrec t
  (** Type type representing a `RecordSourceSelectorProxy`.*)

  external create :
     t
    -> dataId:dataId
    -> typeName:string
    -> RecordProxy.t
    = "create"
  [@@mel.send]
  (** Creates a new `RecordProxy`.*)

  external delete : t -> dataId:dataId -> unit = "delete"
  [@@mel.send]
  (** Deletes the `RecordProxy` with the provided `dataId`.*)

  external get : t -> dataId:dataId -> RecordProxy.t option = "get"
  [@@mel.send] [@@mel.return nullable]
  (** Returns the `RecordProxy` with the provided `dataId`, if it exists.*)

  external getRoot : t -> RecordProxy.t = "getRoot"
  [@@mel.send]
  (** Returns the _root_ `RecordProxy`, meaning the `RecordProxy` holding your
      top level fields.*)

  external getRootField :
     t
    -> fieldName:string
    -> RecordProxy.t option
    = "getRootField"
  [@@mel.send] [@@mel.return nullable]
  (** Returns the `RecordProxy` for the `fieldName` at root. You should prefer
      using `RecordSourceSelectorProxy.getRoot()` and traverse from there if you
      need access to root fields rather than use this.*)

  val getPluralRootField :
     t
    -> fieldName:string
    -> RecordProxy.t option array option
  (** Plural version of `RecordSourceSelectorProxy.getRootField`.*)

  external invalidateStore : t -> unit = "invalidateStore"
  [@@mel.send]
  (** Invalidates the entire store. This means that _at the next render_, the
      entire store will be treated as empty, meaning Relay will refetch
      everything it needs to show the view it's to show.*)
end

(** ReadOnlyRecordSourceProxy is the store, but in read-only mode.*)
module ReadOnlyRecordSourceProxy : sig
  type nonrec t
  (** Type type representing a `ReadOnlyRecordSourceProxy`.*)

  external get : t -> dataId:dataId -> RecordProxy.t option = "get"
  [@@mel.send] [@@mel.return nullable]
  (** Returns the `RecordProxy` with the provided `dataId`, if it exists.*)

  external getRoot : t -> RecordProxy.t = "getRoot"
  [@@mel.send]
  (** Returns the _root_ `RecordProxy`, meaning the `RecordProxy` holding your
      top level fields.*)
end

(** A missing field handler, which is a way of teaching Relay more about the
    relations in your schema, so it can fulfill more things from the cache. Read
    more
    [in this section of the Relay
   docs](https://relay.dev/docs/guided-tour/reusing-cached-data/filling-in-missing-data/).

    Feed a list of missing field handlers into `Environment.make` if you want to
    use them.*)
module MissingFieldHandler : sig
  [@@@warning "-30"]

  type nonrec t
  (** A missing field handler, which is a way of teaching Relay more about the
      relations in your schema, so it can fulfill more things from the cache.
      Read more
      [in this section of the Relay
   docs](https://relay.dev/docs/guided-tour/reusing-cached-data/filling-in-missing-data/).*)

  type nonrec normalizationArgumentWrapped =
    { kind : [ `ListValue | `Literal | `ObjectValue | `Variable ] }

  type normalizationListValueArgument =
    { name : string
    ; items : normalizationArgumentWrapped Js.Nullable.t array
    }

  and normalizationLiteralArgument =
    { name : string
    ; type_ : string Js.Nullable.t [@mel.as "type"]
    ; value : Js.Json.t
    }

  and normalizationObjectValueArgument =
    { name : string
    ; fields : normalizationArgumentWrapped array Js.Nullable.t
    }

  and normalizationVariableArgument =
    { name : string
    ; type_ : string Js.Nullable.t [@mel.as "type"]
    ; variableName : string
    }

  type nonrec normalizationArgument =
    | ListValue of normalizationListValueArgument
    | Literal of normalizationLiteralArgument
    | ObjectValue of normalizationObjectValueArgument
    | Variable of normalizationVariableArgument

  val unwrapNormalizationArgument :
     normalizationArgumentWrapped
    -> normalizationArgument

  type nonrec normalizationScalarField =
    { alias : string Js.Nullable.t
    ; name : string
    ; args : normalizationArgumentWrapped array Js.Nullable.t
    ; storageKey : string Js.Nullable.t
    }

  val makeScalarMissingFieldHandler :
     (normalizationScalarField
      -> 'record Js.Nullable.t
      -> 'args
      -> ReadOnlyRecordSourceProxy.t
      -> 'scalarValue)
    -> t
  (** Make a `MissingFieldHandler.t` for scalar fields. Give this a handler
      function that returns `Js.null` (to indicate that data exists but is
      null), `Js.undefined` (to indicate data is still missing), or a scalar
      value (to indicate that the value exists even though it's not in the
      cache, and is the value you send back).*)

  type nonrec normalizationLinkedField =
    { alias : string Js.Nullable.t
    ; name : string
    ; storageKey : string Js.Nullable.t
    ; args : normalizationArgument array Js.Nullable.t
    ; concreteType : string Js.Nullable.t
    ; plural : bool
    ; selections : Js.Json.t array
    }

  val makeLinkedMissingFieldHandler :
     (normalizationLinkedField
      -> RecordProxy.t Js.Nullable.t
      -> 'args
      -> ReadOnlyRecordSourceProxy.t
      -> dataId Js.Nullable.t)
    -> t
  (** Make a `MissingFieldHandler.t` for linked fields (other objects/records).
      Give this a handler function that returns `Js.null` (to indicate that the
      link exists but the linked record is null), `Js.undefined` (to indicate
      data is still missing), or a `dataId` of the record that is linked at this
      field.*)

  val makePluralLinkedMissingFieldHandler :
     (normalizationLinkedField
      -> RecordProxy.t Js.Nullable.t
      -> 'args
      -> ReadOnlyRecordSourceProxy.t
      -> dataId Js.Nullable.t array Js.Nullable.t)
    -> t
  (** Make a `MissingFieldHandler.t` for lists of linked fields (other
      objects/records). Give this a handler function that returns `Js.null` (to
      indicate that the link exists but the linked record is null),
      `Js.undefined` (to indicate data is still missing), or an array of
      `Js.Nullable.t<dataId>` where the `dataId`'s are the linked
      records/objects.*)
end

(** Read the Relay docs section on
    [ConnectionHandler](https://relay.dev/docs/en/relay-store#connectionhandler)*)
module ConnectionHandler : sig
  external getConnection :
     record:RecordProxy.t
    -> key:string
    -> ?filters:arguments
    -> unit
    -> RecordProxy.t option
    = "getConnection"
  [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"] [@@mel.return nullable]
  (** For a `RecordProxy`, returns the `RecordProxy` that is at the connection
      config provided.*)

  external createEdge :
     store:RecordSourceSelectorProxy.t
    -> connection:RecordProxy.t
    -> node:RecordProxy.t
    -> edgeType:string
    -> RecordProxy.t
    = "createEdge"
  [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]
  (** Creates an edge for a particular connection.*)

  external insertEdgeBefore :
     connection:RecordProxy.t
    -> newEdge:RecordProxy.t
    -> ?cursor:string
    -> unit
    -> unit
    = "insertEdgeBefore"
  [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]
  (** Inserts an edge into a connection _before_ the provided cursor. If no
      cursor is provided, it inserts the edge at the start of the connection
      list.*)

  external insertEdgeAfter :
     connection:RecordProxy.t
    -> newEdge:RecordProxy.t
    -> ?cursor:string
    -> unit
    -> unit
    = "insertEdgeAfter"
  [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]
  (** Inserts an edge into a connection _after_ the provided cursor. If no
      cursor is provided, it inserts the edge at the end of the connection list.*)

  external deleteNode :
     connection:RecordProxy.t
    -> nodeId:dataId
    -> unit
    = "deleteNode"
  [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]
  (** Deletes any edge from the connection where the node of the edge has the
      provided `dataId`. Please not that this _will not_ remove the actual node
      from the store. Use `RecordSourceSelectorProxy.delete` for that.*)

  external getConnectionID :
     dataId
    -> string
    -> 'filters
    -> dataId
    = "getConnectionID"
  [@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]
  (** Constructs a `dataId` targeting a specific connection at a specific
      parent. Note that the generated module for every fragment with a
      `@connection` will have a `<moduleName>.Utils.connectionKey` representing
      the connection key of that particular `@connection`, that you should use
      with this.*)
end

type nonrec cacheConfig =
  { force : bool option
  ; poll : int option
  ; liveConfigId : string option
  ; transactionId : string option
  }
(** The cache config provided to the network layer. Relay won't do anything in
    particular with these, it's up to you to use them if you want inside of your
    `NetworkLayer`.*)

(** A Relay observable, used throughout Relay for delivering data, in particular
    when dealing with multiple payloads like with subscriptions or multipart
    responses like `@stream` or `@defer`.*)
module Observable : sig
  type nonrec 'response t
  (** The type representing the observable.*)

  type nonrec 'response sink =
    { next : ('response -> unit[@u])
    ; error : (Js.Exn.t -> unit[@u])
    ; complete : (unit -> unit[@u])
    ; closed : bool
    }
  (** This sink can be used to give the observable new data.*)

  type nonrec subscription =
    { unsubscribe : unit -> unit
    ; closed : bool
    }
  (** A subscription for an observable, allowing you to unsubscribe if wanted.*)

  type nonrec 'response observer
  (** An observer of the observable.*)

  external makeObserver :
     ?start:((subscription[@mel.uncurry]) -> unit)
    -> ?next:(('response[@mel.uncurry]) -> unit)
    -> ?error:((Js.Exn.t[@mel.uncurry]) -> unit)
    -> ?complete:((unit[@mel.uncurry]) -> unit)
    -> ?unsubscribe:(subscription -> unit)
    -> unit
    -> 'response observer
    = ""
  [@@mel.obj]
  (** Create an observer.*)

  external make : ('t sink -> subscription option) -> 't t = "create"
  [@@mel.module "relay-runtime"] [@@mel.scope "Observable"]
  (** Create a new observable, getting fed an `Observable.sink` for interacting
      with the observable, and optionally returning a `Observable.subscription`
      if you have things you want to unsubscribe from as the observable closes.*)

  external subscribe : 't t -> 't observer -> subscription = "subscribe"
  [@@mel.send]
  (** Subscribe to the `Observable.t` using an observer.*)

  external toPromise : 't t -> 't Js.Promise.t = "toPromise"
  [@@mel.send]
  (** Turns an `Observable` into a promise. _Beware_ that reading the response
      in the resulting promise is currently _not safe_ due to some internals of
      how ReScript Relay works. This will be resolved in the future.*)

  external ignoreSubscription : subscription -> unit = "%ignore"
  (**Ignore this subscription.*)
end

(** Represents the network layer.*)
module Network : sig
  type nonrec t
  (** The type representing an instantiated `NetworkLayer`.*)

  type nonrec operation =
    { id : string
    ; text : string
    ; name : string
    ; operationKind : string
    }
  (** The operation fed to the `NetworkLayer` when Relay wants to make a
      request. Please note that if you're using persisted queries, `id` will
      exist but `text` won't, and vice versa when not using persisted queries.*)

  type nonrec subscribeFn =
    operation -> Js.Json.t -> cacheConfig -> Js.Json.t Observable.t
  (** The shape of the function Relay expects for creating a subscription.*)

  type nonrec fetchFunctionPromise =
    operation
    -> Js.Json.t
    -> cacheConfig
    -> uploadables Js.Nullable.t
    -> Js.Json.t Js.Promise.t
  (** The shape of the function responsible for fetching data if you want to
      return a promise rather than an `Observable`.*)

  type nonrec fetchFunctionObservable =
    operation
    -> Js.Json.t
    -> cacheConfig
    -> uploadables Js.Nullable.t
    -> Js.Json.t Observable.t
  (** The shape of the function responsible for fetching data if you want to
      return an `Observable`.*)

  external makePromiseBased :
     fetchFunction:fetchFunctionPromise
    -> ?subscriptionFunction:subscribeFn
    -> unit
    -> t
    = "create"
  [@@mel.module "relay-runtime"] [@@mel.scope "Network"]
  (** Create a new `NetworkLayer` using a fetch function that returns a promise.*)

  external makeObservableBased :
     observableFunction:fetchFunctionObservable
    -> ?subscriptionFunction:subscribeFn
    -> unit
    -> t
    = "create"
  [@@mel.module "relay-runtime"] [@@mel.scope "Network"]
  (** Create a new `NetworkLayer` using a fetch function that returns an
      `Observable`.*)
end

(** RecordSource is the source of records used by the store. Can be initiated
    with or without prior records; eg. hydrating the store with prior data.*)
module RecordSource : sig
  type nonrec t
  (** The type representing an instantiated `RecordSource`.*)

  external make : ?records:recordSourceRecords -> unit -> t = "RecordSource"
  [@@mel.module "relay-runtime"] [@@mel.new]
  (** Create a new `RecordSource`. Here's where you pass an existing
      `recordSourceRecords` if you have existing records you want to hydrate the
      store with, when doing SSR or similar.*)

  external toJSON : t -> recordSourceRecords = "toJSON"
  [@@mel.send]
  (** Serializes the `RecordSource` into `recordSourceRecords` that you can use
      to rehydrate another store. Typically used for SSR.*)
end

(** The actual store module, with configuration for the store.*)
module Store : sig
  type nonrec t
  (** The type representing an instantiated `Store`.*)

  val make :
     source:RecordSource.t
    -> ?gcReleaseBufferSize:int
    -> ?queryCacheExpirationTime:int
    -> unit
    -> t
  (** Creates a new `Store`.*)

  external getSource : t -> RecordSource.t = "getSource"
  [@@mel.send]
  (** Gets the `RecordSource` for this `Store`.*)

  external publish : t -> RecordSource.t -> unit = "publish"
  [@@mel.send]
  (** Publishes _new_ records to this store. This is useful in particular with
      frameworks like Next.js where routes could preload data needed and then
      serialize that (using `RecordSource.toJSON`) and send it over the wire,
      but you already have a store instantiated client side. This will then
      allow you to publish those records into your existing store.*)

  external holdGC : t -> unit = "holdGC"
  [@@mel.send]
  (** Informes the store to stop its normal garbage collection processes. This
      prevents data being lost between calling relay's `fetchQuery` any
      serialization process (eg: toJSON)*)

  external storeRootId : dataId = "ROOT_ID"
  [@@mel.module "relay-runtime"]
  (** The `dataId` for the Relay store's root. Useful when for example
      referencing the `parentID` of a connection that's on the store root.*)

  external storeRootType : string = "ROOT_TYPE"
  [@@mel.module "relay-runtime"]
  (** The `type` for the Relay store's root `RecordProxy`.*)
end

type nonrec operationDescriptor
(** Internal, do not use.*)

(** A disposable is something you can use to dispose of something when you don't
    use/need it anymore.*)
module Disposable : sig
  type nonrec t
  (** The type representing a `Disposable`.*)

  external dispose : t -> unit = "dispose"
  [@@mel.send]
  (** Dispose the `Disposable`.*)

  external ignore : t -> unit = "%ignore"
  (** Ignore this disposable.*)
end

(** A required field logger, which gets called when a field annotated with the
   @required directive was missing from the response*)
module RequiredFieldLogger : sig
  type kind =
    [ `missing_field_log
    | `missing_field_throw
    ]

  type nonrec t = kind:kind -> owner:string -> fieldPath:string -> unit
  (** A required field logger, which gets called when a field annotated with the
   @required directive was missing from the response*)
end

(** Module representing the environment, which you'll need to use and pass to
    various functions. Takes a few configuration options like store and network
    layer.*)
module Environment : sig
  type nonrec t
  (** The type representing an instantiated `Environment`.*)

  val make :
     network:Network.t
    -> store:Store.t
    -> ?getDataID:
         (nodeObj:(< __typename : string ; id : string ; .. > Js.t as 'a)
          -> typeName:string
          -> string)
    -> ?treatMissingFieldsAsNull:bool
    -> ?missingFieldHandlers:MissingFieldHandler.t array
    -> ?requiredFieldLogger:RequiredFieldLogger.t
    -> ?isServer:bool
    -> unit
    -> t
  (** Create a new `Environment`.*)

  external getStore : t -> Store.t = "getStore"
  [@@mel.send]
  (** Get the `Store` for this `Environment`.*)

  external commitPayload :
     t
    -> operationDescriptor
    -> 'payload
    -> unit
    = "commitPayload"
  [@@mel.send]
  (** Given an `operationDescriptor`, commits the corresponding payload.*)

  external retain : t -> operationDescriptor -> Disposable.t = "retain"
  [@@mel.send]
  (** Given an `operationDescriptor`, retains the corresponding operation so any
      data referenced by it isn't garbage collected. You should use the
      generated `Query.retain` function on your queries instead of using this
      directly.*)
end

module FetchPolicy : sig
  (** fetchPolicy controls how you want Relay to resolve your data.*)
  type nonrec t =
    | StoreOnly (* Resolve only from the store *)
    | StoreOrNetwork
      (* Resolve from the store if all data is there, otherwise make a network
         request *)
    | StoreAndNetwork
      (* Like StoreOrNetwork, but always make a request regardless of if the
         data was there initially or not *)
    | NetworkOnly (* Always make a request, regardless of what's in the store *)

  val map : t option -> string option
  (** Internal, do not use.*)

  (** The fetch policies allowed for fetching a query outside of React's render
      (as in `Query.fetch`).*)
  type nonrec fetchQueryFetchPolicy =
    | NetworkOnly
    | StoreOrNetwork

  val mapFetchQueryFetchPolicy : fetchQueryFetchPolicy option -> string option
  (** Internal, do not use.*)
end

type nonrec mutationError = { message : string }
(** An error from a mutation.*)

(** Context provider for the Relay environment.*)
module Context : sig
  type nonrec t
  (** Type representing the context.*)

  type nonrec contextShape = < environment : Environment.t > Js.t
  (** The expected shape of the context.*)

  external context : contextShape option React.Context.t = "ReactRelayContext"
  [@@mel.module "react-relay"]
  (** The actual React context coming from Relay.*)

  (** The context provider you wrap your app in and pass your `Environment` for
      Relay to work.*)
  module Provider : sig
    val make :
       environment:Environment.t
      -> children:React.element
      -> React.element
    [@@react.component]
    (** The React component you wrap your app in and pass your `Environment` for
        Relay to work.*)
  end
end

exception EnvironmentNotFoundInContext
(** An exception saying that the environment could not be found in the context.
    Means you forgot to wrap your app in `<RescriptRelay.Context.Provider
    environment=RelayEnv.environment>`*)

val useEnvironmentFromContext : unit -> Environment.t
(** Hook for getting the current environment from context.*)

exception Mutation_failed of mutationError array
(** An exception detailing that a mutation failed.*)

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
(** A way of committing a local update to the store.*)

external useSubscribeToInvalidationState :
   dataId array
  -> (unit -> unit)
  -> Disposable.t
  = "useSubscribeToInvalidationState"
[@@mel.module "react-relay"]
(** Allows you to subscribe to when a record, connection, or even the store
    itself is invalidated, and then react to that.*)

type nonrec fetchQueryOptions =
  { networkCacheConfig : cacheConfig option
  ; fetchPolicy : string option
  }
(** Options valid when fetching a query outside of React's render method (like
    when using `Query.fetch`).*)

module Mutation : sig
  type nonrec 'response updaterFn =
    RecordSourceSelectorProxy.t -> 'response -> unit

  type nonrec optimisticUpdaterFn = RecordSourceSelectorProxy.t -> unit

  val commitMutation :
     convertVariables:('variables -> 'variables)
    -> node:'a mutationNode
    -> convertResponse:('response -> 'response)
    -> convertWrapRawResponse:('rawResponse -> 'rawResponse)
    -> environment:Environment.t
    -> variables:'variables
    -> ?optimisticUpdater:optimisticUpdaterFn
    -> ?optimisticResponse:'rawResponse
    -> ?updater:'response updaterFn
    -> ?onCompleted:('response -> mutationError array option -> unit)
    -> ?onError:(mutationError -> unit)
    -> ?uploadables:uploadables
    -> unit
    -> Disposable.t

  val useMutation :
     convertVariables:('variables -> 'variables)
    -> node:'m
    -> convertResponse:('response -> 'response)
    -> convertWrapRawResponse:('rawResponse -> 'rawResponse)
    -> unit
    -> (variables:'variables
        -> ?optimisticUpdater:optimisticUpdaterFn
        -> ?optimisticResponse:'rawResponse
        -> ?updater:'response updaterFn
        -> ?onCompleted:('response -> mutationError array option -> unit)
        -> ?onError:(mutationError -> unit)
        -> ?uploadables:uploadables
        -> unit
        -> Disposable.t)
       * bool
end

module Query : sig
  val useQuery :
     convertVariables:('variables -> 'variables)
    -> node:'a queryNode
    -> convertResponse:('response -> 'response)
    -> variables:'variables
    -> ?fetchPolicy:FetchPolicy.t
    -> ?fetchKey:string
    -> ?networkCacheConfig:cacheConfig
    -> unit
    -> 'response

  val useLoader :
     convertVariables:('variables -> 'variables)
    -> node:'a queryNode
    -> mkQueryRef:('queryRef option -> 'queryRef option)
    -> unit
    -> 'queryRef option
       * (variables:'variables
          -> ?fetchPolicy:FetchPolicy.t
          -> ?networkCacheConfig:cacheConfig
          -> unit
          -> unit)
       * (unit -> unit)

  val usePreloaded :
     node:'a queryNode
    -> convertResponse:('response -> 'response)
    -> mkQueryRef:('queryRef -> 'queryRef)
    -> queryRef:'queryRef
    -> 'response

  val fetch :
     node:'a queryNode
    -> convertResponse:('response -> 'response)
    -> convertVariables:('variables -> 'variables)
    -> environment:Environment.t
    -> variables:'variables
    -> onResult:(('response, Js.Exn.t) result -> unit)
    -> ?networkCacheConfig:cacheConfig
    -> ?fetchPolicy:FetchPolicy.t
    -> unit
    -> unit

  val fetchPromised :
     node:'a queryNode
    -> convertResponse:('response -> 'response)
    -> convertVariables:('variables -> 'variables)
    -> environment:Environment.t
    -> variables:'variables
    -> ?networkCacheConfig:cacheConfig
    -> ?fetchPolicy:FetchPolicy.t
    -> unit
    -> 'response Js.Promise.t

  val retain :
     node:'a queryNode
    -> convertVariables:('variables -> 'variables)
    -> environment:Environment.t
    -> variables:'variables
    -> Disposable.t

  val commitLocalPayload :
     node:'a queryNode
    -> convertVariables:('variables -> 'variables)
    -> convertWrapRawResponse:('rawResponse -> 'rawResponse)
    -> environment:Environment.t
    -> variables:'variables
    -> payload:'rawResponse
    -> unit
end

module Fragment : sig
  val useFragment :
     node:'a fragmentNode
    -> convertFragment:('fragment -> 'fragment)
    -> fRef:'b
    -> 'fragment

  val useFragmentOpt :
     fRef:'a option
    -> node:'b fragmentNode
    -> convertFragment:('fragment -> 'fragment)
    -> 'fragment option

  val readInlineData :
     node:'a fragmentNode
    -> convertFragment:('fragment -> 'fragment)
    -> fRef:'b
    -> 'fragment

  type nonrec paginationLoadMoreFn =
    count:int -> ?onComplete:(Js.Exn.t option -> unit) -> unit -> Disposable.t

  type nonrec ('fragment, 'refetchVariables) paginationFragmentReturn =
    { data : 'fragment
    ; loadNext : paginationLoadMoreFn
    ; loadPrevious : paginationLoadMoreFn
    ; hasNext : bool
    ; hasPrevious : bool
    ; isLoadingNext : bool
    ; isLoadingPrevious : bool
    ; refetch :
        variables:'refetchVariables
        -> ?fetchPolicy:FetchPolicy.t
        -> ?onComplete:(Js.Exn.t option -> unit)
        -> unit
        -> Disposable.t
    }

  val usePaginationFragment :
     node:'a fragmentNode
    -> fRef:'b
    -> convertFragment:('fragment -> 'fragment)
    -> convertRefetchVariables:('refetchVariables -> 'refetchVariables)
    -> ('fragment, 'refetchVariables) paginationFragmentReturn

  type nonrec ('fragment, 'refetchVariables) paginationBlockingFragmentReturn =
    { data : 'fragment
    ; loadNext : paginationLoadMoreFn
    ; loadPrevious : paginationLoadMoreFn
    ; hasNext : bool
    ; hasPrevious : bool
    ; refetch :
        variables:'refetchVariables
        -> ?fetchPolicy:FetchPolicy.t
        -> ?onComplete:(Js.Exn.t option -> unit)
        -> unit
        -> Disposable.t
    }

  val useBlockingPaginationFragment :
     node:'a fragmentNode
    -> fRef:'b
    -> convertFragment:('fragment -> 'fragment)
    -> convertRefetchVariables:('refetchVariables -> 'refetchVariables)
    -> ('fragment, 'refetchVariables) paginationBlockingFragmentReturn

  val useRefetchableFragment :
     node:'a fragmentNode
    -> convertFragment:('fragment -> 'fragment)
    -> convertRefetchVariables:('refetchVariables -> 'refetchVariables)
    -> fRef:'b
    -> 'fragment
       * (variables:'refetchVariables
          -> ?fetchPolicy:FetchPolicy.t
          -> ?onComplete:(Js.Exn.t option -> unit)
          -> unit
          -> Disposable.t)
end

module RelayResolvers : sig
  type nonrec ('fragment, 't) resolver = 'fragment -> 't option
  type relayResolver

  val makeRelayResolver :
     node:'a fragmentNode
    -> convertFragment:('fragment -> 'fragment)
    -> ('fragment, 't) resolver
    -> relayResolver
end

module Subscriptions : sig
  val subscribe :
     node:'a subscriptionNode
    -> convertVariables:('variables -> 'variables)
    -> convertResponse:('response -> 'response)
    -> environment:Environment.t
    -> variables:'variables
    -> ?onCompleted:(unit -> unit)
    -> ?onError:(Js.Exn.t -> unit)
    -> ?onNext:('response -> unit)
    -> ?updater:(RecordSourceSelectorProxy.t -> 'response -> unit)
    -> unit
    -> Disposable.t
end

module Internal : sig
  val internal_useConvertedValue : ('a -> 'a) -> 'a -> 'a
  val internal_cleanObjectFromUndefinedRaw : 't -> 't
  val internal_removeUndefinedAndConvertNullsRaw : 't -> 't

  val internal_nullableToOptionalExnHandler :
     ('b option -> 'a) option
    -> ('b Js.Nullable.t -> 'a) option

  type arg = Arg : _ -> arg [@@live] [@@unboxed]

  val internal_keepMap : 'a array -> f:('a -> 'b option) -> 'b array
end
