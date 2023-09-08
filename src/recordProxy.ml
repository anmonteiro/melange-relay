open Types

let (optArrayOfNullableToOptArrayOfOpt :
      'a Js.Nullable.t array option -> 'a option array option)
  =
 fun x ->
  match x with
  | None -> None
  | Some arr -> Some (arr |. Belt.Array.map Js.Nullable.toOption)

type nonrec t

external copyFieldsFrom : t -> sourceRecord:t -> unit = "copyFieldsFrom"
[@@send]

external getDataId : t -> dataId = "getDataID" [@@send]

external getLinkedRecord :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t option
  = "getLinkedRecord"
[@@send] [@@return nullable]

external getLinkedRecords :
   t
  -> string
  -> arguments option
  -> t Js.Nullable.t array option
  = "getLinkedRecords"
[@@send] [@@return nullable]

let getLinkedRecords t ~name ?arguments () : t option array option =
  getLinkedRecords t name arguments |. optArrayOfNullableToOptArrayOfOpt

external getOrCreateLinkedRecord :
   t
  -> name:string
  -> typeName:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "getOrCreateLinkedRecord"
[@@send]

external getType : t -> string = "getType" [@@send]

external getValueString :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> string option
  = "getValue"
[@@send] [@@return nullable]

external getValueStringArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> string option array option
  = "getValue"
[@@send] [@@return nullable]

external getValueInt :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> int option
  = "getValue"
[@@send] [@@return nullable]

external getValueIntArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> int option array option
  = "getValue"
[@@send] [@@return nullable]

external getValueFloat :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> float option
  = "getValue"
[@@send] [@@return nullable]

external getValueFloatArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> float option array option
  = "getValue"
[@@send] [@@return nullable]

external getValueBool :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> bool option
  = "getValue"
[@@send] [@@return nullable]

external getValueBoolArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> bool option array option
  = "getValue"
[@@send] [@@return nullable]

external setLinkedRecord :
   t
  -> record:t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setLinkedRecord"
[@@send]

external setLinkedRecordToUndefined :
   t
  -> (_[@as {json|undefined|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setLinkedRecordToNull :
   t
  -> (_[@as {json|null|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setLinkedRecords :
   t
  -> records:t option array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setLinkedRecords"
[@@send]

external setLinkedRecordsToUndefined :
   t
  -> (_[@as {json|undefined|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setLinkedRecordsToNull :
   t
  -> (_[@as {json|null|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueToUndefined :
   t
  -> (_[@as {json|undefined|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueToNull :
   t
  -> (_[@as {json|null|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueString :
   t
  -> value:string
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueStringArray :
   t
  -> value:string array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueInt :
   t
  -> value:int
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueIntArray :
   t
  -> value:int array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueFloat :
   t
  -> value:float
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueFloatArray :
   t
  -> value:float array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueBool :
   t
  -> value:bool
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external setValueBoolArray :
   t
  -> value:bool array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@send]

external invalidateRecord : t -> unit = "invalidateRecord" [@@send]
