(* @sourceLoc Test_providedVariables.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
[%%mel.raw {|

|}]

module Types = struct
  [@@@ocaml.warning "-30"]

  type inputC = RelaySchemaAssets_graphql.input_InputC
  type response_loggedInUser = {
    fragmentRefs: [ | `TestProvidedVariables_user] Melange_relay.fragmentRefs;
  }
  type response = {
    loggedInUser: response_loggedInUser;
  }
  type rawResponse = response
  type variables = unit
  type refetchVariables = unit
  let makeRefetchVariables () = ()
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
  external make_inputC:     intStr: TestsUtils.IntString.t-> 
    ?recursiveC: inputC-> 
    unit ->
   inputC = "" [@@mel.obj]


  external makeVariables: unit -> unit = "" [@@mel.obj]
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
  [%raw {json|{
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "TestProvidedVariablesQuery",
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
            "name": "TestProvidedVariables_user"
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
    "argumentDefinitions": [
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
    "name": "TestProvidedVariablesQuery",
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
    ]
  },
  "params": {
    "cacheID": "44f81e585858d9dcb82052f9c1ab2aac",
    "id": null,
    "metadata": {},
    "name": "TestProvidedVariablesQuery",
    "operationKind": "query",
    "text": "query TestProvidedVariablesQuery(\n  $__relay_internal__pv__ProvidedVariablesBool: Boolean!\n  $__relay_internal__pv__ProvidedVariablesInputC: InputC!\n  $__relay_internal__pv__ProvidedVariablesInputCArr: [InputC!]\n  $__relay_internal__pv__ProvidedVariablesIntStr: IntString!\n) {\n  loggedInUser {\n    ...TestProvidedVariables_user\n    id\n  }\n}\n\nfragment TestProvidedVariables_user on User {\n  someRandomArgField(bool: $__relay_internal__pv__ProvidedVariablesBool, inputC: $__relay_internal__pv__ProvidedVariablesInputC, inputCArr: $__relay_internal__pv__ProvidedVariablesInputCArr, intStr: $__relay_internal__pv__ProvidedVariablesIntStr)\n}\n",
    "providedVariables": providedVariablesDefinition
  }
}|json}]
]
let node: operationType = makeNode providedVariablesDefinition

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

