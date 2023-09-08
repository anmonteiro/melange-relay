Melange_relay.relayFeatureFlags.enableRelayResolvers = true;

module Query = [%relay
  {|
    query TestRelayResolversQuery {
      loggedInUser {
        ...TestRelayResolvers_user
      }
    }
|}
];

module Fragment = [%relay
  {|
    fragment TestRelayResolvers_user on User {
      isOnline
      fullName
    }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let query = Query.use(~variables=(), ());
    let data = Fragment.use(query.loggedInUser.fragmentRefs);

    <div>
      {switch (data) {
       | {isOnline: Some(isOnline), fullName: Some(fullName)} =>
         React.string(
           (fullName ++ {| is |})
           ++ (if (isOnline) {"online"} else {"offline"}),
         )
       | _ => React.string("-")
       }}
    </div>;
  };
};

[@live]
let test_relayResolvers = () => {
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
