# homepage: https://github.com/brenoprata10/nvim-highlight-colors
{ icons, pkgs, ... }:

{
  extra = {
    packages = [ pkgs.vimPlugins.nvim-highlight-colors ];

    config = ''
      require("nvim-highlight-colors").setup({
        render = "virtual",
        virtual_symbol = "${icons.FileModified}",
        virtual_symbol_position = "eow",
        virtual_symbol_prefix = " ",
        virtual_symbol_suffix = "",
      })
    '';
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>uz";
      action = "<cmd>HighlightColors Toggle<cr>";
      options.desc = "Toggle color highlight";
    }
  ];
}
