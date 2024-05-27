_:

{
  imports = [
    ./config
    ./plugins
  ];

  config = {
    # Needed for telescope live grep
    extraPackages = [ pkgs.ripgrep ];

    # Use <Space> as leader key
    globals.mapleader = " ";

    # Set 'vi' and 'vim' aliases to nixvim
    viAlias = true;
    vimAlias = true;

    # Setup clipboard support
    clipboard = {
      # Use xsel as clipboard provider
      providers.xsel.enable = true;

      # Sync system clipboard
      register = "unnamedplus";
    };
  };
}
