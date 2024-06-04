{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package { inherit lib pkgs; })
    ];

    config = "require('astrocore').setup({})";
  };
}
