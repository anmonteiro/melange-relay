[@@@warning "-30"]

type nonrec t

type nonrec normalizationArgumentWrapped =
  { kind : [ `ListValue | `Literal | `ObjectValue | `Variable ] }

type normalizationListValueArgument =
  { name : string
  ; items : normalizationArgumentWrapped Js.Nullable.t array
  }

and normalizationLiteralArgument =
  { name : string
  ; type_ : string Js.Nullable.t [@mel.as "type"]
  ; value : Js.Json.t
  }

and normalizationObjectValueArgument =
  { name : string
  ; fields : normalizationArgumentWrapped array Js.Nullable.t
  }

and normalizationVariableArgument =
  { name : string
  ; type_ : string Js.Nullable.t [@mel.as "type"]
  ; variableName : string
  }

type nonrec normalizationArgument =
  | ListValue of normalizationListValueArgument
  | Literal of normalizationLiteralArgument
  | ObjectValue of normalizationObjectValueArgument
  | Variable of normalizationVariableArgument

let unwrapNormalizationArgument wrapped =
  match wrapped.kind with
  | `ListValue -> ListValue (Obj.magic wrapped)
  | `Literal -> Literal (Obj.magic wrapped)
  | `ObjectValue -> ObjectValue (Obj.magic wrapped)
  | `Variable -> Variable (Obj.magic wrapped)

type nonrec normalizationScalarField =
  { alias : string Js.Nullable.t
  ; name : string
  ; args : normalizationArgumentWrapped array Js.Nullable.t
  ; storageKey : string Js.Nullable.t
  }

let makeScalarMissingFieldHandler handle =
  Obj.magic [%obj { kind = `scalar; handle }]

type nonrec normalizationLinkedField =
  { alias : string Js.Nullable.t
  ; name : string
  ; storageKey : string Js.Nullable.t
  ; args : normalizationArgument array Js.Nullable.t
  ; concreteType : string Js.Nullable.t
  ; plural : bool
  ; selections : Js.Json.t array
  }

let makeLinkedMissingFieldHandler handle =
  Obj.magic [%obj { kind = `linked; handle }]

let makePluralLinkedMissingFieldHandler handle =
  Obj.magic [%obj { kind = `pluralLinked; handle }]
