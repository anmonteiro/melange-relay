module Query = [%relay
  {|
    query TestRefetchingQuery {
      loggedInUser {
        ...TestRefetching_user
      }
    }
|}
];

module Fragment = [%relay
  {|
    fragment TestRefetching_user on User
      @refetchable(queryName: "TestRefetchingRefetchQuery")
      @argumentDefinitions(
        friendsOnlineStatuses: { type: "[OnlineStatus!]" }
        showOnlineStatus: { type: "Boolean", defaultValue: false }
      ) {
      firstName
      onlineStatus @include(if: $showOnlineStatus)
      friendsConnection(statuses: $friendsOnlineStatuses) {
        totalCount
      }
    }
|}
];

module FragmentWithNoArgs = [%relay
  {|
    fragment TestRefetchingNoArgs_query on Query
      @refetchable(queryName: "TestRefetchingNoArgsRefetchQuery")
      {
      loggedInUser {
        id
      }
    }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let query = Query.use(~variables=(), ());

    let (data, refetch) =
      Fragment.useRefetchable(query.loggedInUser.fragmentRefs);

    let (_, startTransition) = ReactExperimental.useTransition();

    <div>
      {React.string(
         data.firstName
         ++ " is "
         ++ (
           switch (data.onlineStatus) {
           | Some(`Online) => "online"
           | _ => "-"
           }
         ),
       )}
      <div>
        {React.string(
           "Friends: " ++ data.friendsConnection.totalCount->string_of_int,
         )}
      </div>
      <button
        onClick={_ =>
          startTransition(() =>
            refetch(
              ~variables=
                Fragment.makeRefetchVariables(
                  ~showOnlineStatus=Some(true),
                  ~friendsOnlineStatuses=Some([|`Online, `Offline|]),
                  (),
                ),
              (),
            )
            ->Melange_relay.Disposable.ignore
          )
        }>
        {React.string("Fetch online status")}
      </button>
    </div>;
  };
};

[@live]
let test_refetching = () => {
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
