(* @sourceLoc Test_mutation.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
[%%mel.raw {|

|}]

module Types = struct
  [@@@ocaml.warning "-30"]

  type rawResponse_setOnlineStatus_user_memberOf_Group = {
    __typename: [ | `Group] [@live];
    __isNode: [ | `Group];
    id: string [@live];
    name: string;
  }
  and rawResponse_setOnlineStatus_user_memberOf_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_setOnlineStatus_user_memberOf = [
    | `Group of rawResponse_setOnlineStatus_user_memberOf_Group
    | `User of rawResponse_setOnlineStatus_user_memberOf_User
    | `UnselectedUnionMember of string
  ]

  type response_setOnlineStatus_user = {
    fragmentRefs: [ | `TestMutation_user] Melange_relay.fragmentRefs;
  }
  and response_setOnlineStatus = {
    user: response_setOnlineStatus_user option;
  }
  and rawResponse_setOnlineStatus_user = {
    firstName: string;
    id: string [@live];
    lastName: string;
    memberOf: rawResponse_setOnlineStatus_user_memberOf option array option;
    onlineStatus: [
      | `Idle
      | `Offline
      | `Online
    ] option;
  }
  and rawResponse_setOnlineStatus = {
    user: rawResponse_setOnlineStatus_user option;
  }
  type response = {
    setOnlineStatus: response_setOnlineStatus option;
  }
  type rawResponse = {
    setOnlineStatus: rawResponse_setOnlineStatus option;
  }
  type variables = {
    onlineStatus: [
      | `Idle
      | `Offline
      | `Online
    ];
  }
end

let unwrap_rawResponse_setOnlineStatus_user_memberOf: < __typename: string > Js.t -> [
  | `Group of Types.rawResponse_setOnlineStatus_user_memberOf_Group
  | `User of Types.rawResponse_setOnlineStatus_user_memberOf_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_setOnlineStatus_user_memberOf: [
  | `Group of Types.rawResponse_setOnlineStatus_user_memberOf_Group
  | `User of Types.rawResponse_setOnlineStatus_user_memberOf_User
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
    {json|{"__root":{"setOnlineStatus_user":{"f":""}}}|json}
  ]
  let wrapResponseConverterMap = ()
  let convertWrapResponse v = Melange_relay.convertObj v 
    wrapResponseConverter 
    wrapResponseConverterMap 
    Js.null
    type responseRaw
  let responseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"setOnlineStatus_user":{"f":""}}}|json}
  ]
  let responseConverterMap = ()
  let convertResponse v = Melange_relay.convertObj v 
    responseConverter 
    responseConverterMap 
    Js.undefined
    type wrapRawResponseRaw
  let wrapRawResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"setOnlineStatus_user_memberOf":{"u":"rawResponse_setOnlineStatus_user_memberOf"}}}|json}
  ]
  let wrapRawResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "rawResponse_setOnlineStatus_user_memberOf" (Obj.magic wrap_rawResponse_setOnlineStatus_user_memberOf : unit);
  o
  let convertWrapRawResponse v = Melange_relay.convertObj v 
    wrapRawResponseConverter 
    wrapRawResponseConverterMap 
    Js.null
    type rawResponseRaw
  let rawResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"setOnlineStatus_user_memberOf":{"u":"rawResponse_setOnlineStatus_user_memberOf"}}}|json}
  ]
  let rawResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "rawResponse_setOnlineStatus_user_memberOf" (Obj.magic unwrap_rawResponse_setOnlineStatus_user_memberOf : unit);
  o
  let convertRawResponse v = Melange_relay.convertObj v 
    rawResponseConverter 
    rawResponseConverterMap 
    Js.undefined
  end
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
    external makeVariables:     onlineStatus: [
      | `Idle
      | `Offline
      | `Online
    ]-> 
   variables = "" [@@mel.obj]


  external makeOptimisticResponse:     ?setOnlineStatus: rawResponse_setOnlineStatus-> 
    unit ->
   rawResponse = "" [@@mel.obj]


  external make_rawResponse_setOnlineStatus_user_memberOf_Group:     __typename: [ | `Group]-> 
    __isNode: [ | `Group]-> 
    id: string-> 
    name: string-> 
   rawResponse_setOnlineStatus_user_memberOf_Group = "" [@@mel.obj]


  external make_rawResponse_setOnlineStatus_user_memberOf_User:     __typename: [ | `User]-> 
    __isNode: [ | `User]-> 
    firstName: string-> 
    id: string-> 
   rawResponse_setOnlineStatus_user_memberOf_User = "" [@@mel.obj]


  external make_rawResponse_setOnlineStatus_user:     firstName: string-> 
    id: string-> 
    lastName: string-> 
    ?memberOf: rawResponse_setOnlineStatus_user_memberOf option array-> 
    ?onlineStatus: [
      | `Idle
      | `Offline
      | `Online
    ]-> 
    unit ->
   rawResponse_setOnlineStatus_user = "" [@@mel.obj]


  external make_rawResponse_setOnlineStatus:     ?user: rawResponse_setOnlineStatus_user-> 
    unit ->
   rawResponse_setOnlineStatus = "" [@@mel.obj]


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.mutationNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "onlineStatus"
  }
],
v1 = [
  {
    "kind": "Variable",
    "name": "onlineStatus",
    "variableName": "onlineStatus"
  }
],
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v3 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "firstName",
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "TestMutationWithOnlyFragmentSetOnlineStatusMutation",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": "SetOnlineStatusPayload",
        "kind": "LinkedField",
        "name": "setOnlineStatus",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "concreteType": "User",
            "kind": "LinkedField",
            "name": "user",
            "plural": false,
            "selections": [
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "TestMutation_user"
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ],
    "type": "Mutation",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "TestMutationWithOnlyFragmentSetOnlineStatusMutation",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": "SetOnlineStatusPayload",
        "kind": "LinkedField",
        "name": "setOnlineStatus",
        "plural": false,
        "selections": [
          {
            "alias": null,
            "args": null,
            "concreteType": "User",
            "kind": "LinkedField",
            "name": "user",
            "plural": false,
            "selections": [
              (v2/*: any*/),
              (v3/*: any*/),
              {
                "alias": null,
                "args": null,
                "kind": "ScalarField",
                "name": "lastName",
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
                  {
                    "alias": null,
                    "args": null,
                    "kind": "ScalarField",
                    "name": "__typename",
                    "storageKey": null
                  },
                  {
                    "kind": "InlineFragment",
                    "selections": [
                      (v3/*: any*/)
                    ],
                    "type": "User",
                    "abstractKey": null
                  },
                  {
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
                  },
                  {
                    "kind": "InlineFragment",
                    "selections": [
                      (v2/*: any*/)
                    ],
                    "type": "Node",
                    "abstractKey": "__isNode"
                  }
                ],
                "storageKey": null
              }
            ],
            "storageKey": null
          }
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "322a5bb9a0514feff61365f595c40d31",
    "id": null,
    "metadata": {},
    "name": "TestMutationWithOnlyFragmentSetOnlineStatusMutation",
    "operationKind": "mutation",
    "text": "mutation TestMutationWithOnlyFragmentSetOnlineStatusMutation(\n  $onlineStatus: OnlineStatus!\n) {\n  setOnlineStatus(onlineStatus: $onlineStatus) {\n    user {\n      ...TestMutation_user\n      id\n    }\n  }\n}\n\nfragment TestMutation_user on User {\n  id\n  firstName\n  lastName\n  onlineStatus\n  memberOf {\n    __typename\n    ... on User {\n      firstName\n    }\n    ... on Group {\n      name\n    }\n    ... on Node {\n      __isNode: __typename\n      __typename\n      id\n    }\n  }\n}\n"
  }
};
})() |json}]


