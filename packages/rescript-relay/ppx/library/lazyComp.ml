open Ppxlib
open Util

let lazyExtension =
  Extension.declare
    "relay.lazyComponent"
    Extension.Context.module_expr
    ((let open Ast_pattern in
      single_expr_payload
        (pexp_ident __
        ||| map (pexp_construct __ none) ~f:(fun f ident ->
            f (Ldot (ident, "make"))))) [@ocaml.doc
                                          "\n\
                                          \     * This matches both SomeModule \
                                           and SomeModule.make by mapping \
                                           SomeModule to\n\
                                          \       SomeModule.make.\n\
                                          \     "])
    (fun ~loc ~path:_ ident ->
      match ident with
      | Ldot (Lident moduleName, "make") ->
        let moduleIdent =
          Ppxlib.Ast_helper.Mod.ident ~loc { txt = Lident moduleName; loc }
        in
        Ast_helper.Mod.mk
          (Pmod_structure
             [ [%stri module type T = module type of [%m moduleIdent]]
             ; [%stri
                 external import_ :
                    (_
                    [@as
                      [%e makeStringExpr ~loc ("./" ^ moduleName ^ ".bs.js")]])
                   -> unit
                   -> (module T) Js.Promise.t
                   = "import"
                 [@@val]]
             ; [%stri type 'props component = 'props -> React.element]
             ; [%stri type 't withDefault = { default : 't }]
             ; [%stri
                 external lazy_ :
                    (unit -> 'props component withDefault Js.Promise.t)
                   -> 'props component
                   = "lazy"
                 [@@module "react"]]
             ; [%stri
                 let loadReactComponent () =
                   import_ () |. fun __x ->
                   Js.Promise.then_
                     (fun m ->
                       let (module M : T) = m in
                       Js.Promise.resolve { default = M.make })
                     __x]
             ; [%stri
                 let preload () =
                   let _ = import_ () in
                   ()
                 [@@live]]
             ; [%stri
                 [%%private
                 let unsafePlaceholder = ([%raw {|{}|}] : (module T))]]
             ; [%stri module UnsafePlaceholder = (val unsafePlaceholder)]
             ; [%stri let makeProps = UnsafePlaceholder.makeProps]
             ; [%stri let make = lazy_ loadReactComponent]
             ])
      | _ ->
        Location.raise_errorf
          ~loc
          "Please provide a reference either to the make function of a top \
           level React component module you want to import (MyComponent.make), \
           or the React component module itself (MyComponent).")
