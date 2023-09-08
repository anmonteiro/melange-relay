module Query = [%relay
  {|
    query TestFragmentQuery {
      loggedInUser {
        ...TestFragment_user
        ...TestFragment_inline
        ...TestFragment_allowUnsafeEnum
      }
      users {
        edges {
          node {
            id
            onlineStatus
            ...TestFragment_plural_user
          }
        }
      }
    }
|}
];

module SubFragment = [%relay
  {|
    fragment TestFragment_sub_user on User @rescriptRelayIgnoreUnused {
      lastName
    }
|}
];

module Fragment = [%relay
  {|
    fragment TestFragment_user on User {
      __id
      firstName
      onlineStatus
      ...TestFragment_sub_user
    }
|}
];

module InlineFragment = [%relay
  {|
    fragment TestFragment_inline on User @inline {
      firstName
      onlineStatus
    }
|}
];

module AllowUnsafeEnumFragment = [%relay
  {|
    fragment TestFragment_allowUnsafeEnum on User {
      firstName
      onlineStatus @rescriptRelayAllowUnsafeEnum
    }
|}
];

module PluralFragment = [%relay
  {|
    fragment TestFragment_plural_user on User @relay(plural: true) {
      id
      firstName
      onlineStatus
    }
|}
];

module TestPlural = {
  [@react.component]
  let make = (~users) => {
    let allUsers = PluralFragment.use(users);

    <div>
      {allUsers
       ->(
           Belt.Array.map(user =>
             <div key={user.id}>
               {React.string(
                  user.firstName
                  ++ " is "
                  ++ (
                    switch (user.onlineStatus) {
                    | Some(`Online) => "online"
                    | Some(`Offline) => "offline"
                    | _ => "-"
                    }
                  ),
                )}
             </div>
           )
         )
       ->React.array}
    </div>;
  };
};

module Test = {
  [@react.component]
  let make = () => {
    let query = Query.use(~variables=(), ());
    let data = Fragment.use(query.loggedInUser.fragmentRefs);

    let (useOpt, setUseOpt) = React.useState(() => false);
    let (dataViaInline, setDataViaInline) = React.useState(() => None);

    let dataOpt =
      Fragment.useOpt(
        if (useOpt) {
          Some(query.loggedInUser.fragmentRefs);
        } else {
          None;
        },
      );
    let withUnsafeEnumOpt =
      AllowUnsafeEnumFragment.useOpt(
        if (useOpt) {
          Some(query.loggedInUser.fragmentRefs);
        } else {
          None;
        },
      );

    let _justToCheckThingsWork =
      switch (withUnsafeEnumOpt) {
      | Some(data) =>
        switch (data.onlineStatus) {
        | None
        | Some(`Online) => "Online"
        | Some(`Offline) => "Offline"
        | Some(`Idle) => "Idle"
        }
      | None => ""
      };

    let users =
      switch (query) {
      | {users: Some({edges: Some(edges)})} =>
        edges->(
                 Belt.Array.keepMap(edge =>
                   switch (edge) {
                   | Some({node: Some(node)}) => Some(node.fragmentRefs)
                   | _ => None
                   }
                 )
               )
      | _ => [||]
      };

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
      {switch (users->Belt.Array.length) {
       | 0 => React.null
       | _ => <TestPlural users />
       }}
      <button onClick={_ => setUseOpt(last => !last)}>
        {React.string(if (useOpt) {"Hide opt"} else {"Use opt"})}
      </button>
      {switch (dataOpt) {
       | Some(data) =>
         <div> {React.string(data.firstName ++ " is here!")} </div>
       | None => <div> {React.string("Opt not activated")} </div>
       }}
      {switch (dataViaInline) {
       | None => React.null
       | Some(data) =>
         <div>
           {(
              "Inline data: "
              ++ [%obj
                   {
                     firstName: data.InlineFragment.Types.firstName,
                     onlineStatus: data.onlineStatus,
                   }
                 ]
                 ->Js.Json.stringifyAny
                 ->(Belt.Option.getWithDefault(""))
            )
            ->React.string}
         </div>
       }}
      <button
        onClick={_ =>
          setDataViaInline(_ =>
            Some(InlineFragment.readInline(query.loggedInUser.fragmentRefs))
          )
        }>
        {React.string("Set data via inline")}
      </button>
    </div>;
  };
};

[@live]
let test_fragment = () => {
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
