module Query = [%relay
  {|
    query TestSubscriptionQuery {
      loggedInUser {
        ...TestSubscription_user
      }
    }
|}
];

module Fragment = [%relay
  {|
    fragment TestSubscription_user on User {
      id
      firstName
      avatarUrl
      onlineStatus
    }
|}
];

module UserUpdatedSubscription = [%relay
  {|
  subscription TestSubscriptionUserUpdatedSubscription($userId: ID!) {
    userUpdated(id: $userId) {
      user {
        id
        onlineStatus
        ...TestSubscription_user
      }
    }
  }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let environment = Melange_relay.useEnvironmentFromContext();
    let query = Query.use(~variables=(), ());
    let data = Fragment.use(query.loggedInUser.fragmentRefs);
    let (ready, setReady) = React.useState(() => false);

    React.useEffect0(() => {
      let disposable =
        UserUpdatedSubscription.subscribe(
          ~environment,
          ~variables={userId: "user-1"},
          ~updater=
            (store, response) =>
              switch (
                store->(
                         Melange_relay.RecordSourceSelectorProxy.get(
                           ~dataId=Melange_relay.makeDataId(data.id),
                         )
                       ),
                response,
              ) {
              | (
                  Some(userProxy),
                  {
                    userUpdated:
                      Some({
                        user: Some({onlineStatus: Some(onlineStatus), _}),
                      }),
                  },
                ) =>
                userProxy
                ->(
                    Melange_relay.RecordProxy.setValueString(
                      ~name="onlineStatus",
                      ~value=
                        switch (onlineStatus) {
                        | `Idle => "Offline"
                        | _ => "Online"
                        },
                      (),
                    )
                  )
                ->ignore
              | _ => ()
              },
          (),
        );

      setReady(_ => true);

      Some(() => disposable->Melange_relay.Disposable.dispose);
    });

    <div>
      <div>
        {React.string(
           ((ready ? "Ready - " : "") ++ "User ")
           ++ data.firstName
           ++ " is "
           ++ (
             switch (data.onlineStatus) {
             | Some(`Online) => "online"
             | Some(`Offline) => "offline"
             | _ => "-"
             }
           ),
         )}
      </div>
      {switch (data.avatarUrl) {
       | Some(avatarUrl) => <img alt="avatar" src=avatarUrl />
       | None => React.null
       }}
    </div>;
  };
};

[@live]
let test_subscription = () => {
  let subscriptionFns = ref([||]);

  let subscribeToOnNext = nextFn => {
    let _ = subscriptionFns.contents->(Js.Array.push(~value=nextFn));

    () =>
      subscriptionFns.contents =
        subscriptionFns.contents->(Js.Array.filter(~f=fn => fn !== nextFn));
  };

  let pushNext = next =>
    subscriptionFns.contents->(Js.Array.forEach(~f=fn => fn(next)));

  let subscriptionFunction = (_, _, _) =>
    Melange_relay.Observable.make(sink => {
      let unsubscribe = subscribeToOnNext(next => sink.next(. next));
      Some({closed: false, unsubscribe});
    });

  let network =
    Melange_relay.Network.makePromiseBased(
      ~fetchFunction=RelayEnv.fetchQuery,
      ~subscriptionFunction,
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

  [%obj
   {
     pushNext,
     subscriptionFunction,
     render: () =>
       <TestProviders.Wrapper environment> <Test /> </TestProviders.Wrapper>,
   }];
};
