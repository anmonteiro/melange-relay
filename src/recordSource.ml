open Types

type nonrec t

external make : ?records:recordSourceRecords -> unit -> t = "RecordSource"
[@@mel.module "relay-runtime"] [@@mel.new]

external toJSON : t -> recordSourceRecords = "toJSON" [@@mel.send]
