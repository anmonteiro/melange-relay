val internal_useConvertedValue : ('a -> 'a) -> 'a -> 'a
val internal_cleanObjectFromUndefinedRaw : 't -> 't
val internal_removeUndefinedAndConvertNullsRaw : 't -> 't

val internal_nullableToOptionalExnHandler :
   ('b option -> 'a) option
  -> ('b Js.Nullable.t -> 'a) option

type arg = Arg : _ -> arg [@@live] [@@unboxed]
