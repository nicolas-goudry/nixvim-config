# homepage: https://github.com/folke/which-key.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/which-key/index.html
_:

{
  opts = {
    enable = true;
    icons.group = "";
    window.border = "single";

    # Disable which-key when in neo-tree or telescope
    disable.filetypes = [
      "TelescopePrompt"
      "neo-tree"
      "neo-tree-popup"
    ];
  };

  # Enable catppuccin colors
  # https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/which_key.lua
  rootOpts.colorschemes.catppuccin.settings.integrations.which_key = true;
}
