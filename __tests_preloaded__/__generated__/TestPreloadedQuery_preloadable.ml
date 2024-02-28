(* @sourceLoc Test_preloadedQuery.re *)
(* @generated *)
[%%mel.raw "/* @generated */"]
type queryRef = TestPreloadedQuery_graphql.queryRef
module Types = struct
  [@@@ocaml.warning "-30"]

  type inputC = RelaySchemaAssets_graphql.input_InputC
  type variables = {
    status: [
      | `Idle
      | `Offline
      | `Online
    ] option;
  }
end

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
  end
module Utils = struct
  [@@@ocaml.warning "-33"]
  open Types
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
  [%raw {json|{
  "kind": "PreloadableConcreteRequest",
  "params": {
    "id": "43cd03101ac04ecf392bdc41dcefc4c1",
    "metadata": {},
    "name": "TestPreloadedQuery",
    "operationKind": "query",
    "text": null,
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

