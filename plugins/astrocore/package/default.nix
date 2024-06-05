{ pkgs, ... }:

let
  version = "1.5.0";
in
pkgs.vimUtils.buildVimPlugin {
  inherit version;

  name = "astrocore";

  src = pkgs.fetchFromGitHub {
    owner = "astronvim";
    repo = "astrocore";
    rev = "v${version}";
    hash = "sha256-KKNglNd3S8E11CMAS6E3vhN4oZoRh0u3rjkgHiIGozI=";
  };

  patches = [
    ./init.lua.patch
    ./mason.lua.patch
  ];
}
