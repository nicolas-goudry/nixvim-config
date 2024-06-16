{ pkgs, ... }:

{
  extra = {
    packages = [ pkgs.vimPlugins.vim-wakatime ];
    # TODO: auto-configure API key from sops
    # (not sure if this is possible though)
    #config = "";
  };
}
