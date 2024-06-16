# homepage: https://github.com/tris203/precognition.nvim
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package { inherit lib pkgs; })
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
      action.__raw = ''
        function()
          local visible = require("precognition").toggle()
          vim.notify(("precognition %s"):format(visible and "on" or "off"))
        end
      '';
      options.desc = "Toggle precognition";
    }
  ];
}
