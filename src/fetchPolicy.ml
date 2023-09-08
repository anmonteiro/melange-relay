type t =
  | StoreOnly
  | StoreOrNetwork
  | StoreAndNetwork
  | NetworkOnly

let map x =
  match x with
  | Some StoreOnly -> Some "store-only"
  | Some StoreOrNetwork -> Some "store-or-network"
  | Some StoreAndNetwork -> Some "store-and-network"
  | Some NetworkOnly -> Some "network-only"
  | None -> None

type nonrec fetchQueryFetchPolicy =
  | NetworkOnly
  | StoreOrNetwork

let mapFetchQueryFetchPolicy x =
  match x with
  | Some StoreOrNetwork -> Some "store-or-network"
  | Some NetworkOnly -> Some "network-only"
  | None -> None
