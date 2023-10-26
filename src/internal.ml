let internal_keepMap =
  let module Private = struct
    external truncateToLengthUnsafe : 'a array -> int -> unit = "length"
    [@@mel.set]

    external makeUninitializedUnsafe : int -> 'a array = "Array" [@@mel.new]
  end
  in
  fun a ~f ->
    let l = Array.length a in
    let r = Private.makeUninitializedUnsafe l in
    let j = ref 0 in
    for i = 0 to l - 1 do
      let v = Array.unsafe_get a i in
      match f v with
      | None -> ()
      | Some v ->
        Array.unsafe_set r j.contents v;
        j.contents <- j.contents + 1
    done;
    Private.truncateToLengthUnsafe r j.contents;
    r

let internal_keepMapFieldsRaw record f =
  let dict : _ Js.Dict.t option = Obj.magic record in
  Option.map
    (fun obj ->
       let entries = Js.Dict.entries obj in
       let arr = internal_keepMap ~f entries in
       Js.Dict.fromArray arr)
    dict
  |> Obj.magic

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
