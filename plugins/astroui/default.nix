# homepage: https://github.com/AstroNvim/astroui
{ helpers, icons, lib, pkgs, ... }:

let
  status = import ./status;
in
{
  extra = {
    packages = [
      (import ./package.nix { inherit lib pkgs; })
    ];

    config = ''
      require('astroui').setup({
        icons = ${helpers.toLuaObject icons},
        status = ${helpers.toLuaObject status},
      })
    '';
  };
}
