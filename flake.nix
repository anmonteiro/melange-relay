{
  description = "melange-relay Nix Flake";

  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs = {
    # url = "github:nix-ocaml/nix-overlays";
    url = "/Users/anmonteiro/monorepo/nix-overlays";
    inputs.flake-utils.follows = "flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      nix-filter,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages."${system}".appendOverlays [
          (self: super: {
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_3;
          })
        ];
        inherit (pkgs)
          nodejs_latest
          lib
          stdenv
          ;
      in
      rec {
        packages = {
          default =
            with pkgs.ocamlPackages;
            buildDunePackage {
              pname = "melange-relay";
              version = "dev";

              src = ./.;
              nativeBuildInputs = [
                pkgs.ocamlPackages.melange
                reason
              ];
              nativeCheckInputs = [ nodejs_latest ];
              checkInputs = [
                melange-fetch
                nodejs_latest
              ];
              doCheck = true;
              propagatedBuildInputs = [
                melange
                reason-react
                reason-react-ppx
                graphql_parser
              ];
            };
        };
        defaultPackage = packages.native.piaf;
        devShells.default = pkgs.mkShell {
          inputsFrom = [ packages.default ];
          nativeBuildInputs =
            with pkgs;
            [
              pkg-config
              yarn
              cargo
              nodejs_latest
              rustfmt
            ]
            ++ (with pkgs.ocamlPackages; [
              ocamlformat
              merlin
            ]);
          propagatedBuildInputs = lib.optionals stdenv.isDarwin [
            pkgs.libiconv
          ];
          shellHook = ''
            PATH=$PATH:$PWD/melange-relay-compiler/compiler/target/debug
          '';
        };
      }
    );
}
