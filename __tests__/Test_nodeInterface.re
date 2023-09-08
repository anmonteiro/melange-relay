module Fragment = [%relay
  {|
  fragment TestNodeInterface_user on User {
    firstName
  }
|}
];

module Query = [%relay
  {|
    query TestNodeInterfaceQuery {
      node(id: "123") {
        ... on User {
          firstName
          ...TestNodeInterface_user
        }
      }
    }
|}
];

module QueryAbstract = [%relay
  {|
  query TestNodeInterfaceOnAbstractTypeQuery {
    node(id: "123") {
      ... on Member {
        ... on User {
          firstName
        }
        ... on Group {
          name
        }
      }
    }
  }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let query = Query.use(~variables=(), ());

    switch (query.node) {
    | Some(user) => React.string(user.firstName)
    | None => React.string("-")
    };
  };
};

[@live]
let test_nodeInterface = () => {
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
