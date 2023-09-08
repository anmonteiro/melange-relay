open Types

type nonrec t

external create :
   t
  -> dataId:dataId
  -> typeName:string
  -> RecordProxy.t
  = "create"
[@@send]

external delete : t -> dataId:dataId -> unit = "delete" [@@send]

external get : t -> dataId:dataId -> RecordProxy.t option = "get"
[@@send] [@@return nullable]

external getRoot : t -> RecordProxy.t = "getRoot" [@@send]

external getRootField :
   t
  -> fieldName:string
  -> RecordProxy.t option
  = "getRootField"
[@@send] [@@return nullable]

external getPluralRootField :
   t
  -> fieldName:string
  -> RecordProxy.t Js.Nullable.t array option
  = "getPluralRootField"
[@@send] [@@return nullable]

let getPluralRootField t ~fieldName : RecordProxy.t option array option =
  getPluralRootField t ~fieldName
  |. RecordProxy.optArrayOfNullableToOptArrayOfOpt

external invalidateStore : t -> unit = "invalidateStore" [@@send]
