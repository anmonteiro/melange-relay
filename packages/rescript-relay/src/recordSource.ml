open Types

type nonrec t

external make : ?records:recordSourceRecords -> unit -> t = "RecordSource"
[@@module "relay-runtime"] [@@new]

external toJSON : t -> recordSourceRecords = "toJSON" [@@send]
