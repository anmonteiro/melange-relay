open Types

external getConnection :
   record:RecordProxy.t
  -> key:string
  -> ?filters:arguments
  -> unit
  -> RecordProxy.t option
  = "getConnection"
[@@module "relay-runtime"] [@@scope "ConnectionHandler"] [@@return nullable]

external createEdge :
   store:RecordSourceSelectorProxy.t
  -> connection:RecordProxy.t
  -> node:RecordProxy.t
  -> edgeType:string
  -> RecordProxy.t
  = "createEdge"
[@@module "relay-runtime"] [@@scope "ConnectionHandler"]

external insertEdgeBefore :
   connection:RecordProxy.t
  -> newEdge:RecordProxy.t
  -> ?cursor:string
  -> unit
  -> unit
  = "insertEdgeBefore"
[@@module "relay-runtime"] [@@scope "ConnectionHandler"]

external insertEdgeAfter :
   connection:RecordProxy.t
  -> newEdge:RecordProxy.t
  -> ?cursor:string
  -> unit
  -> unit
  = "insertEdgeAfter"
[@@module "relay-runtime"] [@@scope "ConnectionHandler"]

external deleteNode :
   connection:RecordProxy.t
  -> nodeId:dataId
  -> unit
  = "deleteNode"
[@@module "relay-runtime"] [@@scope "ConnectionHandler"]

external getConnectionID :
   dataId
  -> string
  -> 'filters
  -> dataId
  = "getConnectionID"
[@@module "relay-runtime"] [@@scope "ConnectionHandler"]
