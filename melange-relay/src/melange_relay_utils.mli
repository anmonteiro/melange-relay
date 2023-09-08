val resolveNestedRecord :
   rootRecord:Melange_relay.RecordProxy.t option
  -> path:string list
  -> Melange_relay.RecordProxy.t option
(**Tries to return a record from a nested path of linked records.*)

val resolveNestedRecordFromRoot :
   store:Melange_relay.RecordSourceSelectorProxy.t
  -> path:string list
  -> Melange_relay.RecordProxy.t option
(**Tries to return a record from a nested path of linked records, starting from
   the root.*)

(**Helpers for handling connections.*)
type nonrec insertAt =
  | Start
  | End

type nonrec connectionConfig =
  { parentID : Melange_relay.dataId
  ; key : string
  ; filters : Melange_relay.arguments option
  }

val removeNodeFromConnections :
   store:Melange_relay.RecordSourceSelectorProxy.t
  -> node:Melange_relay.RecordProxy.t
  -> connections:connectionConfig list
  -> unit

val createAndAddEdgeToConnections :
   store:Melange_relay.RecordSourceSelectorProxy.t
  -> node:Melange_relay.RecordProxy.t
  -> connections:connectionConfig list
  -> edgeName:string
  -> insertAt:insertAt
  -> unit
