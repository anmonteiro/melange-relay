open Types

type nonrec t

external create :
   t
  -> dataId:dataId
  -> typeName:string
  -> RecordProxy.t
  = "create"
[@@mel.send]

external delete : t -> dataId:dataId -> unit = "delete" [@@mel.send]

external get : t -> dataId:dataId -> RecordProxy.t option = "get"
[@@mel.send] [@@mel.return nullable]

external getRoot : t -> RecordProxy.t = "getRoot" [@@mel.send]

external getRootField :
   t
  -> fieldName:string
  -> RecordProxy.t option
  = "getRootField"
[@@mel.send] [@@mel.return nullable]

external getPluralRootField :
   t
  -> fieldName:string
  -> RecordProxy.t Js.Nullable.t array option
  = "getPluralRootField"
[@@mel.send] [@@mel.return nullable]

let getPluralRootField t ~fieldName : RecordProxy.t option array option =
  getPluralRootField t ~fieldName
  |. RecordProxy.optArrayOfNullableToOptArrayOfOpt

external invalidateStore : t -> unit = "invalidateStore" [@@mel.send]
