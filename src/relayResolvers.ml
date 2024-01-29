open Types

external readFragment_ :
   'node fragmentNode
  -> 'fragmentRef
  -> 'fragment
  = "readFragment"
[@@mel.module "relay-runtime/lib/store/ResolverFragments"]

type nonrec ('fragment, 't) resolver = 'fragment -> 't option

(* This is abstract just to hide the implementation details that don't need to
   be known anyway. *)
type nonrec relayResolver

external mkRelayResolver : 'a -> relayResolver = "%identity"

let makeRelayResolver
    ~node
    ~(convertFragment : 'fragment -> 'fragment)
    (resolver : ('fragment, 't) resolver)
  =
  let relayResolver fRef =
    resolver (readFragment_ node fRef |. convertFragment)
  in
  relayResolver |. mkRelayResolver
