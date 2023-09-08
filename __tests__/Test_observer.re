module Query = [%relay
  {|
  query TestObserverQuery {
    loggedInUser {
      id
    }
  }
|}
];

module Test = {
  [@react.component]
  let make = () => {
    let data = Query.use(~variables=(), ());

    <div> {React.string(data.loggedInUser.id)} </div>;
  };
};

[@live]
let test_observer = () => {
  let network =
    Melange_relay.Network.makeObservableBased(
      ~observableFunction=
        (_, _, _, _) =>
          Melange_relay.Observable.make(sink => {
            try(Js.Exn.raiseError("Some error")) {
            | Js.Exn.Error(obj) =>
              sink.error(. obj);
              sink.complete(.);
            };

            None;
          }),
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

  <ReasonReactErrorBoundary fallback={_ => React.string("Failed")}>
    <TestProviders.Wrapper environment> <Test /> </TestProviders.Wrapper>
  </ReasonReactErrorBoundary>;
};
