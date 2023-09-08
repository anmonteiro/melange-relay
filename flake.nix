{
  description = "melange-relay Nix Flake";

  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs = {
    url = "github:nix-ocaml/nix-overlays";
    inputs.flake-utils.follows = "flake-utils";
  };
  inputs.melange = {
    url = "github:melange-re/melange";
    inputs.nix-filter.follows = "nix-filter";
    inputs.flake-utils.follows = "flake-utils";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, nix-filter, melange }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}".appendOverlays [
          (self: super: {
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_1;
          })
          melange.overlays.default
        ];
        inherit (pkgs) melange-relay-compiler nodejs_latest lib stdenv darwin;
      in
      rec {
        packages = {
          default = with pkgs.ocamlPackages; buildDunePackage {
            pname = "melange-relay";
            version = "dev";

            src = ./.;
            nativeBuildInputs = [
              pkgs.ocamlPackages.melange

              melange-relay-compiler
              reason
            ];
            nativeCheckInputs = [ nodejs_latest ];
            checkInputs = [ melange-fetch nodejs_latest ];
            doCheck = true;
            propagatedBuildInputs = [
              pkgs.ocamlPackages.melange
              reason-react
              reason-react-ppx
              graphql_parser
            ];
          };
        };
        defaultPackage = packages.native.piaf;
        devShells.default = pkgs.mkShell {
          inputsFrom = [ packages.default ];
          nativeBuildInputs = with pkgs; [
            pkg-config
            yarn
            cargo
            nodejs_latest
            rustfmt
          ] ++ (with pkgs.ocamlPackages; [
            ocamlformat
            merlin
          ]);
          propagatedBuildInputs = lib.optionals stdenv.isDarwin [
            pkgs.libiconv
            darwin.apple_sdk.frameworks.Security
          ];
        };
      });
}
