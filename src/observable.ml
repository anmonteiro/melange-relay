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
   ?start:((subscription[@mel.uncurry]) -> unit)
  -> ?next:(('response[@mel.uncurry]) -> unit)
  -> ?error:((Js.Exn.t[@mel.uncurry]) -> unit)
  -> ?complete:((unit[@mel.uncurry]) -> unit)
  -> ?unsubscribe:((subscription[@mel.uncurry]) -> unit)
  -> unit
  -> 'response observer
  = ""
[@@mel.obj]

external make :
   ('response sink -> subscription option)
  -> 'response t
  = "create"
[@@mel.module "relay-runtime"] [@@mel.scope "Observable"]

external subscribe :
   'response t
  -> 'response observer
  -> subscription
  = "subscribe"
[@@mel.send]

external toPromise : 't t -> 't Js.Promise.t = "toPromise" [@@mel.send]
external ignoreSubscription : subscription -> unit = "%ignore"
