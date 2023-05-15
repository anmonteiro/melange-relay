module Query = [%relay
  {|
  query TestQueryInputObjectsQuery($input: SearchInput!) {
    search(input: $input)
  }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let data =
      Query.use(
        ~variables=
          Query.makeVariables(
            ~input=Query.make_searchInput(~id=123, ~someOtherId=1.5, ()),
          ),
        (),
      );

    <div>
      {switch (data.search) {
       | None => React.string("-")
       | Some(search) => React.string(search)
       }}
    </div>;
  };
};

[@live]
let test_queryInputObjects = () => {
  let network =
    Melange_relay.Network.makePromiseBased(
      ~fetchFunction=RelayEnv.fetchQuery,
      (),
    );

  let environment =
    Melange_relay.Environment.make(
      ~network,
      ~store=
        Melange_relay.Store.make(
          ~source=Melange_relay.RecordSource.make(),
          (),
        ),
      (),
    );
  ();

  <TestProviders.Wrapper environment> <Test /> </TestProviders.Wrapper>;
};
