# homepage: https://github.com/NStefan002/screenkey.nvim
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package.nix { inherit lib pkgs; })
    ];
  };
}
