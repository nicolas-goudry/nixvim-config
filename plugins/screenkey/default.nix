# homepage: https://github.com/NStefan002/screenkey.nvim
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package.nix { inherit lib pkgs; })
    ];
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>uk";
      action.__raw = ''
        function()
          vim.g.screenkey_statusline_component = not vim.g.screenkey_statusline_component
          vim.api.nvim_exec_autocmds("User", { pattern = "ScreenkeyToggled" })
          vim.notify(("screenkey %s"):format(vim.g.screenkey_statusline_component and "on" or "off"))
        end
      '';
      options.desc = "Toggle screenkey";
    }
  ];
}
