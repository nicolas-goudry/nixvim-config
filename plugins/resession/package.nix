{ pkgs, ... }:

let
  version = "1.2.1";
in
pkgs.vimUtils.buildVimPlugin {
  inherit version;

  name = "resession-nvim";

  src = pkgs.fetchFromGitHub {
    owner = "stevearc";
    repo = "resession.nvim";
    rev = "v${version}";
    hash = "sha256-GXKDuKDMcfl1SHTTdUFdWuWbtq6TDtk0GsyI3fAc1vE=";
  };
}
