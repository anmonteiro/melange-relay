(* @sourceLoc Test_customScalars.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type response_member_User = {
    __typename: [ | `User] [@live];
    createdAt: TestsUtils.Datetime.t;
  }
  and response_member = [
    | `User of response_member_User
    | `UnselectedUnionMember of string
  ]

  type response_loggedInUser_friends = {
    createdAt: TestsUtils.Datetime.t;
  }
  and response_loggedInUser = {
    createdAt: TestsUtils.Datetime.t;
    friends: response_loggedInUser_friends array;
  }
  type response = {
    loggedInUser: response_loggedInUser;
    member: response_member option;
  }
  type rawResponse = response
  type variables = {
    beforeDate: TestsUtils.Datetime.t option;
    number: TestsUtils.Number.t;
  }
  type refetchVariables = {
    beforeDate: TestsUtils.Datetime.t option option;
    number: TestsUtils.Number.t option;
  }
  let makeRefetchVariables 
    ?beforeDate 
    ?number 
    ()
  : refetchVariables = {
    beforeDate= beforeDate;
    number= number
  }

end

let unwrap_response_member: < __typename: string > Js.t -> [
  | `User of Types.response_member_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_response_member: [
  | `User of Types.response_member_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
module Internal = struct
  let variablesConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"number":{"c":"TestsUtils.Number"},"beforeDate":{"c":"TestsUtils.Datetime"}}}|json}
  ]
  let variablesConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "TestsUtils.Datetime" (Obj.magic TestsUtils.Datetime.serialize : unit);
    Js.Dict.set o "TestsUtils.Number" (Obj.magic TestsUtils.Number.serialize : unit);
  o
  let convertVariables v = Melange_relay.convertObj v 
    variablesConverter 
    variablesConverterMap 
    Js.undefined
    type wrapResponseRaw
  let wrapResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"member_User_createdAt":{"c":"TestsUtils.Datetime"},"member":{"u":"response_member"},"loggedInUser_friends_createdAt":{"c":"TestsUtils.Datetime"},"loggedInUser_createdAt":{"c":"TestsUtils.Datetime"}}}|json}
  ]
  let wrapResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "TestsUtils.Datetime" (Obj.magic TestsUtils.Datetime.serialize : unit);
    Js.Dict.set o "response_member" (Obj.magic wrap_response_member : unit);
  o
  let convertWrapResponse v = Melange_relay.convertObj v 
    wrapResponseConverter 
    wrapResponseConverterMap 
    Js.null
    type responseRaw
  let responseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"member_User_createdAt":{"c":"TestsUtils.Datetime"},"member":{"u":"response_member"},"loggedInUser_friends_createdAt":{"c":"TestsUtils.Datetime"},"loggedInUser_createdAt":{"c":"TestsUtils.Datetime"}}}|json}
  ]
  let responseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "TestsUtils.Datetime" (Obj.magic TestsUtils.Datetime.parse : unit);
    Js.Dict.set o "response_member" (Obj.magic unwrap_response_member : unit);
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
  external makeVariables:     ?beforeDate: TestsUtils.Datetime.t-> 
    number: TestsUtils.Number.t-> 
    unit ->
   variables = "" [@@mel.obj]


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.queryNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "beforeDate"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "number"
  }
],
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "createdAt",
  "storageKey": null
},
v2 = [
  {
    "kind": "Variable",
    "name": "beforeDate",
    "variableName": "beforeDate"
  },
  {
    "kind": "Variable",
    "name": "number",
    "variableName": "number"
  }
],
v3 = [
  (v1/*: any*/)
],
v4 = [
  {
    "kind": "Literal",
    "name": "id",
    "value": "user-1"
  }
],
v5 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v6 = {
  "kind": "InlineFragment",
  "selections": (v3/*: any*/),
  "type": "User",
  "abstractKey": null
},
v7 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "TestCustomScalarsQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "User",
        "kind": "LinkedField",
        "name": "loggedInUser",
        "plural": false,
        "selections": [
          (v1/*: any*/),
          {
            "alias": null,
            "args": (v2/*: any*/),
            "concreteType": "User",
            "kind": "LinkedField",
            "name": "friends",
            "plural": true,
            "selections": (v3/*: any*/),
            "storageKey": null
          }
        ],
        "storageKey": null
      },
      {
        "alias": null,
        "args": (v4/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "member",
        "plural": false,
        "selections": [
          (v5/*: any*/),
          (v6/*: any*/)
        ],
        "storageKey": "member(id:\"user-1\")"
      }
    ],
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "TestCustomScalarsQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "User",
        "kind": "LinkedField",
        "name": "loggedInUser",
        "plural": false,
        "selections": [
          (v1/*: any*/),
          {
            "alias": null,
            "args": (v2/*: any*/),
            "concreteType": "User",
            "kind": "LinkedField",
            "name": "friends",
            "plural": true,
            "selections": [
              (v1/*: any*/),
              (v7/*: any*/)
            ],
            "storageKey": null
          },
          (v7/*: any*/)
        ],
        "storageKey": null
      },
      {
        "alias": null,
        "args": (v4/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "member",
        "plural": false,
        "selections": [
          (v5/*: any*/),
          (v6/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v7/*: any*/)
            ],
            "type": "Node",
            "abstractKey": "__isNode"
          }
        ],
        "storageKey": "member(id:\"user-1\")"
      }
    ]
  },
  "params": {
    "cacheID": "eb6fcc1cdc3534d168fa96d31831a59d",
    "id": null,
    "metadata": {},
    "name": "TestCustomScalarsQuery",
    "operationKind": "query",
    "text": "query TestCustomScalarsQuery(\n  $beforeDate: Datetime\n  $number: Number!\n) {\n  loggedInUser {\n    createdAt\n    friends(beforeDate: $beforeDate, number: $number) {\n      createdAt\n      id\n    }\n    id\n  }\n  member(id: \"user-1\") {\n    __typename\n    ... on User {\n      createdAt\n    }\n    ... on Node {\n      __isNode: __typename\n      __typename\n      id\n    }\n  }\n}\n"
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
