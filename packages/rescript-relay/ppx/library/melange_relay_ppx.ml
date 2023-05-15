open Ppxlib
open Util
module Util = Util

let endsWithRegexp = Str.regexp ".*Resolver$"

let commonExtension =
  let extension ~loc ~path:_ operationStr =
    let op = extractGraphQLOperation ~loc operationStr in
    match op with
    | Graphql_parser.Fragment { name = fragmentName; selection_set } ->
      if Str.string_match endsWithRegexp fragmentName 0
      then
        RelayResolverFragment.make
          ~loc
          ~moduleName:(op |> extractTheFragmentName ~loc)
      else
        let refetchableQueryName =
          op |> extractFragmentRefetchableQueryName ~loc
        in
        Fragment.make
          ~moduleName:(op |> extractTheFragmentName ~loc)
          ~refetchableQueryName
          ~extractedConnectionInfo:(op |> extractFragmentConnectionInfo ~loc)
          ~hasInlineDirective:(op |> fragmentHasInlineDirective ~loc)
          ~loc
    | Operation { optype = Query } ->
      Query.make
        ~moduleName:(op |> extractTheQueryName ~loc)
        ~hasRawResponseType:(op |> queryHasRawResponseTypeDirective ~loc)
        ~loc
    | Operation { optype = Mutation } ->
      Mutation.make ~moduleName:(op |> extractTheMutationName ~loc) ~loc
    | Operation { optype = Subscription } ->
      Subscription.make ~moduleName:(op |> extractTheSubscriptionName ~loc) ~loc
  in
  Extension.declare
    "relay"
    Extension.Context.module_expr
    Ast_pattern.(single_expr_payload (estring __))
    extension

let () =
  Driver.register_transformation
    ~extensions:
      [ commonExtension; LazyComp.lazyExtension; DeferredComp.lazyExtension ]
    "rescript-relay"
