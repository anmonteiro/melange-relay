open Ppxlib
open Util

let make ~loc ~moduleName ~hasRawResponseType =
  let typeFromGeneratedModule = makeTypeAccessor ~loc ~moduleName in
  let valFromGeneratedModule = makeExprAccessor ~loc ~moduleName in
  let moduleIdentFromGeneratedModule = makeModuleIdent ~loc ~moduleName in
  Ast_helper.Mod.mk
    (Pmod_structure
       [ [%stri [@@@ocaml.warning "-32-34-60"]]
       ; [%stri include [%m moduleIdentFromGeneratedModule [ "Utils" ]]]
       ; [%stri module Operation = [%m moduleIdentFromGeneratedModule []]]
       ; [%stri module Types = [%m moduleIdentFromGeneratedModule [ "Types" ]]]
       ; [%stri
           [%%private
           external internal_createOperationDescriptor :
              [%t typeFromGeneratedModule [ "relayOperationNode" ]]
              Melange_relay.queryNode
             -> [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             -> Melange_relay.operationDescriptor
             = "createOperationDescriptor"
             [@@module "relay-runtime"] [@@live]]]
       ; [%stri
           type useQueryConfig =
             { fetchKey : string option
             ; fetchPolicy : string option
             ; networkCacheConfig : Melange_relay.cacheConfig option
             }
           [@@live]]
       ; [%stri
           [%%private
           external internal_useQuery :
              [%t typeFromGeneratedModule [ "relayOperationNode" ]]
              Melange_relay.queryNode
             -> [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             -> useQueryConfig
             -> [%t typeFromGeneratedModule [ "Types"; "response" ]]
             = "useLazyLoadQuery"
             [@@module "react-relay"] [@@live]]]
       ; [%stri
           [%%private
           external internal_usePreloadedQuery :
              [%t typeFromGeneratedModule [ "relayOperationNode" ]]
              Melange_relay.queryNode
             -> [%t typeFromGeneratedModule [ "queryRef" ]]
             -> [%t typeFromGeneratedModule [ "Types"; "response" ]]
             = "usePreloadedQuery"
             [@@module "react-relay"] [@@live]]]
       ; [%stri
           type useQueryLoaderOptions =
             { fetchPolicy : Melange_relay.fetchPolicy option
             ; networkCacheConfig : Melange_relay.cacheConfig option
             }
           [@@live]]
       ; [%stri
           [%%private
           external internal_useQueryLoader :
              [%t typeFromGeneratedModule [ "relayOperationNode" ]]
              Melange_relay.queryNode
             -> [%t typeFromGeneratedModule [ "queryRef" ]] Js.nullable
                * ([%t typeFromGeneratedModule [ "Types"; "variables" ]]
                   -> useQueryLoaderOptions
                   -> unit)
                * (unit -> unit)
             = "useQueryLoader"
             [@@module "react-relay"] [@@live]]]
       ; [%stri
           [%%private
           external internal_fetchQuery :
              Melange_relay.Environment.t
             -> [%t typeFromGeneratedModule [ "relayOperationNode" ]]
                Melange_relay.queryNode
             -> [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             -> Melange_relay.fetchQueryOptions option
             -> [%t typeFromGeneratedModule [ "Types"; "response" ]]
                Melange_relay.Observable.t
             = "fetchQuery"
             [@@module "react-relay"] [@@live]]]
       ; [%stri
           let use
               ~(variables :
                  [%t typeFromGeneratedModule [ "Types"; "variables" ]])
               ?(fetchPolicy : Melange_relay.fetchPolicy option)
               ?(fetchKey : string option)
               ?(networkCacheConfig : Melange_relay.cacheConfig option)
               () : [%t typeFromGeneratedModule [ "Types"; "response" ]]
             =
             let data =
               (internal_useQuery
                  [%e valFromGeneratedModule [ "node" ]]
                  (variables
                  |. [%e
                       valFromGeneratedModule [ "Internal"; "convertVariables" ]]
                  |. Melange_relay_internal.internal_cleanObjectFromUndefinedRaw
                  )
                  { fetchKey
                  ; fetchPolicy = fetchPolicy |. Melange_relay.mapFetchPolicy
                  ; networkCacheConfig
                  }
                 : [%t typeFromGeneratedModule [ "Types"; "response" ]])
             in
             Melange_relay_internal.internal_useConvertedValue
               [%e valFromGeneratedModule [ "Internal"; "convertResponse" ]]
               data
             [@@ocaml.doc
               "React hook for using this query.\n\n\
                Prefer using `Query.useLoader()` or \
                `YourQueryName_graphql.load()` in combination with \
                `Query.usePreloaded()` to this whenever you can, as that will \
                allow you to start loading data before your code actually \
                renders."]
             [@@live]]
       ; [%stri
           let useLoader () :
               [%t typeFromGeneratedModule [ "queryRef" ]] option
               * (variables:
                    [%t typeFromGeneratedModule [ "Types"; "variables" ]]
                  -> ?fetchPolicy:Melange_relay.fetchPolicy
                  -> ?networkCacheConfig:Melange_relay.cacheConfig
                  -> unit
                  -> unit)
               * (unit -> unit)
             =
             let nullableQueryRef, loadQueryFn, disposableFn =
               internal_useQueryLoader [%e valFromGeneratedModule [ "node" ]]
             in
             let loadQuery =
               React.useMemo1
                 (fun ()
                      ~(variables :
                         [%t typeFromGeneratedModule [ "Types"; "variables" ]])
                      ?fetchPolicy
                      ?networkCacheConfig
                      () ->
                   loadQueryFn
                     (variables
                     |. [%e
                          valFromGeneratedModule
                            [ "Internal"; "convertVariables" ]])
                     { fetchPolicy; networkCacheConfig })
                 [| loadQueryFn |]
             in
             Js.Nullable.toOption nullableQueryRef, loadQuery, disposableFn
             [@@ocaml.doc
               "React hook for preloading this query. Returns a tuple of \
                `(loadedQueryRef, loadQueryFn, dispose)`.\n\n\
                Use this together with `Query.usePreloaded`."]
             [@@live]]
       ; [%stri
           let fetch
               ~(environment : Melange_relay.Environment.t)
               ~(variables :
                  [%t typeFromGeneratedModule [ "Types"; "variables" ]])
               ~(onResult :
                  ( [%t typeFromGeneratedModule [ "Types"; "response" ]]
                  , Js.Exn.t )
                  Belt.Result.t
                  -> unit)
               ?(networkCacheConfig : Melange_relay.cacheConfig option)
               ?(fetchPolicy : Melange_relay.fetchQueryFetchPolicy option)
               () : unit
             =
             let open Melange_relay.Observable in
             let _ =
               (internal_fetchQuery
                  environment
                  [%e valFromGeneratedModule [ "node" ]]
                  (variables
                  |. [%e
                       valFromGeneratedModule [ "Internal"; "convertVariables" ]]
                  )
                  (Some
                     { networkCacheConfig
                     ; fetchPolicy =
                         fetchPolicy |. Melange_relay.mapFetchQueryFetchPolicy
                     })
               |. subscribe)
                 (makeObserver
                    ~next:(fun res ->
                      onResult
                        (Ok
                           (res
                           |. [%e
                                valFromGeneratedModule
                                  [ "Internal"; "convertResponse" ]])))
                    ~error:(fun err -> onResult (Error err))
                    ())
             in
             ()
             [@@ocaml.doc
               "\n\
                This fetches the query in a one-off fashion, and returns a \
                `Belt.Result.t` in a callback for convenience. Use \
                `Query.fetchPromised` if you need this but with promises.\n\n\
                Please *avoid* using `Query.fetch` unless you really need it, \
                since the data you fetch here isn't guaranteed to stick around \
                in the store/cache unless you explicitly use it somewhere in \
                your views."]
             [@@live]]
       ; [%stri
           let fetchPromised
               ~(environment : Melange_relay.Environment.t)
               ~(variables :
                  [%t typeFromGeneratedModule [ "Types"; "variables" ]])
               ?(networkCacheConfig : Melange_relay.cacheConfig option)
               ?(fetchPolicy : Melange_relay.fetchQueryFetchPolicy option)
               () :
               [%t typeFromGeneratedModule [ "Types"; "response" ]] Js.Promise.t
             =
             internal_fetchQuery
               environment
               [%e valFromGeneratedModule [ "node" ]]
               (variables
               |. [%e valFromGeneratedModule [ "Internal"; "convertVariables" ]]
               )
               (Some
                  { networkCacheConfig
                  ; fetchPolicy =
                      fetchPolicy |. Melange_relay.mapFetchQueryFetchPolicy
                  })
             |. Melange_relay.Observable.toPromise
             |. fun __x ->
             Js.Promise.then_
               (fun res ->
                 res
                 |. [%e
                      valFromGeneratedModule [ "Internal"; "convertResponse" ]]
                 |. Js.Promise.resolve)
               __x
             [@@ocaml.doc " Promise variant of `Query.fetch`."] [@@live]]
       ; [%stri
           let usePreloaded
               ~(queryRef : [%t typeFromGeneratedModule [ "queryRef" ]])
               () : [%t typeFromGeneratedModule [ "Types"; "response" ]]
             =
             let data =
               (internal_usePreloadedQuery
                  [%e valFromGeneratedModule [ "node" ]]
                  queryRef
                 : [%t typeFromGeneratedModule [ "Types"; "response" ]])
             in
             Melange_relay_internal.internal_useConvertedValue
               [%e valFromGeneratedModule [ "Internal"; "convertResponse" ]]
               data
             [@@ocaml.doc
               "Combine this with `Query.useLoader` or \
                `YourQueryName_graphql.load()` to use a query you've started \
                preloading before rendering."]
             [@@live]]
       ; [%stri
           let retain
               ~(environment : Melange_relay.Environment.t)
               ~(variables :
                  [%t typeFromGeneratedModule [ "Types"; "variables" ]])
             =
             let operationDescriptor =
               internal_createOperationDescriptor
                 [%e valFromGeneratedModule [ "node" ]]
                 (variables
                 |. [%e
                      valFromGeneratedModule [ "Internal"; "convertVariables" ]]
                 )
             in
             (environment |. Melange_relay.Environment.retain)
               operationDescriptor
             [@@ocaml.doc
               "Calling with a set of variables will make Relay _disable \
                garbage collection_ of this query (+ variables) until you \
                explicitly dispose the `Disposable.t` you get back from this \
                call.\n\n\
                Useful for queries and data you know you want to keep in the \
                store regardless of what happens (like it not being used by \
                any view and therefore potentially garbage collected)."]
             [@@live]]
       ; (match hasRawResponseType with
         | true ->
           [%stri
             let commitLocalPayload
                 ~(environment : Melange_relay.Environment.t)
                 ~(variables :
                    [%t typeFromGeneratedModule [ "Types"; "variables" ]])
                 ~(payload :
                    [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]])
               =
               let operationDescriptor =
                 internal_createOperationDescriptor
                   [%e valFromGeneratedModule [ "node" ]]
                   (variables
                   |. [%e
                        valFromGeneratedModule
                          [ "Internal"; "convertVariables" ]])
               in
               (environment |. Melange_relay.Environment.commitPayload)
                 operationDescriptor
                 (payload
                 |. [%e
                      valFromGeneratedModule
                        [ "Internal"; "convertWrapRawResponse" ]])
               [@@ocaml.doc
                 "This commits a payload into the store _locally only_. Useful \
                  for driving client-only state via Relay for example, or \
                  priming the cache with data you don't necessarily want to \
                  hit the server for."]
               [@@live]]
         | false -> [%stri ()])
       ])
  [@@ocaml.doc
    "\n\
    \ * Check out the comments for makeFragment, this does the same thing but \
     for queries.\n\
    \ "]
