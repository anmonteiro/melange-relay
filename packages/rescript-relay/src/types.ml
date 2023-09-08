type nonrec arguments
type nonrec allFieldsMasked = < > Js.t
type nonrec any
type nonrec 'node queryNode
type nonrec 'node fragmentNode
type nonrec 'node mutationNode
type nonrec 'node subscriptionNode
type nonrec 'fragments fragmentRefs
type nonrec dataId
type nonrec recordSourceRecords = Js.Json.t
type nonrec uploadables
type nonrec operationDescriptor

type nonrec cacheConfig =
  { force : bool option
  ; poll : int option
  ; liveConfigId : string option
  ; transactionId : string option
  }

type nonrec mutationError = { message : string }

exception Mutation_failed of mutationError array

type nonrec fetchQueryOptions =
  { networkCacheConfig : cacheConfig option
  ; fetchPolicy : string option
  }
