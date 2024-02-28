(* @sourceLoc Test_localPayload.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
[%%mel.raw {|

|}]

module Types = struct
  [@@@ocaml.warning "-30"]

  type rawResponse_node_memberOf_Group_topMember_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_node_memberOf_Group = {
    __typename: [ | `Group] [@live];
    __isNode: [ | `Group];
    id: string [@live];
    name: string;
    topMember: rawResponse_node_memberOf_Group_topMember option;
  }
  and rawResponse_node_memberOf_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_node_memberOfSingular_Group = {
    __typename: [ | `Group] [@live];
    __isNode: [ | `Group];
    id: string [@live];
    name: string;
  }
  and rawResponse_node_memberOfSingular_User = {
    __typename: [ | `User] [@live];
    __isNode: [ | `User];
    firstName: string;
    id: string [@live];
  }
  and rawResponse_node_memberOf_Group_topMember = [
    | `User of rawResponse_node_memberOf_Group_topMember_User
    | `UnselectedUnionMember of string
  ]

  and rawResponse_node_memberOf = [
    | `Group of rawResponse_node_memberOf_Group
    | `User of rawResponse_node_memberOf_User
    | `UnselectedUnionMember of string
  ]

  and rawResponse_node_memberOfSingular = [
    | `Group of rawResponse_node_memberOfSingular_Group
    | `User of rawResponse_node_memberOfSingular_User
    | `UnselectedUnionMember of string
  ]

  type response_node = {
    __typename: [ | `User] [@live];
    fragmentRefs: [ | `TestLocalPayload_user] Melange_relay.fragmentRefs;
  }
  and rawResponse_node = {
    __typename: [ | `User] [@live];
    avatarUrl: string option;
    firstName: string;
    id: string [@live];
    memberOf: rawResponse_node_memberOf option array option;
    memberOfSingular: rawResponse_node_memberOfSingular option;
    onlineStatus: [
      | `Idle
      | `Offline
      | `Online
    ] option;
  }
  type response = {
    node: response_node option;
  }
  type rawResponse = {
    node: rawResponse_node option;
  }
  type variables = {
    id: string [@live];
  }
  type refetchVariables = {
    id: string option [@live];
  }
  let makeRefetchVariables 
    ?id 
    ()
  : refetchVariables = {
    id= id
  }

end

let unwrap_rawResponse_node_memberOf_Group_topMember: < __typename: string > Js.t -> [
  | `User of Types.rawResponse_node_memberOf_Group_topMember_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_node_memberOf_Group_topMember: [
  | `User of Types.rawResponse_node_memberOf_Group_topMember_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
let unwrap_rawResponse_node_memberOf: < __typename: string > Js.t -> [
  | `Group of Types.rawResponse_node_memberOf_Group
  | `User of Types.rawResponse_node_memberOf_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_node_memberOf: [
  | `Group of Types.rawResponse_node_memberOf_Group
  | `User of Types.rawResponse_node_memberOf_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
let unwrap_rawResponse_node_memberOfSingular: < __typename: string > Js.t -> [
  | `Group of Types.rawResponse_node_memberOfSingular_Group
  | `User of Types.rawResponse_node_memberOfSingular_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_rawResponse_node_memberOfSingular: [
  | `Group of Types.rawResponse_node_memberOfSingular_Group
  | `User of Types.rawResponse_node_memberOfSingular_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]

type queryRef

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
    {json|{"__root":{"node":{"tnf":"User","f":""}}}|json}
  ]
  let wrapResponseConverterMap = ()
  let convertWrapResponse v = Melange_relay.convertObj v 
    wrapResponseConverter 
    wrapResponseConverterMap 
    Js.null
    type responseRaw
  let responseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"node":{"tnf":"User","f":""}}}|json}
  ]
  let responseConverterMap = ()
  let convertResponse v = Melange_relay.convertObj v 
    responseConverter 
    responseConverterMap 
    Js.undefined
    type wrapRawResponseRaw
  let wrapRawResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"node_memberOf_Group_topMember":{"u":"rawResponse_node_memberOf_Group_topMember"},"node_memberOfSingular":{"u":"rawResponse_node_memberOfSingular"},"node_memberOf":{"u":"rawResponse_node_memberOf"},"node":{"tnf":"User"}}}|json}
  ]
  let wrapRawResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "rawResponse_node_memberOf_Group_topMember" (Obj.magic wrap_rawResponse_node_memberOf_Group_topMember : unit);
    Js.Dict.set o "rawResponse_node_memberOf" (Obj.magic wrap_rawResponse_node_memberOf : unit);
    Js.Dict.set o "rawResponse_node_memberOfSingular" (Obj.magic wrap_rawResponse_node_memberOfSingular : unit);
  o
  let convertWrapRawResponse v = Melange_relay.convertObj v 
    wrapRawResponseConverter 
    wrapRawResponseConverterMap 
    Js.null
    type rawResponseRaw
  let rawResponseConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"node_memberOf_Group_topMember":{"u":"rawResponse_node_memberOf_Group_topMember"},"node_memberOfSingular":{"u":"rawResponse_node_memberOfSingular"},"node_memberOf":{"u":"rawResponse_node_memberOf"},"node":{"tnf":"User"}}}|json}
  ]
  let rawResponseConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "rawResponse_node_memberOf_Group_topMember" (Obj.magic unwrap_rawResponse_node_memberOf_Group_topMember : unit);
    Js.Dict.set o "rawResponse_node_memberOf" (Obj.magic unwrap_rawResponse_node_memberOf : unit);
    Js.Dict.set o "rawResponse_node_memberOfSingular" (Obj.magic unwrap_rawResponse_node_memberOfSingular : unit);
  o
  let convertRawResponse v = Melange_relay.convertObj v 
    rawResponseConverter 
    rawResponseConverterMap 
    Js.undefined
    type 'response rawPreloadToken = {source: 'response Melange_relay.Observable.t Js.Nullable.t}
  external tokenToRaw: queryRef -> Types.response rawPreloadToken = "%identity"
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
    external makeVariables:     id: string-> 
   variables = "" [@@mel.obj]


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.queryNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "id"
  }
],
v1 = [
  {
    "kind": "Variable",
    "name": "id",
    "variableName": "id"
  }
],
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
  "name": "id",
  "storageKey": null
},
v4 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "firstName",
  "storageKey": null
},
v5 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v6 = {
  "kind": "InlineFragment",
  "selections": [
    (v4/*: any*/)
  ],
  "type": "User",
  "abstractKey": null
},
v7 = {
  "kind": "InlineFragment",
  "selections": [
    (v3/*: any*/)
  ],
  "type": "Node",
  "abstractKey": "__isNode"
};
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "TestLocalPayloadViaNodeInterfaceQuery",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              {
                "args": null,
                "kind": "FragmentSpread",
                "name": "TestLocalPayload_user"
              }
            ],
            "type": "User",
            "abstractKey": null
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
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "TestLocalPayloadViaNodeInterfaceQuery",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "node",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          (v3/*: any*/),
          {
            "kind": "InlineFragment",
            "selections": [
              (v4/*: any*/),
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
                      (v5/*: any*/),
                      {
                        "alias": null,
                        "args": null,
                        "concreteType": null,
                        "kind": "LinkedField",
                        "name": "topMember",
                        "plural": false,
                        "selections": [
                          (v2/*: any*/),
                          (v6/*: any*/),
                          (v7/*: any*/)
                        ],
                        "storageKey": null
                      }
                    ],
                    "type": "Group",
                    "abstractKey": null
                  },
                  (v6/*: any*/),
                  (v7/*: any*/)
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
                      (v5/*: any*/)
                    ],
                    "type": "Group",
                    "abstractKey": null
                  },
                  (v6/*: any*/),
                  (v7/*: any*/)
                ],
                "storageKey": null
              }
            ],
            "type": "User",
            "abstractKey": null
          }
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "b9ac102e28a8770beecf8ef2afeb2211",
    "id": null,
    "metadata": {},
    "name": "TestLocalPayloadViaNodeInterfaceQuery",
    "operationKind": "query",
    "text": "query TestLocalPayloadViaNodeInterfaceQuery(\n  $id: ID!\n) {\n  node(id: $id) {\n    __typename\n    ... on User {\n      ...TestLocalPayload_user\n    }\n    id\n  }\n}\n\nfragment TestLocalPayload_user on User {\n  firstName\n  avatarUrl\n  onlineStatus\n  memberOf {\n    __typename\n    ... on Group {\n      name\n      topMember {\n        __typename\n        ... on User {\n          firstName\n        }\n        ... on Node {\n          __isNode: __typename\n          __typename\n          id\n        }\n      }\n    }\n    ... on User {\n      firstName\n    }\n    ... on Node {\n      __isNode: __typename\n      __typename\n      id\n    }\n  }\n  memberOfSingular {\n    __typename\n    ... on Group {\n      name\n    }\n    ... on User {\n      firstName\n    }\n    ... on Node {\n      __isNode: __typename\n      __typename\n      id\n    }\n  }\n}\n"
  }
};
})() |json}]

let (load :
    environment:Melange_relay.Environment.t
    -> variables:Types.variables
    -> ?fetchPolicy:Melange_relay.FetchPolicy.t
    -> ?fetchKey:string
    -> ?networkCacheConfig:Melange_relay.cacheConfig
    -> unit
    -> queryRef)
=
fun ~environment ~variables ?fetchPolicy ?fetchKey ?networkCacheConfig () ->
  Melange_relay.loadQuery
    environment
    node
    (variables |. Internal.convertVariables)
    { fetchKey
    ; fetchPolicy = fetchPolicy |. Melange_relay.FetchPolicy.map
    ; networkCacheConfig
    }

type nonrec 'response rawPreloadToken =
  { source : 'response Melange_relay.Observable.t Js.Nullable.t }

let queryRefToObservable token =
  let raw = token |. Internal.tokenToRaw in
  raw.source |. Js.Nullable.toOption

let queryRefToPromise token =
  Js.Promise.make (fun ~resolve ~reject:_ ->
      match token |. queryRefToObservable with
      | None -> resolve (Error ()) [@u]
      | Some o ->
        let open Melange_relay.Observable in
        let (_ : subscription) =
          o
          |. subscribe
               (makeObserver ~complete:(fun () -> (resolve (Ok ()) [@u])) ())
        in
        ())

