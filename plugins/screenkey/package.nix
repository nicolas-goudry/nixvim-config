{ pkgs, ... }:

let
  version = "2.1.0";
in
pkgs.vimUtils.buildVimPlugin {
  inherit version;

  name = "screenkey.nvim";

  src = pkgs.fetchFromGitHub {
    owner = "NStefan002";
    repo = "screenkey.nvim";
    rev = "v${version}";
    hash = "sha256-kdZ5GMFyKbzHEn/Bm4r76vauPillvbKJX7yI8MJxGEo=";
  };
}
