module Query = [%relay
  {|
    query TestCustomScalarsQuery($beforeDate: Datetime, $number: Number!) {
      loggedInUser {
        createdAt
        friends(beforeDate: $beforeDate, number: $number) {
          createdAt
        }
      }

      member(id: "user-1") {
        ... on User {
          createdAt
        }
      }
    }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let query =
      Query.use(
        ~variables={
          beforeDate: Some(Js.Date.fromFloat(1514764800000.)),
          number: [|2|],
        },
        (),
      );

    <>
      <div>
        {React.string(
           "loggedInUser createdAt: "
           ++ query.loggedInUser.createdAt->Js.Date.getTime->Js.Float.toString,
         )}
      </div>
      <div>
        {switch (query.member) {
         | Some(`User(user)) =>
           React.string(
             "member createdAt: "
             ++ user.createdAt->Js.Date.getTime->Js.Float.toString,
           )
         | Some(`UnselectedUnionMember(_))
         | None => React.null
         }}
      </div>
    </>;
  };
};

[@live]
let test_customScalars = () => {
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
