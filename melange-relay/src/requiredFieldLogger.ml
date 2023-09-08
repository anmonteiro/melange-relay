type kind =
  [ `missing_field_log [@mel.as "missing_field.log"]
  | `missing_field_throw [@mel.as "missing_field.throw"]
  ]
[@@deriving jsConverter { newType }]

type nonrec arg =
  { kind : abs_kind
  ; owner : string
  ; fieldPath : string
  }

type nonrec js = arg -> unit
type nonrec t = kind:kind -> owner:string -> fieldPath:string -> unit

let toJs : t -> js =
 fun f arg ->
  f ~kind:(kindFromJs arg.kind) ~owner:arg.owner ~fieldPath:arg.fieldPath
