(* @generated *)
[@@@ocaml.warning "-30"]


type enum_OnlineStatus = private [>
  | `Online
  | `Idle
  | `Offline
]


type enum_OnlineStatus_input = [
  | `Online
  | `Idle
  | `Offline
]


type enum_RequiredFieldAction = private [>
  | `NONE
  | `LOG
  | `THROW
]


type enum_RequiredFieldAction_input = [
  | `NONE
  | `LOG
  | `THROW
]


type  input_InputA = {
  time: TestsUtils.Datetime.t;
  recursiveA: input_InputA option;
  usingB: input_InputB option;
}

and input_InputA_nullable = {
  time: TestsUtils.Datetime.t;
  recursiveA: input_InputA_nullable Js.Null.t option [@mel.optional];
  usingB: input_InputB_nullable Js.Null.t option [@mel.optional];
}

and input_InputB = {
  time: TestsUtils.Datetime.t option;
  usingA: input_InputA option;
  constraint_: bool option [@mel.as "constraint"];
}

and input_InputB_nullable = {
  time: TestsUtils.Datetime.t Js.Null.t option [@mel.optional];
  usingA: input_InputA_nullable Js.Null.t option [@mel.optional];
  constraint_: bool Js.Null.t option [@mel.optional] [@mel.as "constraint"];
}

and input_InputC = {
  intStr: TestsUtils.IntString.t;
  recursiveC: input_InputC option;
}

and input_InputC_nullable = {
  intStr: TestsUtils.IntString.t;
  recursiveC: input_InputC_nullable Js.Null.t option [@mel.optional];
}

and input_SomeInput = {
  str: string option;
  bool: bool option;
  float: float option;
  int: int option;
  datetime: TestsUtils.Datetime.t option;
  recursive: input_SomeInput option;
  private_: bool option [@mel.as "private"];
}

and input_SomeInput_nullable = {
  str: string Js.Null.t option [@mel.optional];
  bool: bool Js.Null.t option [@mel.optional];
  float: float Js.Null.t option [@mel.optional];
  int: int Js.Null.t option [@mel.optional];
  datetime: TestsUtils.Datetime.t Js.Null.t option [@mel.optional];
  recursive: input_SomeInput_nullable Js.Null.t option [@mel.optional];
  private_: bool Js.Null.t option [@mel.optional] [@mel.as "private"];
}

and input_RecursiveSetOnlineStatusInput = {
  someValue: TestsUtils.IntString.t;
  setOnlineStatus: input_SetOnlineStatusInput option;
}

and input_RecursiveSetOnlineStatusInput_nullable = {
  someValue: TestsUtils.IntString.t;
  setOnlineStatus: input_SetOnlineStatusInput_nullable Js.Null.t option [@mel.optional];
}

and input_SetOnlineStatusInput = {
  onlineStatus: [`Online | `Idle | `Offline];
  someJsonValue: Js.Json.t;
  recursed: input_RecursiveSetOnlineStatusInput option;
}

and input_SetOnlineStatusInput_nullable = {
  onlineStatus: [`Online | `Idle | `Offline];
  someJsonValue: Js.Json.t;
  recursed: input_RecursiveSetOnlineStatusInput_nullable Js.Null.t option [@mel.optional];
}

and input_SearchInput = {
  names: string option array option;
  id: int;
  someOtherId: float option;
}

and input_SearchInput_nullable = {
  names: string Js.Null.t array Js.Null.t option [@mel.optional];
  id: int;
  someOtherId: float Js.Null.t option [@mel.optional];
}

and input_PesticideListSearchInput = {
  companyName: string array option;
  pesticideIds: int array option;
  skip: int;
  take: int;
}

and input_PesticideListSearchInput_nullable = {
  companyName: string array Js.Null.t option [@mel.optional];
  pesticideIds: int array Js.Null.t option [@mel.optional];
  skip: int;
  take: int;
}
 [@@deriving jsProperties, getSet]
external make_InputA: 
  time: TestsUtils.Datetime.t -> 
  ?recursiveA: input_InputA -> 
  ?usingB: input_InputB -> 
  unit ->
 input_InputA = "" [@@mel.obj]

external make_InputB: 
  ?time: TestsUtils.Datetime.t -> 
  ?usingA: input_InputA -> 
  ?_constraint: bool -> 
  unit ->
 input_InputB = "" [@@mel.obj]

external make_InputC: 
  intStr: TestsUtils.IntString.t -> 
  ?recursiveC: input_InputC -> 
  unit ->
 input_InputC = "" [@@mel.obj]

external make_SomeInput: 
  ?str: string -> 
  ?bool: bool -> 
  ?float: float -> 
  ?int: int -> 
  ?datetime: TestsUtils.Datetime.t -> 
  ?recursive: input_SomeInput -> 
  ?_private: bool -> 
  unit ->
 input_SomeInput = "" [@@mel.obj]

external make_RecursiveSetOnlineStatusInput: 
  someValue: TestsUtils.IntString.t -> 
  ?setOnlineStatus: input_SetOnlineStatusInput -> 
  unit ->
 input_RecursiveSetOnlineStatusInput = "" [@@mel.obj]

external make_SetOnlineStatusInput: 
  onlineStatus: [`Online | `Idle | `Offline] -> 
  someJsonValue: Js.Json.t -> 
  ?recursed: input_RecursiveSetOnlineStatusInput -> 
  unit ->
 input_SetOnlineStatusInput = "" [@@mel.obj]

external make_SearchInput: 
  ?names: string option array -> 
  id: int -> 
  ?someOtherId: float -> 
  unit ->
 input_SearchInput = "" [@@mel.obj]

external make_PesticideListSearchInput: 
  ?companyName: string array -> 
  ?pesticideIds: int array -> 
  skip: int -> 
  take: int -> 
  unit ->
 input_PesticideListSearchInput = "" [@@mel.obj]

