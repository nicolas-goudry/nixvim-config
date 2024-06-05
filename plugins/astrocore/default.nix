# homepage: https://github.com/AstroNvim/astrocore
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package { inherit lib pkgs; })
    ];

    config = "require('astrocore').setup({})";
  };
}
