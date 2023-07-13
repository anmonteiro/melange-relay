open Ppxlib

let makeGeneratedModuleImports ~loc ~moduleIdentFromGeneratedModule =
  [ [%stri [@@@ocaml.warning "-32-34-60"]]
  ; [%stri include [%m moduleIdentFromGeneratedModule [ "Utils" ]]]
  ; [%stri module Types = [%m moduleIdentFromGeneratedModule [ "Types" ]]]
  ]

let makeInternalExternals ~loc ~typeFromGeneratedModule =
  [ [%stri
      [%%private
      external internal_readInlineData :
         [%t typeFromGeneratedModule [ "relayOperationNode" ]]
         Melange_relay.fragmentNode
        -> [%t typeFromGeneratedModule [ "fragmentRef" ]]
        -> [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
        = "readInlineData"
        [@@live] [@@module "react-relay"]]]
  ; [%stri
      [%%private
      external internal_useFragment :
         [%t typeFromGeneratedModule [ "relayOperationNode" ]]
         Melange_relay.fragmentNode
        -> [%t typeFromGeneratedModule [ "fragmentRef" ]]
        -> [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
        = "useFragment"
        [@@live] [@@module "react-relay"]]]
  ; [%stri
      [%%private
      external internal_useFragmentOpt :
         [%t typeFromGeneratedModule [ "relayOperationNode" ]]
         Melange_relay.fragmentNode
        -> [%t typeFromGeneratedModule [ "fragmentRef" ]] Js.Nullable.t
        -> [%t typeFromGeneratedModule [ "Types"; "fragment" ]] Js.Nullable.t
        = "useFragment"
        [@@live] [@@module "react-relay"]]]
  ]

let makeRefetchableAssets
    ~loc
    ~refetchableQueryName
    ~typeFromGeneratedModule
    ~makeTypeAccessor
    ~makeExprAccessor
    ~valFromGeneratedModule
  =
  match refetchableQueryName with
  | None -> []
  | Some queryName ->
    [ [%stri
        type refetchableFnOpts =
          { fetchPolicy : string option [@optional]
          ; onComplete : (Js.Exn.t Js.Nullable.t -> unit) option [@optional]
          }
        [@@deriving abstract] [@@live]]
    ; [%stri
        let internal_makeRefetchableFnOpts ?fetchPolicy ?onComplete () =
          refetchableFnOpts
            ?fetchPolicy:(fetchPolicy |. Melange_relay.mapFetchPolicy)
            ?onComplete:
              (onComplete
              |. Melange_relay_internal.internal_nullableToOptionalExnHandler)
            ()
          [@@live]]
    ; [%stri
        type paginationLoadMoreOptions =
          { onComplete : (Js.Exn.t Js.nullable -> unit) option }
        [@@live]]
    ; [%stri
        type paginationLoadMoreFn =
          count:int
          -> ?onComplete:(Js.Exn.t option -> unit)
          -> unit
          -> Melange_relay.Disposable.t
        [@@live]]
    ; [%stri
        type paginationFragmentReturnRaw =
          { data : [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
          ; loadNext :
              (int -> paginationLoadMoreOptions -> Melange_relay.Disposable.t
              [@bs])
          ; loadPrevious :
              (int -> paginationLoadMoreOptions -> Melange_relay.Disposable.t
              [@bs])
          ; hasNext : bool
          ; hasPrevious : bool
          ; isLoadingNext : bool
          ; isLoadingPrevious : bool
          ; refetch :
              ([%t
                 makeTypeAccessor
                   ~loc
                   ~moduleName:queryName
                   [ "Types"; "refetchVariables" ]]
               -> refetchableFnOpts
               -> Melange_relay.Disposable.t
              [@bs])
          }
        [@@live]]
    ; [%stri
        type paginationBlockingFragmentReturn =
          { data : [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
          ; loadNext : paginationLoadMoreFn
          ; loadPrevious : paginationLoadMoreFn
          ; hasNext : bool
          ; hasPrevious : bool
          ; refetch :
              variables:
                [%t
                  makeTypeAccessor
                    ~loc
                    ~moduleName:queryName
                    [ "Types"; "refetchVariables" ]]
              -> ?fetchPolicy:Melange_relay.fetchPolicy
              -> ?onComplete:(Js.Exn.t option -> unit)
              -> unit
              -> Melange_relay.Disposable.t
          }
        [@@live]]
    ; [%stri
        type paginationFragmentReturn =
          { data : [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
          ; loadNext : paginationLoadMoreFn
          ; loadPrevious : paginationLoadMoreFn
          ; hasNext : bool
          ; hasPrevious : bool
          ; isLoadingNext : bool
          ; isLoadingPrevious : bool
          ; refetch :
              variables:
                [%t
                  makeTypeAccessor
                    ~loc
                    ~moduleName:queryName
                    [ "Types"; "refetchVariables" ]]
              -> ?fetchPolicy:Melange_relay.fetchPolicy
              -> ?onComplete:(Js.Exn.t option -> unit)
              -> unit
              -> Melange_relay.Disposable.t
          }
        [@@live]]
    ; [%stri
        [%%private
        external internal_usePaginationFragment :
           [%t typeFromGeneratedModule [ "relayOperationNode" ]]
           Melange_relay.fragmentNode
          -> [%t typeFromGeneratedModule [ "fragmentRef" ]]
          -> paginationFragmentReturnRaw
          = "usePaginationFragment"
          [@@module "react-relay"] [@@live]]]
    ; [%stri
        [%%private
        external internal_useBlockingPaginationFragment :
           [%t typeFromGeneratedModule [ "relayOperationNode" ]]
           Melange_relay.fragmentNode
          -> [%t typeFromGeneratedModule [ "fragmentRef" ]]
          -> paginationFragmentReturnRaw
          = "useBlockingPaginationFragment"
          [@@module "react-relay"] [@@live]]]
    ; [%stri
        [%%private
        external internal_useRefetchableFragment :
           [%t typeFromGeneratedModule [ "relayOperationNode" ]]
           Melange_relay.fragmentNode
          -> [%t typeFromGeneratedModule [ "fragmentRef" ]]
          -> [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
             * ([%t
                  makeTypeAccessor
                    ~loc
                    ~moduleName:queryName
                    [ "Types"; "refetchVariables" ]]
                -> refetchableFnOpts
                -> Melange_relay.Disposable.t)
          = "useRefetchableFragment"
          [@@module "react-relay"] [@@live]]]
    ; [%stri
        let useRefetchable fRef =
          let fragmentData, refetchFn =
            internal_useRefetchableFragment
              [%e valFromGeneratedModule [ "node" ]]
              (fRef |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
          in
          let data =
            (Melange_relay_internal.internal_useConvertedValue
               [%e valFromGeneratedModule [ "Internal"; "convertFragment" ]]
               fragmentData
              : [%t typeFromGeneratedModule [ "Types"; "fragment" ]])
          in
          ( data
          , React.useMemo1
              (fun ()
                   ~(variables :
                      [%t
                        makeTypeAccessor
                          ~loc
                          ~moduleName:queryName
                          [ "Types"; "refetchVariables" ]])
                   ?(fetchPolicy : Melange_relay.fetchPolicy option)
                   ?(onComplete : (Js.Exn.t option -> unit) option)
                   () : Melange_relay.Disposable.t ->
                refetchFn
                  (variables
                  |. [%e
                       makeExprAccessor
                         ~loc
                         ~moduleName:queryName
                         [ "Internal"; "convertVariables" ]]
                  |. Melange_relay_internal
                     .internal_removeUndefinedAndConvertNullsRaw)
                  (internal_makeRefetchableFnOpts ?fetchPolicy ?onComplete ()))
              [| refetchFn |] )
          [@@ocaml.doc
            "React hook for using a fragment that you want to refetch. Returns \
             a tuple of `(fragmentData, refetchFn)`.\n\n\
             ### Refetching and variables\n\
             You supply a _diff_ of your variables to Relay when refetching. \
             Diffed variables here means that any new value you supply when \
             refetching will be merged with the variables you last used when \
             fetching data for this fragment.\n\n\
             ### `Fragment.makeRefetchVariables` - helper for making the \
             refetch variables\n\
             There's a helper generated for you to create those diffed \
             variables more easily at `Fragment.makeRefetchVariables`."]
          [@@live]]
    ]
