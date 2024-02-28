(* @sourceLoc Test_nullableVariables.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
[%%mel.raw {|

|}]

module Types = struct
  [@@@ocaml.warning "-30"]

  type someInput = RelaySchemaAssets_graphql.input_SomeInput_nullable
  type response_updateUserAvatar_user = {
    avatarUrl: string option;
    someRandomArgField: string option;
  }
  and response_updateUserAvatar = {
    user: response_updateUserAvatar_user option;
  }
  type response = {
    updateUserAvatar: response_updateUserAvatar option;
  }
  type rawResponse = response
  type variables = {
    avatarUrl: string Js.Null.t ;
    someInput: someInput Js.Null.t ;
  }
end

module Internal = struct
  let variablesConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"someInput":{"recursive":{"r":"someInput"},"datetime":{"c":"TestsUtils.Datetime"}},"__root":{"someInput":{"r":"someInput"}}}|json}
  ]
  let variablesConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "TestsUtils.Datetime" (Obj.magic TestsUtils.Datetime.serialize : unit);
  o
  let convertVariables v = Melange_relay.convertObj v 
    variablesConverter 
    variablesConverterMap 
    Js.null
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
  external make_someInput:     ?bool: bool-> 
    ?datetime: TestsUtils.Datetime.t-> 
    ?float: float-> 
    ?int: int-> 
    ?_private: bool-> 
    ?recursive: someInput-> 
    ?str: string-> 
    unit ->
   someInput = "" [@@mel.obj]


  external makeVariables:     ?avatarUrl: string-> 
    ?someInput: someInput-> 
    unit ->
   variables = "" [@@mel.obj]


end

type relayOperationNode
type operationType = relayOperationNode Melange_relay.mutationNode


let node: operationType = [%mel.raw {json| (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "avatarUrl"
  },
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "someInput"
  }
],
v1 = [
  {
    "kind": "Variable",
    "name": "avatarUrl",
    "variableName": "avatarUrl"
  }
],
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "avatarUrl",
  "storageKey": null
},
v3 = {
  "alias": null,
  "args": [
    {
      "kind": "Variable",
      "name": "someInput",
      "variableName": "someInput"
    }
  ],
  "kind": "ScalarField",
  "name": "someRandomArgField",
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "TestNullableVariablesMutation",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": "UpdateUserAvatarPayload",
        "kind": "LinkedField",
        "name": "updateUserAvatar",
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
              (v3/*: any*/)
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
    "name": "TestNullableVariablesMutation",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": "UpdateUserAvatarPayload",
        "kind": "LinkedField",
        "name": "updateUserAvatar",
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
                "name": "id",
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
    "cacheID": "9a78edc9246d901f0f8b29ef34b53df7",
    "id": null,
    "metadata": {},
    "name": "TestNullableVariablesMutation",
    "operationKind": "mutation",
    "text": "mutation TestNullableVariablesMutation(\n  $avatarUrl: String\n  $someInput: SomeInput\n) {\n  updateUserAvatar(avatarUrl: $avatarUrl) {\n    user {\n      avatarUrl\n      someRandomArgField(someInput: $someInput)\n      id\n    }\n  }\n}\n"
  }
};
})() |json}]


