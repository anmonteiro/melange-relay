include ReactDOM.Experimental

external createRoot : Dom.element -> root = "createRoot"
[@@mel.module "react-dom/client"]

external getElementById :
   string
  -> Dom.element option
  = "document.getElementById"
[@@mel.return nullable]

let renderConcurrentRootAtElementWithId : React.element -> string -> unit =
 fun content id ->
  match getElementById id with
  | None ->
    raise
      (Invalid_argument
         ("ReactExperimental.renderConcurrentRootAtElementWithId : no element \
           of id "
         ^ id
         ^ " found in the HTML."))
  | Some element ->
    let root = createRoot element in
    render root content
