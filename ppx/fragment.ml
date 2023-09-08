open Ppxlib
open Util

let make
    ~loc
    ~moduleName
    ~refetchableQueryName
    ~extractedConnectionInfo
    ~hasInlineDirective
  =
  let typeFromGeneratedModule = makeTypeAccessor ~loc ~moduleName in
  let valFromGeneratedModule = makeExprAccessor ~loc ~moduleName in
  let moduleIdentFromGeneratedModule = makeModuleIdent ~loc ~moduleName in
  let hasConnection = extractedConnectionInfo in
  Ast_helper.Mod.mk
    (Pmod_structure
       (List.concat
          [ [ [%stri [@@@warning "-32"]]
            ; [%stri include [%m moduleIdentFromGeneratedModule [ "Utils" ]]]
            ; [%stri
                module Types = [%m moduleIdentFromGeneratedModule [ "Types" ]]]
            ; [%stri module Operation = [%m moduleIdentFromGeneratedModule []]]
            ; [%stri
                let convertFragment :
                     [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
                    -> [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
                  =
                  [%e valFromGeneratedModule [ "Internal"; "convertFragment" ]]]
            ; [%stri
                let use fRef :
                    [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
                  =
                  Melange_relay.Fragment.useFragment
                    ~convertFragment
                    ~fRef:
                      (fRef |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
                    ~node:[%e valFromGeneratedModule [ "node" ]]]
            ; [%stri
                let useOpt fRef :
                    [%t typeFromGeneratedModule [ "Types"; "fragment" ]] option
                  =
                  Melange_relay.Fragment.useFragmentOpt
                    ~convertFragment
                    ~fRef:
                      (match fRef with
                      | Some fRef ->
                        Some
                          (fRef
                          |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
                      | None -> None)
                    ~node:[%e valFromGeneratedModule [ "node" ]]]
            ]
          ; (match hasInlineDirective with
            | true ->
              [ [%stri
                  let readInline fRef :
                      [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
                    =
                    Melange_relay.Fragment.readInlineData
                      ~convertFragment
                      ~fRef:
                        (fRef
                        |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
                      ~node:[%e valFromGeneratedModule [ "node" ]]]
              ]
            | false -> [])
          ; (match refetchableQueryName with
            | None -> []
            | Some refetchableQueryName ->
              let typeFromRefetchableModule =
                makeTypeAccessor ~loc ~moduleName:refetchableQueryName
              in
              let valFromRefetchableModule =
                makeExprAccessor ~loc ~moduleName:refetchableQueryName
              in
              [ [%stri
                  let makeRefetchVariables =
                    [%e
                      valFromRefetchableModule
                        [ "Types"; "makeRefetchVariables" ]]
                  [@@ocaml.doc "A helper to make refetch variables. "] [@@live]]
              ; [%stri
                  let convertRefetchVariables :
                       [%t
                         typeFromRefetchableModule
                           [ "Types"; "refetchVariables" ]]
                      -> [%t
                           typeFromRefetchableModule
                             [ "Types"; "refetchVariables" ]]
                    =
                    [%e
                      valFromRefetchableModule
                        [ "Internal"; "convertVariables" ]]]
              ; [%stri
                  let useRefetchable fRef =
                    Melange_relay.Fragment.useRefetchableFragment
                      ~convertFragment
                      ~convertRefetchVariables
                      ~fRef:
                        (fRef
                        |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
                      ~node:[%e valFromGeneratedModule [ "node" ]]]
              ]
              @
              if hasConnection
              then
                [ [%stri
                    let usePagination fRef =
                      Melange_relay.Fragment.usePaginationFragment
                        ~convertFragment
                        ~convertRefetchVariables
                        ~fRef:
                          (fRef
                          |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
                        ~node:[%e valFromGeneratedModule [ "node" ]]]
                ; [%stri
                    let useBlockingPagination fRef =
                      Melange_relay.Fragment.useBlockingPaginationFragment
                        ~convertFragment
                        ~convertRefetchVariables
                        ~fRef:
                          (fRef
                          |. [%e valFromGeneratedModule [ "getFragmentRef" ]])
                        ~node:[%e valFromGeneratedModule [ "node" ]]]
                ]
              else [])
          ]))
[@@ocaml.doc
  "\n\
  \ * This constructs a module definition AST, in this case for fragments. \
   Note it's only the definition structure,\n\
  \ * not the full definition.\n\
  \ "]
