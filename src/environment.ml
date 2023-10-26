open Types

type nonrec t

type nonrec 'a environmentConfig =
  { network : Network.t
  ; store : Store.t
  ; getDataID : (nodeObj:'a -> typeName:string -> string) option [@optional]
  ; treatMissingFieldsAsNull : bool option [@optional]
  ; missingFieldHandlers : MissingFieldHandler.t array
  ; requiredFieldLogger : RequiredFieldLogger.js option [@optional]
  ; isServer : bool option [@optional]
  }
[@@deriving abstract]

let nodeInterfaceMissingFieldHandler =
  MissingFieldHandler.makeLinkedMissingFieldHandler
    (fun field record args _store ->
       match
         Js.Nullable.toOption record, field##name, Js.Nullable.toOption args##id
       with
       | Some record, "node", argsId
         when record |. RecordProxy.getType = Store.storeRootType ->
         argsId
       | _ -> None)

external make : 'a environmentConfig -> t = "Environment"
[@@module "relay-runtime"] [@@new]

let make
    ~network
    ~store
    ?getDataID
    ?treatMissingFieldsAsNull
    ?missingFieldHandlers
    ?requiredFieldLogger
    ?isServer
    ()
  =
  make
    (environmentConfig
       ~network
       ~store
       ?getDataID
       ?treatMissingFieldsAsNull
       ~missingFieldHandlers:
         (match missingFieldHandlers with
         | Some handlers ->
           Array.append handlers [| nodeInterfaceMissingFieldHandler |]
         | None -> [| nodeInterfaceMissingFieldHandler |])
       ?requiredFieldLogger:
         (Option.map RequiredFieldLogger.toJs requiredFieldLogger)
       ?isServer
       ())

external getStore : t -> Store.t = "getStore" [@@send]

external commitPayload :
   t
  -> operationDescriptor
  -> 'payload
  -> unit
  = "commitPayload"
[@@send]

external retain : t -> operationDescriptor -> Disposable.t = "retain" [@@send]
