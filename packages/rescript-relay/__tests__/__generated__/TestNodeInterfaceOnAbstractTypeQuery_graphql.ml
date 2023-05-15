(* @sourceLoc Test_nodeInterface.re *)
(* @generated *)
[%%bs.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type response_node_Group = {
    __typename: [ | `Group] [@live];
    name: string option;
  }
  and response_node_User = {
    __typename: [ | `User] [@live];
    firstName: string option;
  }
  and response_node = [
    | `Group of response_node_Group
    | `User of response_node_User
    | `UnselectedUnionMember of string
  ]

  type response = {
    node: response_node option;
  }
  type rawResponse = response
  type variables = unit
  type refetchVariables = unit
  let makeRefetchVariables () = ()
end

let unwrap_response_node: < __typename: string > Js.t -> [
  | `Group of Types.response_node_Group
  | `User of Types.response_node_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_response_node: [
  | `Group of Types.response_node_Group
  | `User of Types.response_node_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%bs.obj { __typename = v }]
module Internal = struct
  let variablesConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%bs.raw 
    {json|{}|json}
  ]
  let variablesConverterMap = ()
  let convertVariables v = Melange_relay.convertObj v 
    variablesConverter 
    variablesConverterMap 
    Js.undefined
    type wrapResponseRaw
  let wrapResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%bs.raw 
    {json|{"__root":{"node":{"u":"response_node"}}}|json}
  ]
  let wrapResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "response_node" (Obj.magic wrap_response_node : unit);
  o
  let convertWrapResponse v = Melange_relay.convertObj v 
    wrapResponseConverter 
    wrapResponseConverterMap 
    Js.null
    type responseRaw
  let responseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%bs.raw 
    {json|{"__root":{"node":{"u":"response_node"}}}|json}
  ]
  let responseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "response_node" (Obj.magic unwrap_response_node : unit);
  o
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
  external makeVariables: unit -> unit = "" [@@bs.obj]
end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.queryNode


let node: operationType = [%bs.raw {json| (function(){
var v0 = [
  {
    "kind": "Literal",
    "name": "id",
    "value": "123"
  }
],
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v2 = {
  "kind": "InlineFragment",
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "firstName",
      "storageKey": null
    }
  ],
  "type": "User",
  "abstractKey": null
},
v3 = {
  "kind": "InlineFragment",
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "name",
      "storageKey": null
    }
  ],
  "type": "Group",
  "abstractKey": null
};
return {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "TestNodeInterfaceOnAbstractTypeQuery",
    "selections": [
      {
        "alias": null,
        "args": (v0/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v1/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v1/*: any*/),
              (v2/*: any*/),
              (v3/*: any*/)
            ],
            "type": "Member",
            "abstractKey": "__isMember"
          }
        ],
        "storageKey": "node(id:\"123\")"
      }
    ],
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [],
    "kind": "Operation",
    "name": "TestNodeInterfaceOnAbstractTypeQuery",
    "selections": [
      {
        "alias": null,
        "args": (v0/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v1/*: any*/),
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "id",
            "storageKey": null
          },
          {
            "kind": "InlineFragment",
            "selections": [
              (v2/*: any*/),
              (v3/*: any*/)
            ],
            "type": "Member",
            "abstractKey": "__isMember"
          }
        ],
        "storageKey": "node(id:\"123\")"
      }
    ]
  },
  "params": {
    "cacheID": "2b0a77873bd94a6208022409d53b9e5e",
    "id": null,
    "metadata": {},
    "name": "TestNodeInterfaceOnAbstractTypeQuery",
    "operationKind": "query",
    "text": "query TestNodeInterfaceOnAbstractTypeQuery {\n  node(id: \"123\") {\n    __typename\n    ... on Member {\n      __isMember: __typename\n      __typename\n      ... on User {\n        firstName\n      }\n      ... on Group {\n        name\n      }\n    }\n    id\n  }\n}\n"
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
