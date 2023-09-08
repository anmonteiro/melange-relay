open Types

val resolveNestedRecord :
   rootRecord:RecordProxy.t option
  -> path:string list
  -> RecordProxy.t option
(**Tries to return a record from a nested path of linked records.*)

val resolveNestedRecordFromRoot :
   store:RecordSourceSelectorProxy.t
  -> path:string list
  -> RecordProxy.t option
(**Tries to return a record from a nested path of linked records, starting from
   the root.*)

(**Helpers for handling connections.*)
type nonrec insertAt =
  | Start
  | End

type nonrec connectionConfig =
  { parentID : dataId
  ; key : string
  ; filters : arguments option
  }

val removeNodeFromConnections :
   store:RecordSourceSelectorProxy.t
  -> node:RecordProxy.t
  -> connections:connectionConfig list
  -> unit

val createAndAddEdgeToConnections :
   store:RecordSourceSelectorProxy.t
  -> node:RecordProxy.t
  -> connections:connectionConfig list
  -> edgeName:string
  -> insertAt:insertAt
  -> unit
