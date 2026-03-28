{
  description = "A Nix flake for the Helium browser built natively from source";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        helium = pkgs.libsForQt5.callPackage ./chromium {
          ungoogled = true;
        };

      in {
        packages.default = helium;
        packages.helium = helium;

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/chromium";
        };
        apps.helium = self.apps.${system}.default;

        devShells.default = pkgs.mkShell {
          buildInputs = [ helium ];
        };
      }
    );
}
