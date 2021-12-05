type CombyCommand = {
  command: string;
  description: string;
};

export type Migration = {
  rescriptRelayVersion: string;
  combyCommands: CombyCommand[];
  relayVersion?: string | null;
  reactVersion?: string | null;
};
