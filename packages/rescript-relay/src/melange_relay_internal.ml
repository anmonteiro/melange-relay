let internal_keepMapFieldsRaw record f =
  record
  |. Obj.magic
  |. Belt.Option.map (fun obj ->
      obj |. Js.Dict.entries |. Belt.Array.keepMap f |. Js.Dict.fromArray)
  |. Obj.magic

(* we need to do this until we can use @obj on record types
 * see https://github.com/rescript-lang/rescript-compiler/pull/5253 *)
let internal_cleanObjectFromUndefinedRaw record =
  match
    internal_keepMapFieldsRaw record (fun (key, value) ->
        match value with Some value -> Some (key, value) | None -> None)
  with
  | None -> [%raw {json|{}|json}]
  | Some v -> v

let internal_removeUndefinedAndConvertNullsRaw record =
  internal_keepMapFieldsRaw record (fun (key, value) ->
      match value, value = Some None with
      | Some value, _ -> Some (key, Js.Nullable.return value)
      | _, true -> Some (key, Js.Nullable.null)
      | None, _ -> None)

let internal_useConvertedValue convert v =
  React.useMemo1 (fun () -> convert v) [| v |]

let internal_nullableToOptionalExnHandler x =
  match x with
  | None -> None
  | Some handler ->
    Some (fun maybeExn -> maybeExn |. Js.Nullable.toOption |. handler)

type arg = Arg : _ -> arg [@@live] [@@unboxed]
