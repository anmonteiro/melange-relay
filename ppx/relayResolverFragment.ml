open Ppxlib
open Util

let make ~loc ~moduleName =
  let typeFromGeneratedModule = makeTypeAccessor ~loc ~moduleName in
  let valFromGeneratedModule = makeExprAccessor ~loc ~moduleName in
  let moduleIdentFromGeneratedModule = makeModuleIdent ~loc ~moduleName in
  Ast_helper.Mod.mk
    (Pmod_structure
       (List.concat
          [ [ [%stri [@@@warning "-32"]]
            ; [%stri include [%m moduleIdentFromGeneratedModule [ "Utils" ]]]
            ; [%stri
                module Types = [%m moduleIdentFromGeneratedModule [ "Types" ]]]
            ; [%stri
                let convertFragment :
                     [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
                    -> [%t typeFromGeneratedModule [ "Types"; "fragment" ]]
                  =
                  [%e valFromGeneratedModule [ "Internal"; "convertFragment" ]]]
            ; [%stri
                let makeRelayResolver
                    (resolver :
                      [%t
                        makeTypeAccessorWithParams
                          [ "Melange_relay"; "RelayResolvers"; "resolver" ]
                          ~loc
                          ~params:
                            [ typeFromGeneratedModule [ "Types"; "fragment" ]
                            ; makeTypeAccessorRaw ~loc [ "t" ]
                            ]])
                  =
                  Melange_relay.RelayResolvers.makeRelayResolver
                    ~convertFragment
                    ~node:[%e valFromGeneratedModule [ "node" ]]
                    resolver]
            ]
          ]))
