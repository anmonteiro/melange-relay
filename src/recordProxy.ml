open Types

let (optArrayOfNullableToOptArrayOfOpt :
      'a Js.Nullable.t array option -> 'a option array option)
  =
 fun x ->
  match x with
  | None -> None
  | Some arr -> Some (Array.map Js.Nullable.toOption arr)

type nonrec t

external copyFieldsFrom : t -> sourceRecord:t -> unit = "copyFieldsFrom"
[@@mel.send]

external getDataId : t -> dataId = "getDataID" [@@mel.send]

external getLinkedRecord :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t option
  = "getLinkedRecord"
[@@mel.send] [@@mel.return nullable]

external getLinkedRecords :
   t
  -> string
  -> arguments option
  -> t Js.Nullable.t array option
  = "getLinkedRecords"
[@@mel.send] [@@mel.return nullable]

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
[@@mel.send]

external getType : t -> string = "getType" [@@mel.send]

external getValueString :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> string option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueStringArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> string option array option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueInt :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> int option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueIntArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> int option array option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueFloat :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> float option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueFloatArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> float option array option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueBool :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> bool option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external getValueBoolArray :
   t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> bool option array option
  = "getValue"
[@@mel.send] [@@mel.return nullable]

external setLinkedRecord :
   t
  -> record:t
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setLinkedRecord"
[@@mel.send]

external setLinkedRecordToUndefined :
   t
  -> (_[@mel.as {json|undefined|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setLinkedRecordToNull :
   t
  -> (_[@mel.as {json|null|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setLinkedRecords :
   t
  -> records:t option array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setLinkedRecords"
[@@mel.send]

external setLinkedRecordsToUndefined :
   t
  -> (_[@mel.as {json|undefined|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setLinkedRecordsToNull :
   t
  -> (_[@mel.as {json|null|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueToUndefined :
   t
  -> (_[@mel.as {json|undefined|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueToNull :
   t
  -> (_[@mel.as {json|null|json}])
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueString :
   t
  -> value:string
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueStringArray :
   t
  -> value:string array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueInt :
   t
  -> value:int
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueIntArray :
   t
  -> value:int array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueFloat :
   t
  -> value:float
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueFloatArray :
   t
  -> value:float array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueBool :
   t
  -> value:bool
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external setValueBoolArray :
   t
  -> value:bool array
  -> name:string
  -> ?arguments:arguments
  -> unit
  -> t
  = "setValue"
[@@mel.send]

external invalidateRecord : t -> unit = "invalidateRecord" [@@mel.send]
