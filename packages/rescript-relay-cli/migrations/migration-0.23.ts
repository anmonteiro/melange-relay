import { Migration } from "./migrationTypes";

const migration: Migration = {
  rescriptRelayVersion: "0.23.0",
  combyCommands: [
    {
      description: "Migrate unstable_useTransition",
      command:
        "comby 'let (:[1], :[2]) = ReactExperimental.unstable_useTransition()' 'let (:[2], :[1]) = ReactExperimental.useTransition()' .res -matcher .re -exclude-dir node_modules -review",
    },
    {
      description: "Migrate unstable_useDeferredValue",
      command:
        "comby 'ReactExperimental.unstable_useDeferredValue(:[1])' 'ReactExperimental.useDeferredValue(:[1])' .res -matcher .re -exclude-dir node_modules -review",
    },
    {
      description: "Migrate renderConcurrentRootAtElementWithId",
      command:
        "comby 'ReactExperimental.renderConcurrentRootAtElementWithId' 'ReactDOMExperimental.renderConcurrentRootAtElementWithId' .res -matcher .re -exclude-dir node_modules -review",
    },
  ],
  reactVersion: "0.0.0-experimental-d174d063d-20210922",
  relayVersion: "12.0.0",
};

export default migration;
