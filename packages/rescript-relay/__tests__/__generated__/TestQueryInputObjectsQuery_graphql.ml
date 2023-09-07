(* @sourceLoc Test_queryInputObjects.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type searchInput = RelaySchemaAssets_graphql.input_SearchInput
  type response = {
    search: string option;
  }
  type rawResponse = response
  type variables = {
    input: searchInput;
  }
  type refetchVariables = {
    input: searchInput option;
  }
  let makeRefetchVariables 
    ?input 
    ()
  : refetchVariables = {
    input= input
  }

end

module Internal = struct
  let variablesConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"searchInput":{},"__root":{"input":{"r":"searchInput"}}}|json}
  ]
  let variablesConverterMap = ()
  let convertVariables v = Melange_relay.convertObj v 
    variablesConverter 
    variablesConverterMap 
    Js.undefined
    type wrapResponseRaw
  let wrapResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{}|json}
  ]
  let wrapResponseConverterMap = ()
  let convertWrapResponse v = Melange_relay.convertObj v 
    wrapResponseConverter 
    wrapResponseConverterMap 
    Js.null
    type responseRaw
  let responseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{}|json}
  ]
  let responseConverterMap = ()
  let convertResponse v = Melange_relay.convertObj v 
    responseConverter 
    responseConverterMap 
    Js.undefined
    type wrapRawResponseRaw = wrapResponseRaw
  let convertWrapRawResponse = convertWrapResponse
  type rawResponseRaw = responseRaw
  let convertRawResponse = convertResponse
end

type queryRef

module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types
  external make_searchInput:     id: int-> 
    ?names: string option array-> 
    ?someOtherId: float-> 
    unit ->
   searchInput = "" [@@mel.obj]


  external makeVariables:     input: searchInput-> 
   variables = "" [@@mel.obj]


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.queryNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "input"
  }
],
v1 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Variable",
        "name": "input",
        "variableName": "input"
      }
    ],
    "kind": "ScalarField",
    "name": "search",
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "TestQueryInputObjectsQuery",
    "selections": (v1/*: any*/),
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "TestQueryInputObjectsQuery",
    "selections": (v1/*: any*/)
  },
  "params": {
    "cacheID": "8441859dad587e683a224cfc73959cdc",
    "id": null,
    "metadata": {},
    "name": "TestQueryInputObjectsQuery",
    "operationKind": "query",
    "text": "query TestQueryInputObjectsQuery(\n  $input: SearchInput!\n) {\n  search(input: $input)\n}\n"
  }
};
})() |json}]

include Melange_relay.MakeLoadQuery(struct
            type variables = Types.variables
            type loadedQueryRef = queryRef
            type response = Types.response
            type node = relayOperationNode
            let query = node
            let convertVariables = Internal.convertVariables
        end)
