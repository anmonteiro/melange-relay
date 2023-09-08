module Query = [%relay
  {|
    query TestPaginationUnionQuery($groupId: ID!) {
      ...TestPaginationUnion_query @arguments(groupId: $groupId)
    }
|}
];

module UserFragment = [%relay
  {|
  fragment TestPaginationUnion_user on User {
    firstName
    friendsConnection(first: 1) {
      totalCount
    }
  }
|}
];

module Fragment = [%relay
  {|
    fragment TestPaginationUnion_query on Query
      @refetchable(queryName: "TestPaginationUnionRefetchQuery")
      @argumentDefinitions(
        groupId: { type: "ID!" }
        onlineStatuses: { type: "[OnlineStatus!]" }
        count: { type: "Int", defaultValue: 2 }
        cursor: { type: "String", defaultValue: "" }
      ) {
      members(
        groupId: $groupId
        onlineStatuses: $onlineStatuses
        first: $count
        after: $cursor
      ) @connection(key: "TestPaginationUnion_query_members") {
        edges {
          node {
            ... on User {
              id
              ...TestPaginationUnion_user
            }

            ... on Group {
              id
              name
              adminsConnection(first: 1) {
                edges {
                  node {
                    id
                    firstName
                  }
                }
              }
            }
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

module Test = {
  [@react.component]
  let make = () => {
    let groupId = "123";
    let query = Query.use(~variables={groupId: groupId}, ());

    let (_, startTransition) = ReactExperimental.useTransition();

    // Fragment.get;
    switch (Fragment.usePagination(query.fragmentRefs)) {
    | {data, hasNext, loadNext, isLoadingNext, refetch, _} =>
      <div>
        {data.members
         ->Fragment.getConnectionNodes
         ->(
             Belt.Array.mapWithIndex((i, member) =>
               switch (member) {
               | `User(user) =>
                 <div key={user.id}>
                   <UserDisplayer user={user.fragmentRefs} />
                 </div>
               | `Group(group) =>
                 <div key={group.id}>
                   {React.string(
                      "Group "
                      ++ group.name
                      ++ " with "
                      ++ group.adminsConnection.edges
                         ->(Belt.Option.getWithDefault([||]))
                         ->Belt.Array.length
                         ->string_of_int
                      ++ " admins",
                    )}
                 </div>
               | `UnselectedUnionMember(_) =>
                 <div key={i->string_of_int}>
                   {React.string("Unknown type")}
                 </div>
               }
             )
           )
         ->React.array}
        {if (hasNext) {
           <button onClick={_ => loadNext(~count=2, ())->ignore}>
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
                    ~groupId,
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
