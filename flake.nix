{
  description = "keyboard";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, flake-compat }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages."${system}";
      in rec {
        # `nix develop`
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ openscad leiningen ];
        };
      });
}
