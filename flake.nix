{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        elixir = pkgs.beam.packages.erlang.elixir;
        elixir-ls = pkgs.beam.packages.erlang.elixir_ls;
        locales = pkgs.glibcLocales;
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            elixir
            elixir-ls
            locales
          ];
        };
      });
}
