# homepage: https://github.com/tris203/precognition.nvim
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package.nix { inherit lib pkgs; })
    ];

    config = ''
      require("precognition").setup({
        showBlankVirtLine = false,
      })
    '';
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>uc";
      action = "<cmd>Precognition toggle<cr>";
      options.desc = "Toggle precognition";
    }
  ];
}
