open Types

let resolveNestedRecord
    ~(rootRecord : RecordProxy.t option)
    ~(path : string list)
  =
  let currentRecord = ref rootRecord in
  List.iter
    (fun currentPath ->
       match !currentRecord with
       | Some record ->
         currentRecord :=
           RecordProxy.getLinkedRecord record ~name:currentPath ()
       | _ -> currentRecord := None)
    path;
  currentRecord.contents

let resolveNestedRecordFromRoot ~store ~(path : string list) =
  match path with
  | [] -> None
  | rootRecordPath :: [] ->
    (match
       store |. RecordSourceSelectorProxy.getRootField ~fieldName:rootRecordPath
     with
    | Some rootRecord -> Some rootRecord
    | None -> None)
  | rootRecordPath :: restPath ->
    resolveNestedRecord
      ~rootRecord:
        (store
        |. RecordSourceSelectorProxy.getRootField ~fieldName:rootRecordPath)
      ~path:restPath

type nonrec insertAt =
  | Start
  | End

type nonrec connectionConfig =
  { parentID : dataId
  ; key : string
  ; filters : arguments option
  }

let removeNodeFromConnections ~store ~node ~connections =
  List.iter
    (fun connectionConfig ->
       match
         store
         |. RecordSourceSelectorProxy.get ~dataId:connectionConfig.parentID
       with
       | Some owner ->
         (match
            ConnectionHandler.getConnection
              ~record:owner
              ~key:connectionConfig.key
              ?filters:connectionConfig.filters
              ()
          with
         | Some connection ->
           ConnectionHandler.deleteNode
             ~connection
             ~nodeId:(node |. RecordProxy.getDataId)
         | None -> ())
       | None -> ())
    connections

let createAndAddEdgeToConnections ~store ~node ~connections ~edgeName ~insertAt =
  List.iter
    (fun connectionConfig ->
       match
         store
         |. RecordSourceSelectorProxy.get ~dataId:connectionConfig.parentID
       with
       | Some connectionOwner ->
         (match
            ConnectionHandler.getConnection
              ~record:connectionOwner
              ~key:connectionConfig.key
              ?filters:connectionConfig.filters
              ()
          with
         | Some connection ->
           let edge =
             ConnectionHandler.createEdge
               ~store
               ~connection
               ~node
               ~edgeType:edgeName
           in
           (match insertAt with
           | Start ->
             ConnectionHandler.insertEdgeAfter ~connection ~newEdge:edge ()
           | End ->
             ConnectionHandler.insertEdgeBefore ~connection ~newEdge:edge ())
         | None -> ())
       | None -> ())
    connections
