(* @sourceLoc Test_preloadedQuery.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
[%%mel.raw {|

// @relayRequestID 43cd03101ac04ecf392bdc41dcefc4c1

|}]

module Types = struct
  [@@@ocaml.warning "-30"]

  type inputC = RelaySchemaAssets_graphql.input_InputC
  type response_loggedInUser = {
    fragmentRefs: [ | `TestPreloadedQueryProvidedVariables_user] Melange_relay.fragmentRefs;
  }
  and response_users_edges_node = {
    firstName: string;
    id: string [@live];
    onlineStatus: RelaySchemaAssets_graphql.enum_OnlineStatus option;
  }
  and response_users_edges = {
    node: response_users_edges_node option;
  }
  and response_users = {
    edges: response_users_edges option array option;
  }
  type response = {
    loggedInUser: response_loggedInUser;
    users: response_users option;
  }
  type rawResponse = response
  type variables = {
    status: [
      | `Idle
      | `Offline
      | `Online
    ] option;
  }
  type refetchVariables = {
    status: [
      | `Idle
      | `Offline
      | `Online
    ] option option;
  }
  let makeRefetchVariables 
    ?status 
    ()
  : refetchVariables = {
    status= status
  }

end


type queryRef

module Internal = struct
  let variablesConverter: string Js.Dict.t Js.Dict.t Js.Dict.t = [%mel.raw 
    {json|{"inputC":{"recursiveC":{"r":"inputC"},"intStr":{"c":"TestsUtils.IntString"}},"__root":{"__relay_internal__pv__ProvidedVariablesIntStr":{"c":"TestsUtils.IntString"},"__relay_internal__pv__ProvidedVariablesInputCArr":{"r":"inputC"},"__relay_internal__pv__ProvidedVariablesInputC":{"r":"inputC"}}}|json}
  ]
  let variablesConverterMap = let o = Js.Dict.empty () in 
    Js.Dict.set o "TestsUtils.IntString" (Obj.magic TestsUtils.IntString.serialize : unit);
  o
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
    type wrapRawResponseRaw = wrapResponseRaw
  let convertWrapRawResponse = convertWrapResponse
  type rawResponseRaw = responseRaw
  let convertRawResponse = convertResponse
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
    external make_inputC:     intStr: TestsUtils.IntString.t-> 
    ?recursiveC: inputC-> 
    unit ->
   inputC = "" [@@mel.obj]


  external makeVariables:     ?status: [
      | `Idle
      | `Offline
      | `Online
    ]-> 
    unit ->
   variables = "" [@@mel.obj]


end
type 't providedVariable = { providedVariable: unit -> 't; get: unit -> 't }
type providedVariablesType = {
  __relay_internal__pv__ProvidedVariablesBool: bool providedVariable;
  __relay_internal__pv__ProvidedVariablesInputC: RelaySchemaAssets_graphql.input_InputC providedVariable;
  __relay_internal__pv__ProvidedVariablesInputCArr: RelaySchemaAssets_graphql.input_InputC array option providedVariable;
  __relay_internal__pv__ProvidedVariablesIntStr: TestsUtils.IntString.t providedVariable;
}
let providedVariablesDefinition: providedVariablesType = {
  __relay_internal__pv__ProvidedVariablesBool = {
    providedVariable = ProvidedVariables.Bool.get;
    get = ProvidedVariables.Bool.get;
  };
  __relay_internal__pv__ProvidedVariablesInputC = {
    providedVariable = ProvidedVariables.InputC.get;
    get = (fun () -> Internal.convertVariables (Js.Dict.fromArray [|("__relay_internal__pv__ProvidedVariablesInputC", ProvidedVariables.InputC.get())|]) |. Js.Dict.unsafeGet "__relay_internal__pv__ProvidedVariablesInputC");
  };
  __relay_internal__pv__ProvidedVariablesInputCArr = {
    providedVariable = ProvidedVariables.InputCArr.get;
    get = (fun () -> Internal.convertVariables (Js.Dict.fromArray [|("__relay_internal__pv__ProvidedVariablesInputCArr", ProvidedVariables.InputCArr.get())|]) |. Js.Dict.unsafeGet "__relay_internal__pv__ProvidedVariablesInputCArr");
  };
  __relay_internal__pv__ProvidedVariablesIntStr = {
    providedVariable = ProvidedVariables.IntStr.get;
    get = (fun () -> Internal.convertVariables (Js.Dict.fromArray [|("__relay_internal__pv__ProvidedVariablesIntStr", ProvidedVariables.IntStr.get())|]) |. Js.Dict.unsafeGet "__relay_internal__pv__ProvidedVariablesIntStr");
  };
}

type relayOperationNode
type operationType = relayOperationNode Melange_relay.queryNode


[%%private let makeNode providedVariablesDefinition: operationType = 
  ignore providedVariablesDefinition;
  [%raw {json|(function(){
var v0 = {
  "defaultValue": null,
  "kind": "LocalArgument",
  "name": "status"
},
v1 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "id",
  "storageKey": null
},
v2 = {
  "alias": null,
  "args": [
    {
      "kind": "Variable",
      "name": "status",
      "variableName": "status"
    }
  ],
  "concreteType": "UserConnection",
  "kind": "LinkedField",
  "name": "users",
  "plural": false,
  "selections": [
    {
      "alias": null,
      "args": null,
      "concreteType": "UserEdge",
      "kind": "LinkedField",
      "name": "edges",
      "plural": true,
      "selections": [
        {
          "alias": null,
          "args": null,
          "concreteType": "User",
          "kind": "LinkedField",
          "name": "node",
          "plural": false,
          "selections": [
            (v1/*: any*/),
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
            }
          ],
          "storageKey": null
        }
      ],
      "storageKey": null
    }
  ],
  "storageKey": null
};
return {
  "fragment": {
    "argumentDefinitions": [
      (v0/*: any*/)
    ],
    "kind": "Fragment",
    "metadata": null,
    "name": "TestPreloadedQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "User",
        "kind": "LinkedField",
        "name": "loggedInUser",
        "plural": false,
        "selections": [
          {
            "args": null,
            "kind": "FragmentSpread",
            "name": "TestPreloadedQueryProvidedVariables_user"
          }
        ],
        "storageKey": null
      },
      (v2/*: any*/)
    ],
    "type": "Query",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [
      (v0/*: any*/),
      {
        "defaultValue": null,
        "kind": "LocalArgument",
        "name": "__relay_internal__pv__ProvidedVariablesBool"
      },
      {
        "defaultValue": null,
        "kind": "LocalArgument",
        "name": "__relay_internal__pv__ProvidedVariablesInputC"
      },
      {
        "defaultValue": null,
        "kind": "LocalArgument",
        "name": "__relay_internal__pv__ProvidedVariablesInputCArr"
      },
      {
        "defaultValue": null,
        "kind": "LocalArgument",
        "name": "__relay_internal__pv__ProvidedVariablesIntStr"
      }
    ],
    "kind": "Operation",
    "name": "TestPreloadedQuery",
    "selections": [
      {
        "alias": null,
        "args": null,
        "concreteType": "User",
        "kind": "LinkedField",
        "name": "loggedInUser",
        "plural": false,
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
          },
          (v1/*: any*/)
        ],
        "storageKey": null
      },
      (v2/*: any*/)
    ]
  },
  "params": {
    "id": "43cd03101ac04ecf392bdc41dcefc4c1",
    "metadata": {},
    "name": "TestPreloadedQuery",
    "operationKind": "query",
    "text": null,
    "providedVariables": providedVariablesDefinition
  }
};
})()|json}]
]
let node: operationType = makeNode providedVariablesDefinition


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

type operationId
type operationTypeParams = {id: operationId}
external getOperationTypeParams: operationType -> operationTypeParams = "params" [@@mel.get]
external setPreloadQuery: operationType -> operationId -> unit = "set" [@@mel.module "relay-runtime"] [@@mel.scope "PreloadableQueryRegistry"]

 let () = (getOperationTypeParams node).id |> setPreloadQuery node
