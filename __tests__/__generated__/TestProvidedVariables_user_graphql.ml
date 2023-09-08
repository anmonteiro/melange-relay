(* @sourceLoc Test_providedVariables.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
module Types = struct
  [@@@ocaml.warning "-30"]

  type fragment = {
    someRandomArgField: string option;
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
  [> | `TestProvidedVariables_user] Melange_relay.fragmentRefs -> fragmentRef = "%identity"

module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types
end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.fragmentNode


let node: operationType = [%mel.raw {json| {
  "argumentDefinitions": [
    {
      "kind": "RootArgument",
      "name": "__relay_internal__pv__ProvidedVariablesBool"
    },
    {
      "kind": "RootArgument",
      "name": "__relay_internal__pv__ProvidedVariablesInputC"
    },
    {
      "kind": "RootArgument",
      "name": "__relay_internal__pv__ProvidedVariablesInputCArr"
    },
    {
      "kind": "RootArgument",
      "name": "__relay_internal__pv__ProvidedVariablesIntStr"
    }
  ],
  "kind": "Fragment",
  "metadata": null,
  "name": "TestProvidedVariables_user",
  "selections": [
    {
      "alias": null,
      "args": [
        {
          "kind": "Variable",
          "name": "bool",
          "variableName": "__relay_internal__pv__ProvidedVariablesBool"
        },
        {
          "kind": "Variable",
          "name": "inputC",
          "variableName": "__relay_internal__pv__ProvidedVariablesInputC"
        },
        {
          "kind": "Variable",
          "name": "inputCArr",
          "variableName": "__relay_internal__pv__ProvidedVariablesInputCArr"
        },
        {
          "kind": "Variable",
          "name": "intStr",
          "variableName": "__relay_internal__pv__ProvidedVariablesIntStr"
        }
      ],
      "kind": "ScalarField",
      "name": "someRandomArgField",
      "storageKey": null
    }
  ],
  "type": "User",
  "abstractKey": null
} |json}]

