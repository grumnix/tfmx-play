{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = tfmx-play;

          tfmx-play = pkgs.stdenv.mkDerivation rec {
            pname = "tfmx-play";
            version = "1.1.7";

            src = ./.;

            configureFlags = [
              "--with-ssl-dir=${pkgs.openssl.dev}"
            ];

            nativeBuildInputs = with pkgs; [
              autoreconfHook
            ];

            buildInputs = with pkgs; [
              SDL
              openssl
            ];
          };
        };
      }
    );
}
