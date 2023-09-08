[@live]
let test_subscription:
  unit =>
  {
    .
    "pushNext": Js.Json.t => unit,
    "render": unit => React.element,
    "subscriptionFunction":
      ('b, 'c, 'd) => Melange_relay.Observable.t(Js.Json.t),
  };
