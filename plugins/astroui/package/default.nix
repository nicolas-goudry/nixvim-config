{ pkgs, ... }:

let
  version = "2.1.4";
in
pkgs.vimUtils.buildVimPlugin {
  inherit version;

  name = "astroui";

  src = pkgs.fetchFromGitHub {
    owner = "astronvim";
    repo = "astroui";
    rev = "v${version}";
    hash = "sha256-nmcqJq4L6XFrgrORan5x+WCwSfU3FC4D6Zux45YnIUQ=";
  };
}
