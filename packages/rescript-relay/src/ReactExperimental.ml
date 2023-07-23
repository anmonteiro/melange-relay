external useDeferredValue : 'value -> 'value = "useDeferredValue"
  [@@mel.module "react"]

external useTransitionWithOptions :
   unit
  -> bool
     * (((unit -> unit) -> < name : string option > Js.t option -> unit)[@u])
  = "useTransition"
  [@@mel.module "react"]

let useTransition () =
  let isPending, startTransition = useTransitionWithOptions () in
  ( isPending
  , React.useCallback1
      (fun cb -> (startTransition cb None [@u]))
      [| startTransition |] )

module SuspenseList = struct
  external make :
     children:React.element
    -> ?revealOrder:[ `forwards | `backwards | `together ]
    -> React.element
    = "SuspenseList"
    [@@mel.module "react"] [@@react.component]
end
