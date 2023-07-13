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
           type subscriptionConfig =
             { subscription :
                 [%t typeFromGeneratedModule [ "relayOperationNode" ]]
                 Melange_relay.subscriptionNode
             ; variables : [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             ; onCompleted : (unit -> unit) option [@optional]
             ; onError : (Js.Exn.t -> unit) option [@optional]
             ; onNext :
                 ([%t typeFromGeneratedModule [ "Types"; "response" ]] -> unit) option
                   [@optional]
             ; updater : updaterFn option [@optional]
             }
           [@@deriving abstract] [@@live]]
       ; [%stri
           [%%private
           external internal_requestSubscription :
              Melange_relay.Environment.t
             -> subscriptionConfig
             -> Melange_relay.Disposable.t
             = "requestSubscription"
             [@@module "relay-runtime"] [@@live]]]
       ; [%stri
           let subscribe =
             (fun ~environment
                  ~variables
                  ?onCompleted
                  ?onError
                  ?onNext
                  ?updater
                  () ->
                internal_requestSubscription
                  environment
                  (subscriptionConfig
                     ~subscription:[%e valFromGeneratedModule [ "node" ]]
                     ~variables:
                       (variables
                       |. [%e
                            valFromGeneratedModule
                              [ "Internal"; "convertVariables" ]])
                     ?onCompleted
                     ?onError
                     ?onNext:
                       (match onNext with
                       | None -> None
                       | Some onNext ->
                         Some
                           (fun r ->
                             onNext
                               (r
                               |. [%e
                                    valFromGeneratedModule
                                      [ "Internal"; "convertResponse" ]])))
                     ?updater:
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
                     ())
               : environment:Melange_relay.Environment.t
                 -> variables:
                      [%t typeFromGeneratedModule [ "Types"; "variables" ]]
                 -> ?onCompleted:(unit -> unit)
                 -> ?onError:(Js.Exn.t -> unit)
                 -> ?onNext:
                      ([%t typeFromGeneratedModule [ "Types"; "response" ]]
                       -> unit)
                 -> ?updater:updaterFn
                 -> unit
                 -> Melange_relay.Disposable.t)
             [@@ocaml.doc
               "This sets up the subscription itself. You typically want to \
                run this in a React.useEffect."]
             [@@live]]
       ])
  [@@ocaml.doc
    "\n\
    \ * Check out the comments for makeFragment, this does the same thing but \
     for subscriptions.\n\
    \ "]
