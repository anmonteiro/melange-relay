open Types

type nonrec t

type nonrec storeConfig =
  { gcReleaseBufferSize : int option
  ; queryCacheExpirationTime : int option
  }

external make : RecordSource.t -> storeConfig -> t = "Store"
[@@module "relay-runtime"] [@@new]

let make ~source ?gcReleaseBufferSize ?queryCacheExpirationTime () =
  make source { gcReleaseBufferSize; queryCacheExpirationTime }

external getSource : t -> RecordSource.t = "getSource" [@@send]
external publish : t -> RecordSource.t -> unit = "publish" [@@send]
external holdGC : t -> unit = "holdGC" [@@send]
external storeRootId : dataId = "ROOT_ID" [@@module "relay-runtime"]
external storeRootType : string = "ROOT_TYPE" [@@module "relay-runtime"]
