(* @sourceLoc Test_connections.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
[%%mel.raw {|

|}]

module Types = struct
  [@@@ocaml.warning "-30"]

  type response_addFriend_addedFriend = {
    id: string [@live];
  }
  and response_addFriend = {
    addedFriend: response_addFriend_addedFriend option;
  }
  type response = {
    addFriend: response_addFriend option;
  }
  type rawResponse = response
  type variables = {
    connections: Melange_relay.dataId array;
    friendId: string;
  }
end

module Internal = struct
  let variablesConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{}|json}
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
module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types
  external makeVariables:     connections: Melange_relay.dataId array-> 
    friendId: string-> 
   variables = "" [@@mel.obj]


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.mutationNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "connections"
},
v1 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "friendId"
},
v2 = [
  {
    "kind": "Variable",
    "name": "friendId",
    "variableName": "friendId"
  }
],
v3 = {
  "alias": null,
  "args": null,
  "concreteType": "User",
  "kind": "LinkedField",
  "name": "addedFriend",
  "plural": false,
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "id",
      "storageKey": null
    }
  ],
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/),
      (v1/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "TestConnections_AddFriendMutation",
    "selections": [
      {
        "alias": null,
        "args": (v2/*: any*/),
        "concreteType": "AddFriendPayload",
        "kind": "LinkedField",
        "name": "addFriend",
        "plural": false,
        "selections": [
          (v3/*: any*/)
        ],
        "storageKey": null
      }
    ],
    "type": "Mutation",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v1/*: any*/),
      (v0/*: any*/)
    ],
    "kind": "Operation",
    "name": "TestConnections_AddFriendMutation",
    "selections": [
      {
        "alias": null,
        "args": (v2/*: any*/),
        "concreteType": "AddFriendPayload",
        "kind": "LinkedField",
        "name": "addFriend",
        "plural": false,
        "selections": [
          (v3/*: any*/),
          {
            "alias": null,
            "args": null,
            "filters": null,
            "handle": "appendNode",
            "key": "",
            "kind": "LinkedHandle",
            "name": "addedFriend",
            "handleArgs": [
              {
                "kind": "Variable",
                "name": "connections",
                "variableName": "connections"
              },
              {
                "kind": "Literal",
                "name": "edgeTypeName",
                "value": "UserEdge"
              }
            ]
          }
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "24b9201349e60cd6ca9e4e52bd034613",
    "id": null,
    "metadata": {},
    "name": "TestConnections_AddFriendMutation",
    "operationKind": "mutation",
    "text": "mutation TestConnections_AddFriendMutation(\n  $friendId: ID!\n) {\n  addFriend(friendId: $friendId) {\n    addedFriend {\n      id\n    }\n  }\n}\n"
  }
};
})() |json}]


