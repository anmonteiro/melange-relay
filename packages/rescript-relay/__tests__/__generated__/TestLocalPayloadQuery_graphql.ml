(* @sourceLoc Test_localPayload.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type rawResponse_loggedInUser_memberOf_Group_topMember_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_loggedInUser_memberOf_Group = {
    __typename: [ | `Group] [@live];
    __isNode: [ | `Group];
    id: string [@live];
    name: string;
    topMember: rawResponse_loggedInUser_memberOf_Group_topMember option;
  }
  and rawResponse_loggedInUser_memberOf_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_loggedInUser_memberOfSingular_Group = {
    __typename: [ | `Group] [@live];
    __isNode: [ | `Group];
    id: string [@live];
    name: string;
  }
  and rawResponse_loggedInUser_memberOfSingular_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_loggedInUser_memberOf_Group_topMember = [
    | `User of rawResponse_loggedInUser_memberOf_Group_topMember_User
    | `UnselectedUnionMember of string
  ]

  and rawResponse_loggedInUser_memberOf = [
    | `Group of rawResponse_loggedInUser_memberOf_Group
    | `User of rawResponse_loggedInUser_memberOf_User
    | `UnselectedUnionMember of string
  ]

  and rawResponse_loggedInUser_memberOfSingular = [
    | `Group of rawResponse_loggedInUser_memberOfSingular_Group
    | `User of rawResponse_loggedInUser_memberOfSingular_User
    | `UnselectedUnionMember of string
  ]

  type response_loggedInUser = {
    id: string [@live];
    fragmentRefs: [ | `TestLocalPayload_user] Melange_relay.fragmentRefs;
  }
  and rawResponse_loggedInUser = {
    avatarUrl: string option;
    firstName: string;
    id: string [@live];
    memberOf: rawResponse_loggedInUser_memberOf option array option;
    memberOfSingular: rawResponse_loggedInUser_memberOfSingular option;
    onlineStatus: [
      | `Idle
      | `Offline
      | `Online
    ] option;
  }
  type response = {
    loggedInUser: response_loggedInUser;
  }
  type rawResponse = {
    loggedInUser: rawResponse_loggedInUser;
  }
  type variables = unit
  type refetchVariables = unit
  let makeRefetchVariables () = ()
end

let unwrap_rawResponse_loggedInUser_memberOf_Group_topMember: < __typename: string > Js.t -> [
  | `User of Types.rawResponse_loggedInUser_memberOf_Group_topMember_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_loggedInUser_memberOf_Group_topMember: [
  | `User of Types.rawResponse_loggedInUser_memberOf_Group_topMember_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
let unwrap_rawResponse_loggedInUser_memberOf: < __typename: string > Js.t -> [
  | `Group of Types.rawResponse_loggedInUser_memberOf_Group
  | `User of Types.rawResponse_loggedInUser_memberOf_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_loggedInUser_memberOf: [
  | `Group of Types.rawResponse_loggedInUser_memberOf_Group
  | `User of Types.rawResponse_loggedInUser_memberOf_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
let unwrap_rawResponse_loggedInUser_memberOfSingular: < __typename: string > Js.t -> [
  | `Group of Types.rawResponse_loggedInUser_memberOfSingular_Group
  | `User of Types.rawResponse_loggedInUser_memberOfSingular_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_loggedInUser_memberOfSingular: [
  | `Group of Types.rawResponse_loggedInUser_memberOfSingular_Group
  | `User of Types.rawResponse_loggedInUser_memberOfSingular_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
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
    {json|{"__root":{"loggedInUser":{"f":""}}}|json}
  ]
  let wrapResponseConverterMap = ()
  let convertWrapResponse v = Melange_relay.convertObj v 
    wrapResponseConverter 
    wrapResponseConverterMap 
    Js.null
    type responseRaw
  let responseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"loggedInUser":{"f":""}}}|json}
  ]
  let responseConverterMap = ()
  let convertResponse v = Melange_relay.convertObj v 
    responseConverter 
    responseConverterMap 
    Js.undefined
    type wrapRawResponseRaw
  let wrapRawResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"loggedInUser_memberOf_Group_topMember":{"u":"rawResponse_loggedInUser_memberOf_Group_topMember"},"loggedInUser_memberOfSingular":{"u":"rawResponse_loggedInUser_memberOfSingular"},"loggedInUser_memberOf":{"u":"rawResponse_loggedInUser_memberOf"}}}|json}
  ]
  let wrapRawResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "rawResponse_loggedInUser_memberOf_Group_topMember" (Obj.magic wrap_rawResponse_loggedInUser_memberOf_Group_topMember : unit);
    Js.Dict.set o "rawResponse_loggedInUser_memberOf" (Obj.magic wrap_rawResponse_loggedInUser_memberOf : unit);
    Js.Dict.set o "rawResponse_loggedInUser_memberOfSingular" (Obj.magic wrap_rawResponse_loggedInUser_memberOfSingular : unit);
  o
  let convertWrapRawResponse v = Melange_relay.convertObj v 
    wrapRawResponseConverter 
    wrapRawResponseConverterMap 
    Js.null
    type rawResponseRaw
  let rawResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"loggedInUser_memberOf_Group_topMember":{"u":"rawResponse_loggedInUser_memberOf_Group_topMember"},"loggedInUser_memberOfSingular":{"u":"rawResponse_loggedInUser_memberOfSingular"},"loggedInUser_memberOf":{"u":"rawResponse_loggedInUser_memberOf"}}}|json}
  ]
  let rawResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "rawResponse_loggedInUser_memberOf_Group_topMember" (Obj.magic unwrap_rawResponse_loggedInUser_memberOf_Group_topMember : unit);
    Js.Dict.set o "rawResponse_loggedInUser_memberOf" (Obj.magic unwrap_rawResponse_loggedInUser_memberOf : unit);
    Js.Dict.set o "rawResponse_loggedInUser_memberOfSingular" (Obj.magic unwrap_rawResponse_loggedInUser_memberOfSingular : unit);
  o
  let convertRawResponse v = Melange_relay.convertObj v 
    rawResponseConverter 
    rawResponseConverterMap 
    Js.undefined
  end

type queryRef

module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types
  external onlineStatus_toString: RelaySchemaAssets_graphql.enum_OnlineStatus -> string = "%identity"
  external onlineStatus_input_toString: RelaySchemaAssets_graphql.enum_OnlineStatus_input -> string = "%identity"
  let onlineStatus_decode (enum: RelaySchemaAssets_graphql.enum_OnlineStatus): RelaySchemaAssets_graphql.enum_OnlineStatus_input option =
    (match enum with
      | #RelaySchemaAssets_graphql.enum_OnlineStatus_input as valid -> Some(valid)
      | _ -> None
    )
    let onlineStatus_fromString (str: string): RelaySchemaAssets_graphql.enum_OnlineStatus_input option =
    onlineStatus_decode (Obj.magic str)
    external makeVariables: unit -> unit = "" [@@mel.obj]
end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.queryNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "firstName",
  "storageKey": null
},
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v3 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v4 = {
  "kind": "InlineFragment",
  "selections": [
    (v1/*: any*/)
  ],
  "type": "User",
  "abstractKey": null
},
v5 = {
  "kind": "InlineFragment",
  "selections": [
    (v0/*: any*/)
  ],
  "type": "Node",
  "abstractKey": "__isNode"
};
return {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "TestLocalPayloadQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "User",
        "kind": "LinkedField",
        "name": "loggedInUser",
        "plural": false,
        "selections": [
          (v0/*: any*/),
          {
            "args": null,
            "kind": "FragmentSpread",
            "name": "TestLocalPayload_user"
          }
        ],
        "storageKey": null
      }
    ],
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [],
    "kind": "Operation",
    "name": "TestLocalPayloadQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "User",
        "kind": "LinkedField",
        "name": "loggedInUser",
        "plural": false,
        "selections": [
          (v0/*: any*/),
          (v1/*: any*/),
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "avatarUrl",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "onlineStatus",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "concreteType": null,
            "kind": "LinkedField",
            "name": "memberOf",
            "plural": true,
            "selections": [
              (v2/*: any*/),
              {
                "kind": "InlineFragment",
                "selections": [
                  (v3/*: any*/),
                  {
                    "alias": null,
                    "args": null,
                    "concreteType": null,
                    "kind": "LinkedField",
                    "name": "topMember",
                    "plural": false,
                    "selections": [
                      (v2/*: any*/),
                      (v4/*: any*/),
                      (v5/*: any*/)
                    ],
                    "storageKey": null
                  }
                ],
                "type": "Group",
                "abstractKey": null
              },
              (v4/*: any*/),
              (v5/*: any*/)
            ],
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "concreteType": null,
            "kind": "LinkedField",
            "name": "memberOfSingular",
            "plural": false,
            "selections": [
              (v2/*: any*/),
              {
                "kind": "InlineFragment",
                "selections": [
                  (v3/*: any*/)
                ],
                "type": "Group",
                "abstractKey": null
              },
              (v4/*: any*/),
              (v5/*: any*/)
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "077471b46af8ca6532731e3e3f851365",
    "id": null,
    "metadata": {},
    "name": "TestLocalPayloadQuery",
    "operationKind": "query",
    "text": "query TestLocalPayloadQuery {\n  loggedInUser {\n    id\n    ...TestLocalPayload_user\n  }\n}\n\nfragment TestLocalPayload_user on User {\n  firstName\n  avatarUrl\n  onlineStatus\n  memberOf {\n    __typename\n    ... on Group {\n      name\n      topMember {\n        __typename\n        ... on User {\n          firstName\n        }\n        ... on Node {\n          __isNode: __typename\n          __typename\n          id\n        }\n      }\n    }\n    ... on User {\n      firstName\n    }\n    ... on Node {\n      __isNode: __typename\n      __typename\n      id\n    }\n  }\n  memberOfSingular {\n    __typename\n    ... on Group {\n      name\n    }\n    ... on User {\n      firstName\n    }\n    ... on Node {\n      __isNode: __typename\n      __typename\n      id\n    }\n  }\n}\n"
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
