const fs = require("fs");
const path = require("path");
const pkgJson = require("../../rescript-relay/package.json");

if (pkgJson != null) {
  fs.writeFileSync(
    path.resolve(path.join(__dirname, "../rescriptRelayVersion.ts")),
    `export const currentRescriptRelayVersion = "${pkgJson.version}";`
  );
} else {
  throw new Error("Could not write RescriptRelay version.");
}
