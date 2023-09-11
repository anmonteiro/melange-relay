module Query = [%relay
  {|
    query TestPaginationInNodeQuery($userId: ID!) {
      node(id: $userId) {
        id
        ... on User {
          ...TestPaginationInNode_query
        }
      }
    }
|}
];

module UserFragment = [%relay
  {|
  fragment TestPaginationInNode_user on User {
    id
    firstName
    friendsConnection(first: 1) {
      totalCount
    }
  }
|}
];

module Fragment = [%relay
  {|
    fragment TestPaginationInNode_query on User
      @refetchable(queryName: "TestPaginationInNodeRefetchQuery")
      @argumentDefinitions(
        onlineStatuses: { type: "[OnlineStatus!]" }
        count: { type: "Int", defaultValue: 2 }
        cursor: { type: "String", defaultValue: "" }
      ) {
      friendsConnection(
        statuses: $onlineStatuses
        first: $count
        after: $cursor
      ) @connection(key: "TestPaginationInNode_friendsConnection") {
        edges {
          node {
            id
            ...TestPaginationInNode_user
          }
        }
      }
    }
|}
];

module UserDisplayer = {
  [@react.component]
  let make = (~user) => {
    let data = UserFragment.use(user);

    React.string(
      "User "
      ++ data.firstName
      ++ " has "
      ++ data.friendsConnection.totalCount->string_of_int
      ++ " friends",
    );
  };
};

module UserNodeDisplayer = {
  [@react.component]
  let make = (~queryRef) => {
    let (_, startTransition) = TestsUtils.useTransition();
    switch (Fragment.usePagination(queryRef)) {
    | {data, hasNext, loadNext, isLoadingNext, refetch, _} =>
      <div>
        {data.friendsConnection
         ->Fragment.getConnectionNodes
         ->(
             Belt.Array.map(user =>
               <div key={user.id}>
                 <UserDisplayer user={user.fragmentRefs} />
               </div>
             )
           )
         ->React.array}
        {if (hasNext) {
           <button
             onClick={_ =>
               loadNext(
                 ~count=2,
                 ~onComplete=
                   x =>
                     switch (x) {
                     | Some(e) => Js.Console.error(e)
                     | None => ()
                     },
                 (),
               )
               |> ignore
             }>
             {React.string(
                if (isLoadingNext) {"Loading..."} else {"Load more"},
              )}
           </button>;
         } else {
           React.null;
         }}
        <button
          onClick={_ =>
            startTransition(() =>
              refetch(
                ~variables=
                  Fragment.makeRefetchVariables(
                    ~onlineStatuses=Some([|`Online, `Idle|]),
                    (),
                  ),
                (),
              )
              ->Melange_relay.Disposable.ignore
            )
          }>
          {React.string("Refetch connection")}
        </button>
      </div>
    };
  };
};

module Test = {
  [@react.component]
  let make = () => {
    let userId = "123";
    let query = Query.use(~variables={userId: userId}, ());
    switch (query.node) {
    | Some(node) => <UserNodeDisplayer queryRef={node.fragmentRefs} />
    | None => React.string("-")
    };
  };
};

[@live]
let test_pagination = () => {
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
