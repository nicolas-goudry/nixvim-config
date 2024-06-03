{ lib, pkgs, ... }:

{
  extra.packages = [
    (import ./package { inherit lib pkgs; })
  ];
}
