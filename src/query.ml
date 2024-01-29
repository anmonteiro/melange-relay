open Types

type nonrec useQueryConfig =
  { fetchKey : string option [@mel.optional]
  ; fetchPolicy : string option [@mel.optional]
  ; networkCacheConfig : cacheConfig option [@mel.optional]
  }
[@@deriving jsProperties, getSet]

external useLazyLoadQuery :
   'node queryNode
  -> 'variables
  -> useQueryConfig
  -> 'response
  = "useLazyLoadQuery"
[@@mel.module "react-relay"]

(* React hook for using this query. Prefer using `Query.useLoader()` or
   `YourQueryName_graphql.load()` in combination with `Query.usePreloaded()` to
   this whenever you can, as that will allow you to start loading data before
   your code actually renders.*)
let useQuery
    ~(convertVariables : 'variables -> 'variables)
    ~(node : 'm)
    ~(convertResponse : 'response -> 'response)
    ~(variables : 'variables)
    ?fetchPolicy
    ?fetchKey
    ?networkCacheConfig
    ()
  =
  useLazyLoadQuery
    node
    (Internal.internal_cleanObjectFromUndefinedRaw
       (variables |. convertVariables))
    (useQueryConfig
       ?fetchKey
       ?fetchPolicy:(fetchPolicy |. FetchPolicy.map)
       ?networkCacheConfig
       ())
  |. fun __x -> Internal.internal_useConvertedValue convertResponse __x

type nonrec useQueryLoaderOptions =
  { fetchPolicy : string option [@mel.optional]
  ; networkCacheConfig : cacheConfig option [@mel.optional]
  }
[@@deriving jsProperties, getSet]

external useQueryLoader :
   'node queryNode
  -> 'queryRef Js.Nullable.t
     * ('variables -> useQueryLoaderOptions -> unit)
     * (unit -> unit)
  = "useQueryLoader"
[@@mel.module "react-relay"]

type nonrec ('queryRef, 'variables) loaderTuple =
  'queryRef option
  * (variables:'variables
     -> ?fetchPolicy:FetchPolicy.t
     -> ?networkCacheConfig:cacheConfig
     -> unit
     -> unit)
  * (unit -> unit)
[@@warning "-34"]

let useLoader
    ~(convertVariables : 'variables -> 'variables)
    ~(node : 'm)
    ~(mkQueryRef : 'queryRef option -> 'queryRef option)
    ()
  =
  let nullableQueryRef, loadQueryFn, disposableFn = useQueryLoader node in
  let loadQuery =
    React.useMemo1
      (fun () ~variables ?fetchPolicy ?networkCacheConfig () ->
        loadQueryFn
          (variables |. convertVariables)
          (useQueryLoaderOptions
             ?fetchPolicy:(fetchPolicy |. FetchPolicy.map)
             ?networkCacheConfig
             ()))
      [| loadQueryFn |]
  in
  ( nullableQueryRef |. Js.Nullable.toOption |. mkQueryRef
  , loadQuery
  , disposableFn )

external usePreloadedQuery :
   'node queryNode
  -> 'queryRef
  -> 'response
  = "usePreloadedQuery"
[@@mel.module "react-relay"]

(** Combine this with `Query.useLoader` or `YourQueryName_graphql.load()` to use
    a query you've started preloading before rendering. *)
let usePreloaded
    ~node
    ~(convertResponse : 'response -> 'response)
    ~(mkQueryRef : 'queryRef -> 'queryRef)
    ~(queryRef : 'queryRef)
  =
  usePreloadedQuery node (queryRef |. mkQueryRef) |. fun __x ->
  Internal.internal_useConvertedValue convertResponse __x

external fetchQuery :
   Environment.t
  -> 'node queryNode
  -> 'variables
  -> fetchQueryOptions option
  -> 'response Observable.t
  = "fetchQuery"
[@@mel.module "react-relay"]

(** This fetches the query in a one-off fashion, and returns a `Belt.Result.t`
    in a callback for convenience. Use `Query.fetchPromised` if you need this
    but with promises. Please *avoid* using `Query.fetch` unless you really need
    it, since the data you fetch here isn't guaranteed to stick around in the
    store/cache unless you explicitly use it somewhere in your views.*)
let fetch
    ~node
    ~(convertResponse : 'response -> 'response)
    ~(convertVariables : 'variables -> 'variables)
    ~(environment : Environment.t)
    ~(variables : 'variables)
    ~onResult
    ?networkCacheConfig
    ?fetchPolicy
    ()
  =
  let open Observable in
  fetchQuery
    environment
    node
    (variables |. convertVariables)
    (Some { networkCacheConfig; fetchPolicy = fetchPolicy |. FetchPolicy.map })
  |. subscribe
       (makeObserver
          ~next:(fun res -> onResult (Ok (res |. convertResponse)))
          ~error:(fun err -> onResult (Error err))
          ())
  |. ignoreSubscription

(**Promise variant of `Query.fetch`.*)
let fetchPromised
    ~node
    ~(convertResponse : 'response -> 'response)
    ~(convertVariables : 'variables -> 'variables)
    ~(environment : Environment.t)
    ~(variables : 'variables)
    ?networkCacheConfig
    ?fetchPolicy
    ()
  =
  fetchQuery
    environment
    node
    (variables |. convertVariables)
    (Some { networkCacheConfig; fetchPolicy = fetchPolicy |. FetchPolicy.map })
  |. Observable.toPromise
  |> Js.Promise.then_ (fun res -> res |. convertResponse |. Js.Promise.resolve)

external createOperationDescriptor :
   'node queryNode
  -> 'variables
  -> operationDescriptor
  = "createOperationDescriptor"
[@@mel.module "relay-runtime"]

(**Calling with a set of variables will make Relay _disable garbage collection_
   of this query (+ variables) until you explicitly dispose the `Disposable.t`
   you get back from this call. Useful for queries and data you know you want to
   keep in the store regardless of what happens (like it not being used by any
   view and therefore potentially garbage collected).*)
let retain
    ~node
    ~(convertVariables : 'variables -> 'variables)
    ~(environment : Environment.t)
    ~(variables : 'variables)
  =
  environment
  |. Environment.retain
       (createOperationDescriptor node (variables |. convertVariables))

(** This commits a payload into the store _locally only_. Useful for driving
    client-only state via Relay for example, or priming the cache with data you
    don't necessarily want to hit the server for. *)
let commitLocalPayload
    ~node
    ~(convertVariables : 'variables -> 'variables)
    ~(convertWrapRawResponse : 'rawResponse -> 'rawResponse)
    ~(environment : Environment.t)
    ~(variables : 'variables)
    ~(payload : 'rawResponse)
  =
  environment
  |. Environment.commitPayload
       (createOperationDescriptor node (variables |. convertVariables))
       (payload |. convertWrapRawResponse)
