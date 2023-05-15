open Ppxlib
open Util

let make ~loc ~moduleName =
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
           type updaterFn =
             Melange_relay.RecordSourceSelectorProxy.t
             -> [%t typeFromGeneratedModule [ "Types"; "response" ]]
             -> unit
           [@@live]]
       ; [%stri
           type optimisticUpdaterFn =
             Melange_relay.RecordSourceSelectorProxy.t -> unit
           [@@live]]
       ; [%stri
           type useMutationConfig =
             { onError : (Melange_relay.mutationError -> unit) option
             ; onCompleted :
                 ([%t typeFromGeneratedModule [ "Types"; "response" ]]
                  -> Melange_relay.mutationError array option
                  -> unit)
                 option
             ; onUnsubscribe : (unit -> unit) option
             ; optimisticResponse :
                 [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]] option
             ; optimisticUpdater : optimisticUpdaterFn option
             ; updater : updaterFn option
             ; variables : [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             ; uploadables : Melange_relay.uploadables option
             }
           [@@live]]
       ; [%stri
           type useMutationConfigRaw =
             { onError : (Melange_relay.mutationError -> unit) option
             ; onCompleted :
                 ([%t typeFromGeneratedModule [ "Types"; "response" ]]
                  -> Melange_relay.mutationError array Js.Nullable.t
                  -> unit)
                 option
             ; onUnsubscribe : (unit -> unit) option
             ; optimisticResponse :
                 [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]] option
             ; optimisticUpdater : optimisticUpdaterFn option
             ; updater : updaterFn option
             ; variables : [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             ; uploadables : Melange_relay.uploadables option
             }
           [@@live]]
       ; [%stri
           type commitMutationConfigRaw =
             { mutation :
                 [%t typeFromGeneratedModule [ "relayOperationNode" ]]
                 Melange_relay.mutationNode
             ; variables : [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             ; onCompleted :
                 ([%t typeFromGeneratedModule [ "Types"; "response" ]]
                  -> Melange_relay.mutationError array Js.Nullable.t
                  -> unit)
                 option
             ; onError :
                 (Melange_relay.mutationError Js.Nullable.t -> unit) option
             ; optimisticResponse :
                 [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]] option
             ; optimisticUpdater : optimisticUpdaterFn option
             ; updater : updaterFn option
             ; uploadables : Melange_relay.uploadables option
             }
           [@@live]]
       ; [%stri
           [%%private
           external internal_commitMutation :
              Melange_relay.Environment.t
             -> commitMutationConfigRaw
             -> Melange_relay.Disposable.t
             = "commitMutation"
             [@@module "relay-runtime"] [@@live]]]
       ; [%stri
           [%%private
           external internal_useMutation :
              [%t typeFromGeneratedModule [ "relayOperationNode" ]]
              Melange_relay.mutationNode
             -> (useMutationConfigRaw -> Melange_relay.Disposable.t) * bool
             = "useMutation"
             [@@module "react-relay"] [@@live]]]
       ; [%stri
           let commitMutation =
             (fun ~environment
                  ~variables
                  ?optimisticUpdater
                  ?optimisticResponse
                  ?updater
                  ?onCompleted
                  ?onError
                  ?uploadables
                  () : Melange_relay.Disposable.t ->
                internal_commitMutation
                  environment
                  { variables =
                      variables
                      |. [%e
                           valFromGeneratedModule
                             [ "Internal"; "convertVariables" ]]
                  ; mutation = [%e valFromGeneratedModule [ "node" ]]
                  ; onCompleted =
                      Some
                        (fun res err ->
                          match onCompleted with
                          | Some cb ->
                            cb
                              (res
                              |. [%e
                                   valFromGeneratedModule
                                     [ "Internal"; "convertResponse" ]])
                              (Js.Nullable.toOption err)
                          | None -> ())
                  ; onError =
                      Some
                        (fun err ->
                          match onError with
                          | Some cb -> cb (Js.Nullable.toOption err)
                          | None -> ())
                  ; uploadables
                  ; optimisticResponse =
                      (match optimisticResponse with
                      | None -> None
                      | Some r ->
                        Some
                          (r
                          |. [%e
                               valFromGeneratedModule
                                 [ "Internal"; "convertWrapRawResponse" ]]))
                  ; optimisticUpdater
                  ; updater =
                      (match updater with
                      | None -> None
                      | Some updater ->
                        Some
                          (fun store r ->
                            updater
                              store
                              (r
                              |. [%e
                                   valFromGeneratedModule
                                     [ "Internal"; "convertResponse" ]])))
                  }
               : environment:Melange_relay.Environment.t
                 -> variables:
                      [%t typeFromGeneratedModule [ "Types"; "variables" ]]
                 -> ?optimisticUpdater:optimisticUpdaterFn
                 -> ?optimisticResponse:
                      [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]]
                 -> ?updater:
                      (Melange_relay.RecordSourceSelectorProxy.t
                       -> [%t typeFromGeneratedModule [ "Types"; "response" ]]
                       -> unit)
                 -> ?onCompleted:
                      ([%t typeFromGeneratedModule [ "Types"; "response" ]]
                       -> Melange_relay.mutationError array option
                       -> unit)
                 -> ?onError:(Melange_relay.mutationError option -> unit)
                 -> ?uploadables:Melange_relay.uploadables
                 -> unit
                 -> Melange_relay.Disposable.t)
             [@@ocaml.doc
               "Commits the current mutation. Use this outside of React's \
                render. If you're inside render, you should use `Mutation.use` \
                instead, which is more convenient.\n\n\
                ### Optimistic updates\n\
                Remember to annotate your mutation with `@raw_response_type` \
                if you want to do optimistic updates. That'll make Relay emit \
                the required type information for covering everything needed \
                when doing optimistic updates."]
             [@@live]]
       ; [%stri
           let use =
             (fun () ->
                let mutate, mutating =
                  internal_useMutation [%e valFromGeneratedModule [ "node" ]]
                in
                ( React.useMemo1
                    (fun ()
                         ?onError
                         ?onCompleted
                         ?onUnsubscribe
                         ?optimisticResponse
                         ?optimisticUpdater
                         ?updater
                         ~variables
                         ?uploadables
                         () ->
                      mutate
                        { onError
                        ; onCompleted =
                            (match onCompleted with
                            | Some fn ->
                              Some
                                (fun r errors ->
                                  fn
                                    (r
                                    |. [%e
                                         valFromGeneratedModule
                                           [ "Internal"; "convertResponse" ]])
                                    (Js.Nullable.toOption errors))
                            | None -> None)
                        ; optimisticResponse =
                            (match optimisticResponse with
                            | None -> None
                            | Some r ->
                              Some
                                (r
                                |. [%e
                                     valFromGeneratedModule
                                       [ "Internal"; "convertWrapRawResponse" ]]
                                ))
                        ; onUnsubscribe
                        ; variables =
                            variables
                            |. [%e
                                 valFromGeneratedModule
                                   [ "Internal"; "convertVariables" ]]
                        ; optimisticUpdater
                        ; uploadables
                        ; updater =
                            (match updater with
                            | None -> None
                            | Some updater ->
                              Some
                                (fun store r ->
                                  updater
                                    store
                                    (r
                                    |. [%e
                                         valFromGeneratedModule
                                           [ "Internal"; "convertResponse" ]])))
                        })
                    [| mutate |]
                , mutating )
               : unit
                 -> (?onError:(Melange_relay.mutationError -> unit)
                     -> ?onCompleted:
                          ([%t typeFromGeneratedModule [ "Types"; "response" ]]
                           -> Melange_relay.mutationError array option
                           -> unit)
                     -> ?onUnsubscribe:(unit -> unit)
                     -> ?optimisticResponse:
                          [%t
                            typeFromGeneratedModule [ "Types"; "rawResponse" ]]
                     -> ?optimisticUpdater:optimisticUpdaterFn
                     -> ?updater:
                          (Melange_relay.RecordSourceSelectorProxy.t
                           -> [%t
                                typeFromGeneratedModule [ "Types"; "response" ]]
                           -> unit)
                     -> variables:
                          [%t typeFromGeneratedModule [ "Types"; "variables" ]]
                     -> ?uploadables:Melange_relay.uploadables
                     -> unit
                     -> Melange_relay.Disposable.t)
                    * bool)
             [@@ocaml.doc
               "React hook for commiting this mutation.\n\n\
                ### Optimistic updates\n\
                Remember to annotate your mutation with `@raw_response_type` \
                if you want to do optimistic updates. That'll make Relay emit \
                the required type information for covering everything needed \
                when doing optimistic updates."]
             [@@live]]
       ])
  [@@ocaml.doc
    "\n\
    \ * Check out the comments for makeFragment, this does the same thing but \
     for mutations.\n\
    \ "]
