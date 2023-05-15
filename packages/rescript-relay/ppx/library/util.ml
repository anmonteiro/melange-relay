open Ppxlib
let extractGraphQLOperation ~loc  str =
  match str |> Graphql_parser.parse with
  | ((Ok (definitions))[@explicit_arity ]) ->
      (match definitions with
       | op::[] -> op
       | _ ->
           Location.raise_errorf ~loc
             "Only one GraphQL operation per %%relay-node is allowed.")
  | ((Error (err))[@explicit_arity ]) ->
      Location.raise_errorf ~loc
        "%%relay-nodes must define a single, valid GraphQL operation. GraphQL error message: %s"
        err[@@ocaml.doc
             "\n * This function takes a GraphQL document as a string (typically extracted from the [%relay] nodes),\n * uses Graphql_parser to parse the string into a list of GraphQL definitions, and then extracts the _first_ operation\n * of the document only. This is because Relay disallows multiple operations in the same definition.\n "]
let extractTheQueryName ~loc  op =
  match op with
  | ((Graphql_parser.Operation
      ({ optype = Query; name = ((Some (name))[@explicit_arity ]) }))
      [@explicit_arity ]) -> name
  | ((Operation ({ optype = Query; name = None }))[@explicit_arity ]) ->
      Location.raise_errorf ~loc "GraphQL query must be named."
  | _ ->
      Location.raise_errorf ~loc
        "%%relay must contain a query definition, and nothing else."[@@ocaml.doc
                                                                    "\n * Takes a raw GraphQL document as a string and extracts the query name. Raises an error if it's not a query\n * or the query has no name.\n "]
let extractTheMutationName ~loc  op =
  match op with
  | ((Graphql_parser.Operation
      ({ optype = Mutation; name = ((Some (name))[@explicit_arity ]) }))
      [@explicit_arity ]) -> name
  | ((Operation ({ optype = Mutation; name = None }))[@explicit_arity ]) ->
      Location.raise_errorf ~loc "GraphQL mutation must be named."
  | _ ->
      Location.raise_errorf ~loc
        "%%relay must contain a mutation definition, and nothing else."
  [@@ocaml.doc
    "\n * Takes a raw GraphQL document as a string and extracts the mutation name. Raises an error if it's not a mutation\n * or the mutation has no name.\n "]
let extractTheFragmentName ~loc  op =
  match op with
  | ((Graphql_parser.Fragment ({ name }))[@explicit_arity ]) -> name
  | _ ->
      Location.raise_errorf ~loc
        "%%relay must contain a fragment definition with a name, and nothing else."
  [@@ocaml.doc
    "\n * Takes a raw GraphQL document as a string and extracts the fragment name. Raises an error if it's not a fragment\n * or the fragment has no name.\n "]
let extractTheSubscriptionName ~loc  op =
  match op with
  | ((Graphql_parser.Operation
      ({ optype = Subscription; name = ((Some (name))[@explicit_arity ]) }))
      [@explicit_arity ]) -> name
  | ((Operation ({ optype = Subscription; name = None }))[@explicit_arity ])
      -> Location.raise_errorf ~loc "GraphQL subscription must be named."
  | _ ->
      Location.raise_errorf ~loc
        "%%relay must contain a subscription definition, and nothing else."
  [@@ocaml.doc
    "\n * Takes a raw GraphQL document as a string and extracts the subscription name. Raises an error if it's not a subscription\n * or the subscription has no name.\n "]
let extractFragmentRefetchableQueryName ~loc  op =
  match op with
  | ((Graphql_parser.Fragment ({ name = _; directives }))[@explicit_arity ])
      ->
      let refetchableQueryName = ref None in
      (directives |>
         (List.iter
            (fun (dir : Graphql_parser.directive) ->
               match dir with
               | { name = "refetchable";
                   arguments = ("queryName", `String queryName)::[] } ->
                   refetchableQueryName := ((Some (queryName))
                     [@explicit_arity ])
               | _ -> ()));
       !refetchableQueryName)
  | _ -> None[@@ocaml.doc
               "\n * Takes a raw GraphQL document as a string and attempts to extract the refetchable query name if there's one defined.\n * Relay wants you to define refetchable fragments roughly like this:\n *\n * fragment SomeFragment_someName on SomeType @refetchable(queryName: \"SomeFragmentRefetchQuery\") {\n *   ...\n * }\n *\n * So, this functions makes sure that @refetchable is defined and the queryName arg exists, and if so, extracts and\n * returns \"SomeFragmentRefetchQuery\" as an option string.\n "]
let rec selectionSetHasConnection selections =
  match selections |>
          (List.find_opt
             (fun sel ->
                match sel with
                | ((Graphql_parser.Field
                    ({ directives; selection_set }))[@explicit_arity ]) ->
                    (match directives |>
                             (List.find_opt
                                (fun (dir : Graphql_parser.directive) ->
                                   match dir with
                                   | { name = "connection" } -> true
                                   | _ -> false))
                     with
                     | Some _ -> true
                     | None -> selectionSetHasConnection selection_set)
                | ((InlineFragment ({ selection_set }))[@explicit_arity ]) ->
                    selectionSetHasConnection selection_set
                | _ -> false))
  with
  | Some _ -> true
  | None -> false[@@ocaml.doc
                   "\n * This recursively traverses all selection sets and looks for a @connection directive.\n "]
let queryHasRawResponseTypeDirective ~loc  op =
  match op with
  | ((Graphql_parser.Operation
      ({ optype = Query; name = Some _; directives }))[@explicit_arity ]) ->
      directives |>
        (List.exists
           (fun (directive : Graphql_parser.directive) ->
              directive.name = "raw_response_type"))
  | _ -> false
let fragmentHasConnectionNotation ~loc  op =
  match op with
  | ((Graphql_parser.Fragment
      ({ name = _; selection_set }))[@explicit_arity ]) ->
      selectionSetHasConnection selection_set
  | _ -> false
type connectionConfig = {
  key: string }
let extractFragmentConnectionInfo ~loc  op =
  match op with
  | ((Graphql_parser.Fragment
      ({ name = _; selection_set }))[@explicit_arity ]) ->
      selectionSetHasConnection selection_set
  | _ -> false
let fragmentHasInlineDirective ~loc  op =
  match op with
  | ((Graphql_parser.Fragment ({ name = _; directives }))[@explicit_arity ])
      ->
      directives |>
        (List.exists
           (fun (directive : Graphql_parser.directive) ->
              directive.name = "inline"))
  | _ -> false
let getGraphQLModuleName opName =
  (String.capitalize_ascii opName) ^ "_graphql"
let makeTypeAccessor ~loc  ~moduleName  path =
  let gqlModuleName = ((Lident ((getGraphQLModuleName moduleName)))
    [@explicit_arity ]) in
  Ppxlib.Ast_helper.Typ.constr ~loc
    {
      txt =
        (match path with
         | t::[] -> ((Ldot (gqlModuleName, t))[@explicit_arity ])
         | innerModule::t::[] ->
             ((Ldot
                 (((Ldot (gqlModuleName, innerModule))[@explicit_arity ]), t))
             [@explicit_arity ])
         | _ -> gqlModuleName);
      loc
    } []
let makeExprAccessor ~loc  ~moduleName  path =
  let gqlModuleName = ((Lident ((getGraphQLModuleName moduleName)))
    [@explicit_arity ]) in
  Ppxlib.Ast_helper.Exp.ident ~loc
    {
      txt =
        (match path with
         | t::[] -> ((Ldot (gqlModuleName, t))[@explicit_arity ])
         | innerModule::t::[] ->
             ((Ldot
                 (((Ldot (gqlModuleName, innerModule))[@explicit_arity ]), t))
             [@explicit_arity ])
         | _ -> gqlModuleName);
      loc
    }
let makeStringExpr ~loc  str =
  Ppxlib.Ast_helper.Exp.constant ~loc (Ppxlib.Ast_helper.Const.string str)
let makeModuleIdent ~loc  ~moduleName  path =
  let gqlModuleName = ((Lident ((getGraphQLModuleName moduleName)))
    [@explicit_arity ]) in
  Ppxlib.Ast_helper.Mod.ident ~loc
    {
      txt =
        (match path with
         | t::[] -> ((Ldot (gqlModuleName, t))[@explicit_arity ])
         | innerModule::t::[] ->
             ((Ldot
                 (((Ldot (gqlModuleName, innerModule))[@explicit_arity ]), t))
             [@explicit_arity ])
         | _ -> gqlModuleName);
      loc
    }