exception Graphql_error(string);

[@bs.deriving jsConverter]
type t = {
  [@bs.as "content-type"]
  contentType: string,
  accept: string,
};

let fetchQuery: Melange_relay.Network.fetchFunctionPromise =
  (operation, variables, _cacheConfig, _uploadables) =>
    Fetch.(
      fetchWithInit(
        "http://graphql/",
        RequestInit.make(
          ~method=Post,
          ~body=
            Js.Dict.fromList([
              ("query", Js.Json.string(operation.text)),
              ("variables", variables),
            ])
            ->Js.Json.object_
            ->Js.Json.stringify
            ->BodyInit.make,
          ~headers=
            HeadersInit.make(
              tToJs({
                contentType: "application/json",
                accept: "application/json",
              }),
            ),
          (),
        ),
      )
      |> Js.Promise.then_(resp =>
           if (Response.ok(resp)) {
             Response.json(resp);
           } else {
             Js.Promise.reject(
               Graphql_error(
                 "Request failed: " ++ Response.statusText(resp),
               ),
             );
           }
         )
    );
