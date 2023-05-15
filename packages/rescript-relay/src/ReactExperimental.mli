external useDeferredValue : 'value -> 'value = "useDeferredValue"
  [@@bs.module "react"]

external useTransitionWithOptions :
   unit
  -> bool
     * (((unit -> unit) -> < name : string option > Js.t option -> unit)[@bs])
  = "useTransition"
  [@@bs.module "react"]

val useTransition : unit -> bool * (unit -> unit, unit) React.callback

module SuspenseList : sig
  external make :
     children:React.element
    -> ?revealOrder:[ `forwards | `backwards | `together ]
    -> React.element
    = "SuspenseList"
    [@@bs.module "react"] [@@react.component]
end
