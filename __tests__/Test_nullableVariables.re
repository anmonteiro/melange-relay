module Query = [%relay
  {|
    query TestNullableVariablesQuery {
      loggedInUser {
        avatarUrl
      }
    }
|}
];

module Mutation = [%relay
  {|
    mutation TestNullableVariablesMutation($avatarUrl: String, $someInput: SomeInput) @melangeRelayNullableVariables {
      updateUserAvatar(avatarUrl: $avatarUrl) {
        user {
          avatarUrl
          someRandomArgField(someInput: $someInput)
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
    let data = query.loggedInUser;

    <div>
      {React.string(
         "Avatar url is " ++ data.avatarUrl->(Belt.Option.getWithDefault("-")),
       )}
      <button
        onClick={_ =>
          Mutation.commitMutation(
            ~environment,
            ~variables={
              avatarUrl: Js.null,
              someInput:
                Js.Null.return(
                  RelaySchemaAssets_graphql.input_SomeInput_nullable(
                    ~int=Js.null,
                    (),
                  ),
                ),
            },
            (),
          )
          ->Melange_relay.Disposable.ignore
        }>
        {React.string("Change avatar URL")}
      </button>
    </div>;
  };
};

[@live]
let test_nullableVariables = () => {
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
