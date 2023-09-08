(* @sourceLoc Test_fragment.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment = {
    __id: Melange_relay.dataId [@live];
    firstName: string;
    onlineStatus: RelaySchemaAssets_graphql.enum_OnlineStatus option;
    fragmentRefs: [ | `TestFragment_sub_user] Melange_relay.fragmentRefs;
  }
end

module Internal = struct
  type fragmentRaw
  let fragmentConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"__root":{"":{"f":""}}}|json}
  ]
  let fragmentConverterMap = ()
  let convertFragment v = Melange_relay.convertObj v 
    fragmentConverter 
    fragmentConverterMap 
    Js.undefined
  end

type t
type fragmentRef
external getFragmentRef:
  [> | `TestFragment_user] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

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


let node: operationType = [%mel.raw {json| {
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "TestFragment_user",
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "firstName",
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
      "args": null,
      "kind": "FragmentSpread",
      "name": "TestFragment_sub_user"
    },
    {
      "kind": "ClientExtension",
      "selections": [
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "__id",
          "storageKey": null
        }
      ]
    }
  ],
  "type": "User",
  "abstractKey": null
} |json}]

