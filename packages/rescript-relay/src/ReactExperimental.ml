external useDeferredValue : 'value -> 'value = "useDeferredValue"
  [@@bs.module "react"]

external useTransitionWithOptions :
   unit
  -> bool
     * (((unit -> unit) -> < name : string option > Js.t option -> unit)[@bs])
  = "useTransition"
  [@@bs.module "react"]

let useTransition () =
  let isPending, startTransition = useTransitionWithOptions () in
  ( isPending
  , React.useCallback1
      (fun cb -> (startTransition cb None [@bs]))
      [| startTransition |] )

module SuspenseList = struct
  external make :
     children:React.element
    -> ?revealOrder:[ `forwards | `backwards | `together ]
    -> React.element
    = "SuspenseList"
    [@@bs.module "react"] [@@react.component]
end
