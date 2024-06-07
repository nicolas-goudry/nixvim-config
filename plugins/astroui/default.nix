# homepage: https://github.com/AstroNvim/astroui
{ helpers, lib, pkgs, ... }:

let
  icons = import ./icons.nix;
  status = import ./status;
in
{
  extra = {
    packages = [
      (import ./package { inherit lib pkgs; })
    ];

    config = ''
      require('astroui').setup({
        icons = ${helpers.toLuaObject icons},
        status = ${helpers.toLuaObject status},
      })
    '';
  };
}
