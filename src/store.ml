open Types

type nonrec t

type nonrec storeConfig =
  { gcReleaseBufferSize : int option
  ; queryCacheExpirationTime : int option
  }

external make : RecordSource.t -> storeConfig -> t = "Store"
[@@mel.module "relay-runtime"] [@@mel.new]

let make ~source ?gcReleaseBufferSize ?queryCacheExpirationTime () =
  make source { gcReleaseBufferSize; queryCacheExpirationTime }

external getSource : t -> RecordSource.t = "getSource" [@@mel.send]
external publish : t -> RecordSource.t -> unit = "publish" [@@mel.send]
external holdGC : t -> unit = "holdGC" [@@mel.send]
external storeRootId : dataId = "ROOT_ID" [@@mel.module "relay-runtime"]
external storeRootType : string = "ROOT_TYPE" [@@mel.module "relay-runtime"]
