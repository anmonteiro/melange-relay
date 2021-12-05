import { Migration } from "./migrationTypes";
import m_0_23_0 from "./migration-0.23";

export const getMigrationForVersion = (version: string): Migration | null => {
  return [m_0_23_0].find((m) => m.rescriptRelayVersion === version) ?? null;
};
