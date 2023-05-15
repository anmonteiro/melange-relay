module Query = [%relay
  {|
  query TestRequiredFieldLoggerQuery {
    loggedInUser {
      firstName @required(action: LOG)
    }
  }
|}
];

module Logger = {
  let loggedValue = ref(None: option(string));

  let log = (~kind, ~owner, ~fieldPath) =>
    loggedValue :=
      Some(
        (
          ((({|kind: |} ++ kind->Obj.magic) ++ {|, owner: |}) ++ owner)
          ++ {|, filedPath:|}
        )
        ++ fieldPath,
      );

  let getLoggedValue = () => loggedValue.contents;

  let expectedValue = "kind: missing_field.log, owner: TestRequiredFieldLoggerQuery, filedPath:loggedInUser.firstName";
};

[@live]
let test_requiredFieldLogger = () => {
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
      ~requiredFieldLogger=Logger.log,
      (),
    );

  Js.Promise.make((~resolve, ~reject as _) =>
    Query.fetch(
      ~environment,
      ~variables=(),
      ~onResult=res => resolve(. res),
      (),
    )
  );
};

let getLoggedValue = Logger.getLoggedValue;

let expectedValue = Logger.expectedValue;
