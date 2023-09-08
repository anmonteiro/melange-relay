module Query = [%relay
  {|
    query TestLocalPayloadQuery @raw_response_type {
      loggedInUser {
        id
        ...TestLocalPayload_user
      }
    }
|}
];

module ViaNodeInterface = [%relay
  {|
    query TestLocalPayloadViaNodeInterfaceQuery($id: ID!) @raw_response_type {
      node(id: $id) {
        ... on User {
          ...TestLocalPayload_user
        }
      }
    }
|}
];

module Fragment = [%relay
  {|
  fragment TestLocalPayload_user on User {
    firstName
    avatarUrl
    onlineStatus
    memberOf {
      ... on Group {
        name
        topMember {
          ... on User {
            firstName
          }
        }
      }
      ... on User {
        firstName
      }
    }
    memberOfSingular {
      ... on Group {
        name
      }
      ... on User {
        firstName
      }
    }
  }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let environment = Melange_relay.useEnvironmentFromContext();
    let data = Query.use(~variables=(), ());
    let user = Fragment.use(data.loggedInUser.fragmentRefs);

    <div>
      <div> {React.string("Firstname: " ++ user.firstName)} </div>
      <div>
        {React.string(
           "Avatar: "
           ++ (
             switch (user.avatarUrl) {
             | Some(avatarUrl) => avatarUrl
             | None => "-"
             }
           ),
         )}
      </div>
      <div>
        {React.string(
           {|Member of: |}
           ++ (
             switch (
               user.memberOf
               ->(Belt.Option.getWithDefault([||]))
               ->(Belt.Array.keepMap(v => v))
               ->(Belt.Array.get(0))
             ) {
             | Some(`Group({name, topMember})) =>
               (({|Group |} ++ name) ++ {|, top member: |})
               ++ (
                 switch (topMember) {
                 | Some(`User({firstName})) => firstName
                 | _ => "-"
                 }
               )
             | Some(`User({firstName})) => {|User |} ++ firstName
             | _ => "-"
             }
           ),
         )}
      </div>
      <div>
        {React.string(
           {|(singular) Member of: |}
           ++ (
             switch (user.memberOfSingular) {
             | Some(`Group({name})) => {|Group |} ++ name
             | Some(`User({firstName})) => {|User |} ++ firstName
             | _ => "-"
             }
           ),
         )}
      </div>
      <button
        onClick={_ =>
          Query.commitLocalPayload(
            ~environment,
            ~variables=(),
            ~payload={
              loggedInUser: {
                id: data.loggedInUser.id,
                onlineStatus: Some(`Online),
                firstName: "AnotherFirst",
                avatarUrl: None,
                memberOf: None,
                memberOfSingular:
                  Some(
                    `Group({
                      name: "Another Group",
                      id: "group-2",
                      __typename: `Group,
                      __isNode: `Group,
                    }),
                  ),
              },
            },
          )
        }>
        {React.string("Update locally")}
      </button>
      <button
        onClick={_ =>
          ViaNodeInterface.commitLocalPayload(
            ~environment,
            ~variables={id: data.loggedInUser.id},
            ~payload={
              node:
                Some({
                  id: data.loggedInUser.id,
                  firstName: "AnotherFirst",
                  onlineStatus: Some(`Online),
                  avatarUrl: None,
                  __typename: `User,
                  memberOfSingular: None,
                  memberOf:
                    Some([|
                      Some(
                        `Group({
                          name: "Some Group",
                          __typename: `Group,
                          __isNode: `Group,
                          id: "group-1",
                          topMember:
                            Some(
                              `User({
                                firstName: "Some User",
                                id: "user-2",
                                __typename: `User,
                                __isNode: `User,
                              }),
                            ),
                        }),
                      ),
                    |]),
                }),
            },
          )
        }>
        {React.string("Update locally via Node interface")}
      </button>
    </div>;
  };
};

[@live]
let test_query = () => {
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
