import { Command } from "commander";
import ora from "ora";
import path from "path";
import fs from "fs";
import { currentRescriptRelayVersion } from "../rescriptRelayVersion";
import { getMigrationForVersion } from "../migrations/migrations";

export const addUpgradeCommand = (program: Command) => {
  program
    .command("upgrade")
    .argument(
      "<version>",
      "A specific version to run the migration for, if wanted."
    )
    .description("Attempts to help you upgrading to the latest version.")
    .action(async (version: string | undefined | null) => {
      // Being able to run this command means the main package is installed, so we
      // don't need to care about that.
      const spinner = ora("Setting up RescriptRelay...").start();

      let rescriptRelayVersion: string | null = null;

      if (version == null) {
        const packageJsonRaw = fs.readFileSync(
          path.resolve(process.cwd(), "package.json"),
          "utf8"
        );

        let packageJsonParsed: Record<string, any> = {};

        try {
          packageJsonParsed = JSON.parse(packageJsonRaw);
        } catch (e) {
          console.error(e);
          spinner.fail(
            "Could not load package.json. This command needs to run in the same directory as package.json is located."
          );
          return;
        }

        const findRescriptRelayVersion = (
          pkgs: Record<string, string>
        ): string | null => {
          return pkgs["rescript-relay"] ?? null;
        };

        rescriptRelayVersion =
          findRescriptRelayVersion(packageJsonParsed["dependencies"]) ??
          findRescriptRelayVersion(packageJsonParsed["devDependencies"]) ??
          findRescriptRelayVersion(packageJsonParsed["peerDependencies"]);

        if (rescriptRelayVersion == null) {
          spinner.fail("Could not figure out RescriptRelay version.");
          return;
        }

        if (!/^\d/.test(rescriptRelayVersion)) {
          spinner.fail(
            `This upgrade tool only works when setting an exact version of RescriptRelay in package.json. Found version '${rescriptRelayVersion}'.`
          );
          return;
        }
      }

      if (rescriptRelayVersion == null) {
        spinner.fail(
          "Could not figure out RescriptRelay version to upgrade to."
        );
        return;
      }

      const targetMigration = getMigrationForVersion(
        version ?? currentRescriptRelayVersion
      );
    });
};
