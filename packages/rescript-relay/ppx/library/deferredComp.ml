open Ppxlib
open Util
let lazyExtension =
  Extension.declare "relay.deferredComponent" Extension.Context.module_expr
    ((let open Ast_pattern in
        single_expr_payload
          ((pexp_ident __) |||
             (map (pexp_construct __ none)
                ~f:(fun f ->
                      fun ident ->
                        f ((Ldot (ident, "make"))[@explicit_arity ])))))
    [@ocaml.doc
      "\n     * This matches both SomeModule and SomeModule.make by mapping SomeModule to\n       SomeModule.make.\n     "])
    (fun ~loc ->
       fun ~path:_ ->
         fun ident ->
           match ident with
           | ((Ldot
               (((Lident (moduleName))[@explicit_arity ]), "make"))[@explicit_arity
                                                                    ])
               ->
               let realLoc = loc in
               let loc = Ppxlib.Location.none in
               let moduleIdent =
                 Ppxlib.Ast_helper.Mod.ident ~loc
                   { txt = ((Lident (moduleName))[@explicit_arity ]); loc } in
               let moduleIdentWithCorrectLoc =
                 Ppxlib.Ast_helper.Mod.ident ~loc
                   {
                     txt = ((Lident (moduleName))[@explicit_arity ]);
                     loc = realLoc
                   } in
               Ast_helper.Mod.mk
                 ((Pmod_structure
                     ([[%stri module M = [%m moduleIdentWithCorrectLoc]];
                      [%stri
                        module type T  = module type of [%m moduleIdent]];
                      [%stri
                        external import_ :
                          ((_)[@as
                                [%e
                                  makeStringExpr ~loc
                                    ("@rescriptModule/" ^ moduleName)]])
                            -> unit -> (module T) Js.Promise.t = "import"
                        [@@val ]];
                      [%stri type 't withDefault = {
                               default: 't }];
                      [%stri
                        external lazy_ :
                          (unit ->
                             'props React.component withDefault Js.Promise.t)
                            -> 'props React.component = "lazy"[@@module
                                                                "react"]];
                      [%stri
                        let loadReactComponent () =
                          (import_ ()) |.
                            ((fun __x ->
                                Js.Promise.then_
                                  (fun m ->
                                     let ((module M)  : (module T)) = m in
                                     Js.Promise.resolve { default = M.make })
                                  __x))];
                      [%stri let loadComponent () = (import_ ()) |. ignore];
                      [%stri
                        let preload () =
                          ((RelayRouter__Types.Component
                              ({
                                 chunk =
                                   ([%e makeStringExpr ~loc moduleName]);
                                 load = loadComponent
                               }))
                          [@explicit_arity ])[@@live ]];
                      [%stri
                        [%%private
                          let unsafePlaceholder =
                            ([%raw {|{}|}] : (module T))]];
                      [%stri
                        module UnsafePlaceholder = (val unsafePlaceholder)];
                      [%stri let makeProps = UnsafePlaceholder.makeProps];
                      [%stri let component = lazy_ loadReactComponent];
                      [%stri
                        let make props =
                          (RelayRouter.useRegisterPreloadedAsset
                             ((RelayRouter__Types.Component
                                 ({
                                    chunk =
                                      ([%e makeStringExpr ~loc moduleName]);
                                    load = loadComponent
                                  }))[@explicit_arity ]);
                           React.createElement component props)]]))
                 [@explicit_arity ])
           | _ ->
               Location.raise_errorf ~loc
                 "Please provide a reference either to the make function of a top level React component module you want to import (MyComponent.make), or the React component module itself (MyComponent).")