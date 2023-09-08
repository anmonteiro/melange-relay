(* @sourceLoc Test_localPayload.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment_memberOf_Group_topMember_User = {
    __typename: [ | `User] [@live];
    firstName: string;
  }
  and fragment_memberOf_Group = {
    __typename: [ | `Group] [@live];
    name: string;
    topMember: fragment_memberOf_Group_topMember option;
  }
  and fragment_memberOf_User = {
    __typename: [ | `User] [@live];
    firstName: string;
  }
  and fragment_memberOfSingular_Group = {
    __typename: [ | `Group] [@live];
    name: string;
  }
  and fragment_memberOfSingular_User = {
    __typename: [ | `User] [@live];
    firstName: string;
  }
  and fragment_memberOf_Group_topMember = [
    | `User of fragment_memberOf_Group_topMember_User
    | `UnselectedUnionMember of string
  ]

  and fragment_memberOf = [
    | `Group of fragment_memberOf_Group
    | `User of fragment_memberOf_User
    | `UnselectedUnionMember of string
  ]

  and fragment_memberOfSingular = [
    | `Group of fragment_memberOfSingular_Group
    | `User of fragment_memberOfSingular_User
    | `UnselectedUnionMember of string
  ]

  type fragment = {
    avatarUrl: string option;
    firstName: string;
    memberOf: fragment_memberOf option array option;
    memberOfSingular: fragment_memberOfSingular option;
    onlineStatus: RelaySchemaAssets_graphql.enum_OnlineStatus option;
  }
end

let unwrap_fragment_memberOf_Group_topMember: < __typename: string > Js.t -> [
  | `User of Types.fragment_memberOf_Group_topMember_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_fragment_memberOf_Group_topMember: [
  | `User of Types.fragment_memberOf_Group_topMember_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
let unwrap_fragment_memberOf: < __typename: string > Js.t -> [
  | `Group of Types.fragment_memberOf_Group
  | `User of Types.fragment_memberOf_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_fragment_memberOf: [
  | `Group of Types.fragment_memberOf_Group
  | `User of Types.fragment_memberOf_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
let unwrap_fragment_memberOfSingular: < __typename: string > Js.t -> [
  | `Group of Types.fragment_memberOfSingular_Group
  | `User of Types.fragment_memberOfSingular_User
  | `UnselectedUnionMember of string
] = fun u -> match u##__typename with 
  | "Group" -> `Group (Obj.magic u)
  | "User" -> `User (Obj.magic u)
  | v -> `UnselectedUnionMember v
let wrap_fragment_memberOfSingular: [
  | `Group of Types.fragment_memberOfSingular_Group
  | `User of Types.fragment_memberOfSingular_User
  | `UnselectedUnionMember of string
] -> < __typename: string > Js.t = function 
  | `Group(v) -> Obj.magic v
  | `User(v) -> Obj.magic v
  | `UnselectedUnionMember v -> [%mel.obj { __typename = v }]
module Internal = struct
  type fragmentRaw
  let fragmentConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"memberOf_Group_topMember":{"u":"fragment_memberOf_Group_topMember"},"memberOfSingular":{"u":"fragment_memberOfSingular"},"memberOf":{"u":"fragment_memberOf"}}}|json}
  ]
  let fragmentConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "fragment_memberOf_Group_topMember" (Obj.magic unwrap_fragment_memberOf_Group_topMember : unit);
    Js.Dict.set o "fragment_memberOf" (Obj.magic unwrap_fragment_memberOf : unit);
    Js.Dict.set o "fragment_memberOfSingular" (Obj.magic unwrap_fragment_memberOfSingular : unit);
  o
  let convertFragment v = Melange_relay.convertObj v 
    fragmentConverter 
    fragmentConverterMap 
    Js.undefined
  end

type t
type fragmentRef
external getFragmentRef:
  [> | `TestLocalPayload_user] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

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
  end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.fragmentNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "firstName",
  "storageKey": null
},
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "name",
  "storageKey": null
},
v3 = {
  "kind": "InlineFragment",
  "selections": [
    (v0/*: any*/)
  ],
  "type": "User",
  "abstractKey": null
};
return {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "TestLocalPayload_user",
  "selections": [
    (v0/*: any*/),
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
        (v1/*: any*/),
        {
          "kind": "InlineFragment",
          "selections": [
            (v2/*: any*/),
            {
              "alias": null,
              "args": null,
              "concreteType": null,
              "kind": "LinkedField",
              "name": "topMember",
              "plural": false,
              "selections": [
                (v1/*: any*/),
                (v3/*: any*/)
              ],
              "storageKey": null
            }
          ],
          "type": "Group",
          "abstractKey": null
        },
        (v3/*: any*/)
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
        (v1/*: any*/),
        {
          "kind": "InlineFragment",
          "selections": [
            (v2/*: any*/)
          ],
          "type": "Group",
          "abstractKey": null
        },
        (v3/*: any*/)
      ],
      "storageKey": null
    }
  ],
  "type": "User",
  "abstractKey": null
};
})() |json}]

