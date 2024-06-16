{ pkgs, ... }:

let
  version = "1.0.0";
in
pkgs.vimUtils.buildVimPlugin {
  inherit version;

  name = "precognition";

  src = pkgs.fetchFromGitHub {
    owner = "tris203";
    repo = "precognition.nvim";
    rev = "v${version}";
    hash = "sha256-AqWYV/59ugKyOWALOCdycWVm0bZ7qb981xnuw/mAVzM=";
  };

  patches = [
    ./init.lua.patch
  ];
}
