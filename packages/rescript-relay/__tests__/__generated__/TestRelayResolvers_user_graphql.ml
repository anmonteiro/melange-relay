(* @sourceLoc Test_relayResolvers.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment = {
    fullName: TestRelayUserResolver.t option;
    isOnline: bool option;
  }
end

module Internal = struct
  type fragmentRaw
  let fragmentConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{}|json}
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
  [> | `TestRelayResolvers_user] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types
end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.fragmentNode


[%%private let makeNode rescript_module_TestRelayUserResolver: operationType = 
  ignore rescript_module_TestRelayUserResolver;
  [%raw {json|{
  "argumentDefinitions": [],
  "kind": "Fragment",
  "metadata": null,
  "name": "TestRelayResolvers_user",
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "isOnline",
      "storageKey": null
    },
    {
      "alias": null,
      "args": null,
      "fragment": {
        "args": null,
        "kind": "FragmentSpread",
        "name": "TestRelayUserResolver"
      },
      "kind": "RelayResolver",
      "name": "fullName",
      "resolverModule": rescript_module_TestRelayUserResolver,
      "path": "fullName"
    }
  ],
  "type": "User",
  "abstractKey": null
}|json}]
]
let node: operationType = makeNode TestRelayUserResolver.default

