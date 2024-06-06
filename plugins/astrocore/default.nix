# homepage: https://github.com/AstroNvim/astrocore
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package { inherit lib pkgs; })
    ];

    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_options.lua#L49-L53
    config = ''
      local g = {}
      g.markdown_recommended_style = 0

      if not vim.t.bufs then vim.t.bufs = vim.api.nvim_list_bufs() end -- initialize buffer list

      require('astrocore').setup({
        g = {
          markdown_recommended_style = 0,
        },
        t = {
          bufs = vim.t.bufs,
        },
      })
    '';
  };
}
