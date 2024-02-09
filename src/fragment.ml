open Types

external useFragment_ :
   'node fragmentNode
  -> 'fragmentRef
  -> 'fragment
  = "useFragment"
[@@mel.module "react-relay"]

(* React hook for getting the data of this fragment. Pass the `fragmentRefs` of
   any object where you've spread your fragment into this and get the fragment
   data back.

   ### Fragment data outside of React's render If you're looking for a way to
   use fragments _outside_ of render (for regular function calls for instance,
   like for logging etc), look in to adding `@inline` to your fragment
   definition (like `fragment SomeFragment_user on User @inline {...}`) and then
   use `Fragment.readInline`. This will allow you to get the fragment data, but
   outside of React's render.*)
let useFragment ~node ~(convertFragment : 'fragment -> 'fragment) ~fRef =
  useFragment_ node fRef |. fun __x ->
  Internal.internal_useConvertedValue convertFragment __x

external useFragmentOpt_ :
   'node fragmentNode
  -> 'fragmentRef option
  -> 'fragment Js.Nullable.t
  = "useFragment"
[@@mel.module "react-relay"]

(* A version of `Fragment.use` that'll allow you to pass `option<fragmentRefs>`
   and get `option<'fragmentData>` back. Useful for scenarios where you don't
   have the fragmentRefs yet. *)
let useFragmentOpt ~fRef ~node ~(convertFragment : 'fragment -> 'fragment) =
  let data = useFragmentOpt_ node fRef |. Js.Nullable.toOption in
  React.useMemo1
    (fun () ->
      match data with Some data -> Some (convertFragment data) | None -> None)
    [| data |]

external readInlineData_ :
   'node fragmentNode
  -> 'fragmentRef
  -> 'fragment
  = "readInlineData"
[@@mel.module "react-relay"]

let readInlineData ~node ~(convertFragment : 'fragment -> 'fragment) ~fRef =
  readInlineData_ node fRef |. convertFragment

type refetchableFnOpts =
  { fetchPolicy : string option [@mel.optional]
  ; onComplete : (Js.Exn.t Js.Nullable.t -> unit) option [@mel.optional]
  }
[@@deriving jsProperties, getSet]

let internal_makeRefetchableFnOpts ?fetchPolicy ?onComplete () =
  refetchableFnOpts
    ?fetchPolicy:(fetchPolicy |. FetchPolicy.map)
    ?onComplete:(onComplete |. Internal.internal_nullableToOptionalExnHandler)
    ()

type nonrec paginationLoadMoreOptions =
  { onComplete : (Js.Exn.t Js.Nullable.t -> unit) option [@mel.optional] }
[@@deriving jsProperties, getSet]

type nonrec paginationLoadMoreFn =
  count:int -> ?onComplete:(Js.Exn.t option -> unit) -> unit -> Disposable.t

type nonrec ('fragment, 'refetchVariables) paginationFragmentReturnRaw =
  { data : 'fragment
  ; loadNext : int -> paginationLoadMoreOptions -> Disposable.t
  ; loadPrevious : int -> paginationLoadMoreOptions -> Disposable.t
  ; hasNext : bool
  ; hasPrevious : bool
  ; isLoadingNext : bool
  ; isLoadingPrevious : bool
  ; refetch : 'refetchVariables -> refetchableFnOpts -> Disposable.t
  }

type nonrec ('fragment, 'refetchVariables) paginationBlockingFragmentReturn =
  { data : 'fragment
  ; loadNext : paginationLoadMoreFn
  ; loadPrevious : paginationLoadMoreFn
  ; hasNext : bool
  ; hasPrevious : bool
  ; refetch :
      variables:'refetchVariables
      -> ?fetchPolicy:FetchPolicy.t
      -> ?onComplete:(Js.Exn.t option -> unit)
      -> unit
      -> Disposable.t
  }

type nonrec ('fragment, 'refetchVariables) paginationFragmentReturn =
  { data : 'fragment
  ; loadNext : paginationLoadMoreFn
  ; loadPrevious : paginationLoadMoreFn
  ; hasNext : bool
  ; hasPrevious : bool
  ; isLoadingNext : bool
  ; isLoadingPrevious : bool
  ; refetch :
      variables:'refetchVariables
      -> ?fetchPolicy:FetchPolicy.t
      -> ?onComplete:(Js.Exn.t option -> unit)
      -> unit
      -> Disposable.t
  }

external usePaginationFragment_ :
   'node fragmentNode
  -> 'fragmentRef
  -> ('fragment, 'refetchVariables) paginationFragmentReturnRaw
  = "usePaginationFragment"
[@@mel.module "react-relay"]

(** React hook for paginating a fragment. Paginating with this hook will _not_
    cause your component to suspend. If you want pagination to trigger suspense,
    look into using `Fragment.useBlockingPagination`.*)
let usePaginationFragment
    ~node
    ~fRef
    ~(convertFragment : 'fragment -> 'fragment)
    ~(convertRefetchVariables : 'refetchVariables -> 'refetchVariables)
  =
  let p = usePaginationFragment_ node fRef in
  let data = Internal.internal_useConvertedValue convertFragment p.data in
  { data
  ; loadNext =
      React.useMemo1
        (fun () ~count ?onComplete () ->
          p.loadNext
            count
            (paginationLoadMoreOptions
               ?onComplete:
                 (onComplete |. Internal.internal_nullableToOptionalExnHandler)
               ()))
        [| p.loadNext |]
  ; loadPrevious =
      React.useMemo1
        (fun () ~count ?onComplete () ->
          p.loadPrevious
            count
            (paginationLoadMoreOptions
               ?onComplete:
                 (onComplete |. Internal.internal_nullableToOptionalExnHandler)
               ()))
        [| p.loadPrevious |]
  ; hasNext = p.hasNext
  ; hasPrevious = p.hasPrevious
  ; isLoadingNext = p.isLoadingNext
  ; isLoadingPrevious = p.isLoadingPrevious
  ; refetch =
      React.useMemo1
        (fun () ~variables ?fetchPolicy ?onComplete () ->
          p.refetch
            (Internal.internal_cleanObjectFromUndefinedRaw
               (variables |. convertRefetchVariables))
            (internal_makeRefetchableFnOpts ?onComplete ?fetchPolicy ()))
        [| p.refetch |]
  }

external useBlockingPaginationFragment_ :
   'node fragmentNode
  -> 'fragmentRef
  -> ('fragment, 'refetchVariables) paginationFragmentReturnRaw
  = "default"
[@@mel.module "react-relay/lib/relay-hooks/legacy/useBlockingPaginationFragment"]

(** Like `Fragment.usePagination`, but calling the pagination function will
    trigger suspense. Useful for all-at-once pagination.*)
let useBlockingPaginationFragment
    ~node
    ~fRef
    ~(convertFragment : 'fragment -> 'fragment)
    ~(convertRefetchVariables : 'refetchVariables -> 'refetchVariables)
  =
  let p = useBlockingPaginationFragment_ node fRef in
  let data = Internal.internal_useConvertedValue convertFragment p.data in
  { data
  ; loadNext =
      React.useMemo1
        (fun () ~count ?onComplete () ->
          p.loadNext
            count
            (paginationLoadMoreOptions
               ?onComplete:
                 (onComplete |. Internal.internal_nullableToOptionalExnHandler)
               ()))
        [| p.loadNext |]
  ; loadPrevious =
      React.useMemo1
        (fun () ~count ?onComplete () ->
          p.loadPrevious
            count
            (paginationLoadMoreOptions
               ?onComplete:
                 (onComplete |. Internal.internal_nullableToOptionalExnHandler)
               ()))
        [| p.loadPrevious |]
  ; hasNext = p.hasNext
  ; hasPrevious = p.hasPrevious
  ; refetch =
      React.useMemo1
        (fun () ~variables ?fetchPolicy ?onComplete () ->
          p.refetch
            (Internal.internal_cleanObjectFromUndefinedRaw
               (variables |. convertRefetchVariables))
            (internal_makeRefetchableFnOpts ?onComplete ?fetchPolicy ()))
        [| p.refetch |]
  }

external useRefetchableFragment_ :
   'node fragmentNode
  -> 'fragmentRef
  -> 'fragment * ('refetchVariables -> refetchableFnOpts -> Disposable.t)
  = "useRefetchableFragment"
[@@mel.module "react-relay"]

(**React hook for using a fragment that you want to refetch. Returns a tuple of
   `(fragmentData, refetchFn)`. ### Refetching and variables You supply a _diff_
   of your variables to Relay when refetching. Diffed variables here means that
   any new value you supply when refetching will be merged with the variables
   you last used when fetching data for this fragment. ###
   `Fragment.makeRefetchVariables` - helper for making the refetch variables
   There's a helper generated for you to create those diffed variables more
   easily at `Fragment.makeRefetchVariables`.*)
let useRefetchableFragment
    ~node
    ~(convertFragment : 'fragment -> 'fragment)
    ~(convertRefetchVariables : 'refetchVariables -> 'refetchVariables)
    ~fRef
  =
  let fragmentData, refetchFn = useRefetchableFragment_ node fRef in
  let data = Internal.internal_useConvertedValue convertFragment fragmentData in
  ( data
  , React.useMemo1
      (fun () ~(variables : 'refetchVariables) ?fetchPolicy ?onComplete () ->
        refetchFn
          (Internal.internal_removeUndefinedAndConvertNullsRaw
             (variables |. convertRefetchVariables))
          (internal_makeRefetchableFnOpts ?fetchPolicy ?onComplete ()))
      [| refetchFn |] )
