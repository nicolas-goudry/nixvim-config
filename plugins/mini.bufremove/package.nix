{ pkgs, ... }:

let
  version = "unstable-20240525";
in
pkgs.vimUtils.buildVimPlugin {
  inherit version;

  name = "mini.bufremove";

  src = pkgs.fetchFromGitHub {
    owner = "echasnovski";
    repo = "mini.bufremove";
    rev = "e6044aa28e61d4dd9ec86194d6f81743eced0c1c";
    hash = "sha256-IbX6pCFVdLSeOfCt7GbqOMLRLFqNiaBEnB6TXaumz8o=";
  };
}
