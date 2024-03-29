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
           let convertVariables :
                [%t typeFromGeneratedModule [ "Types"; "variables" ]]
               -> [%t typeFromGeneratedModule [ "Types"; "variables" ]]
             =
             [%e valFromGeneratedModule [ "Internal"; "convertVariables" ]]]
       ; [%stri
           let convertResponse :
                [%t typeFromGeneratedModule [ "Types"; "response" ]]
               -> [%t typeFromGeneratedModule [ "Types"; "response" ]]
             =
             [%e valFromGeneratedModule [ "Internal"; "convertResponse" ]]]
       ; [%stri
           let convertWrapRawResponse :
                [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]]
               -> [%t typeFromGeneratedModule [ "Types"; "rawResponse" ]]
             =
             [%e
               valFromGeneratedModule [ "Internal"; "convertWrapRawResponse" ]]]
       ; [%stri
           external mkQueryRefOpt :
              [%t typeFromGeneratedModule [ "queryRef" ]] option
             -> [%t typeFromGeneratedModule [ "queryRef" ]] option
             = "%identity"]
       ; [%stri
           external mkQueryRef :
              [%t typeFromGeneratedModule [ "queryRef" ]]
             -> [%t typeFromGeneratedModule [ "queryRef" ]]
             = "%identity"]
       ; [%stri
           let use =
             Melange_relay.Query.useQuery
               ~convertVariables
               ~convertResponse
               ~node:[%e valFromGeneratedModule [ "node" ]]]
       ; [%stri
           let useLoader =
             Melange_relay.Query.useLoader
               ~convertVariables
               ~mkQueryRef:mkQueryRefOpt
               ~node:[%e valFromGeneratedModule [ "node" ]]]
       ; [%stri
           let usePreloaded =
             Melange_relay.Query.usePreloaded
               ~convertResponse
               ~mkQueryRef
               ~node:[%e valFromGeneratedModule [ "node" ]]]
       ; [%stri
           let fetch =
             Melange_relay.Query.fetch
               ~convertResponse
               ~convertVariables
               ~node:[%e valFromGeneratedModule [ "node" ]]]
       ; [%stri
           let fetchPromised =
             Melange_relay.Query.fetchPromised
               ~convertResponse
               ~convertVariables
               ~node:[%e valFromGeneratedModule [ "node" ]]]
       ; [%stri
           let retain =
             Melange_relay.Query.retain
               ~convertVariables
               ~node:[%e valFromGeneratedModule [ "node" ]]]
       ; (match hasRawResponseType with
         | true ->
           [%stri
             let commitLocalPayload =
               Melange_relay.Query.commitLocalPayload
                 ~convertVariables
                 ~convertWrapRawResponse
                 ~node:[%e valFromGeneratedModule [ "node" ]]]
         | false -> [%stri ()])
       ])
[@@ocaml.doc
  "\n\
  \ * Check out the comments for makeFragment, this does the same thing but \
   for queries.\n\
  \ "]
