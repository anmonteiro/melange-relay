open Types

type nonrec t

type nonrec operation =
  { id : string
  ; text : string
  ; name : string
  ; operationKind : string
  }

type nonrec subscribeFn =
  operation -> Js.Json.t -> cacheConfig -> Js.Json.t Observable.t

type nonrec fetchFunctionPromise =
  operation
  -> Js.Json.t
  -> cacheConfig
  -> uploadables Js.Nullable.t
  -> Js.Json.t Js.Promise.t

type nonrec fetchFunctionObservable =
  operation
  -> Js.Json.t
  -> cacheConfig
  -> uploadables Js.Nullable.t
  -> Js.Json.t Observable.t

external makePromiseBased :
   fetchFunction:fetchFunctionPromise
  -> ?subscriptionFunction:subscribeFn
  -> unit
  -> t
  = "create"
[@@module "relay-runtime"] [@@scope "Network"]

external makeObservableBased :
   observableFunction:fetchFunctionObservable
  -> ?subscriptionFunction:subscribeFn
  -> unit
  -> t
  = "create"
[@@module "relay-runtime"] [@@scope "Network"]
