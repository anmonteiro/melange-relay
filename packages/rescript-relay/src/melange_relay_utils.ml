open Melange_relay

let resolveNestedRecord
    ~(rootRecord : Melange_relay.RecordProxy.t option)
    ~(path : string list)
  =
  let currentRecord = ref rootRecord in
  let pathLength = List.length path in
  (match pathLength with
  | 0 -> ()
  | _ ->
    for i = 0 to pathLength - 1 do
      let currentPath = path |. Belt.List.get i in
      match currentRecord.contents, currentPath with
      | Some record, Some currentPath ->
        currentRecord :=
          record
          |. Melange_relay.RecordProxy.getLinkedRecord ~name:currentPath ()
      | _ -> currentRecord := None
    done);
  currentRecord.contents

let resolveNestedRecordFromRoot ~store ~(path : string list) =
  match path with
  | [] -> None
  | rootRecordPath :: [] ->
    (match
       store
       |. Melange_relay.RecordSourceSelectorProxy.getRootField
            ~fieldName:rootRecordPath
     with
    | Some rootRecord -> Some rootRecord
    | None -> None)
  | rootRecordPath :: restPath ->
    resolveNestedRecord
      ~rootRecord:
        (store
        |. Melange_relay.RecordSourceSelectorProxy.getRootField
             ~fieldName:rootRecordPath)
      ~path:restPath

type nonrec insertAt =
  | Start
  | End

type nonrec connectionConfig =
  { parentID : dataId
  ; key : string
  ; filters : Melange_relay.arguments option
  }

let removeNodeFromConnections ~store ~node ~connections =
  connections
  |. Belt.List.forEach (fun connectionConfig ->
      match
        store |. RecordSourceSelectorProxy.get ~dataId:connectionConfig.parentID
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

let createAndAddEdgeToConnections ~store ~node ~connections ~edgeName ~insertAt =
  connections
  |. Belt.List.forEach (fun connectionConfig ->
      match
        store |. RecordSourceSelectorProxy.get ~dataId:connectionConfig.parentID
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
