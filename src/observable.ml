type nonrec 'response t

type nonrec subscription =
  { unsubscribe : unit -> unit
  ; closed : bool
  }

type nonrec 'response sink =
  { next : ('response -> unit[@u])
  ; error : (Js.Exn.t -> unit[@u])
  ; complete : (unit -> unit[@u])
  ; closed : bool
  }

type nonrec 'response observer

external makeObserver :
   ?start:((subscription[@uncurry]) -> unit)
  -> ?next:(('response[@uncurry]) -> unit)
  -> ?error:((Js.Exn.t[@uncurry]) -> unit)
  -> ?complete:((unit[@uncurry]) -> unit)
  -> ?unsubscribe:((subscription[@uncurry]) -> unit)
  -> unit
  -> 'response observer
  = ""
[@@obj]

external make :
   ('response sink -> subscription option)
  -> 'response t
  = "create"
[@@module "relay-runtime"] [@@scope "Observable"]

external subscribe :
   'response t
  -> 'response observer
  -> subscription
  = "subscribe"
[@@send]

external toPromise : 't t -> 't Js.Promise.t = "toPromise" [@@send]
external ignoreSubscription : subscription -> unit = "%ignore"
