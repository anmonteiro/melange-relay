module Wrapper = {
  [@react.component]
  let make = (~environment, ~children) => {
    let children = children;
    ();

    <React.Suspense fallback={<div> {React.string("Loading...")} </div>}>
      <Melange_relay.Context.Provider environment>
        children
      </Melange_relay.Context.Provider>
    </React.Suspense>;
  };
};
