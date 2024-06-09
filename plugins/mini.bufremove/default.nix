{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package.nix { inherit lib pkgs; })
    ];

    config = ''
      require("mini.bufremove").setup()
    '';
  };
}
