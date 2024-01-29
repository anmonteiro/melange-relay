open Types

external getConnection :
   record:RecordProxy.t
  -> key:string
  -> ?filters:arguments
  -> unit
  -> RecordProxy.t option
  = "getConnection"
[@@mel.module "relay-runtime"]
[@@mel.scope "ConnectionHandler"]
[@@mel.return nullable]

external createEdge :
   store:RecordSourceSelectorProxy.t
  -> connection:RecordProxy.t
  -> node:RecordProxy.t
  -> edgeType:string
  -> RecordProxy.t
  = "createEdge"
[@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]

external insertEdgeBefore :
   connection:RecordProxy.t
  -> newEdge:RecordProxy.t
  -> ?cursor:string
  -> unit
  -> unit
  = "insertEdgeBefore"
[@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]

external insertEdgeAfter :
   connection:RecordProxy.t
  -> newEdge:RecordProxy.t
  -> ?cursor:string
  -> unit
  -> unit
  = "insertEdgeAfter"
[@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]

external deleteNode :
   connection:RecordProxy.t
  -> nodeId:dataId
  -> unit
  = "deleteNode"
[@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]

external getConnectionID :
   dataId
  -> string
  -> 'filters
  -> dataId
  = "getConnectionID"
[@@mel.module "relay-runtime"] [@@mel.scope "ConnectionHandler"]
