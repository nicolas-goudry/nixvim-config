# homepage: https://github.com/windwp/nvim-autopairs
{ pkgs, ... }:

{
  extra = {
    packages = [ pkgs.vimPlugins.nvim-autopairs ];

    # Config (taken from AstroNvim)
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/autopairs.lua#L14-L25
    # With cmp integration
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/configs/nvim-autopairs.lua#L10
    config = ''
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = { java = false },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = ([[ [%'%"%)%>%]%)%}%,] ]]):gsub("%s+", ""),
          offset = 0,
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      --- TODO: uncomment when cmp is setup
      ---require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done { tex = false })
    '';
  };

  rootOpts.keymaps = [
    {
      key = "<leader>ua";

      # https://github.com/AstroNvim/astrocore/blob/v1.4.0/lua/astrocore/toggles.lua#L37-L50
      action.__raw = ''
        function()
          local ok, autopairs = pcall(require, "nvim-autopairs")
          if ok then
            if autopairs.state.disabled then
              autopairs.enable()
            else
              autopairs.disable()
            end
          end
        end
      '';
      options.desc = "Toggle autopairs";
    }
  ];
}
