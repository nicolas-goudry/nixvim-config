# homepage: https://github.com/akinsho/toggleterm.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/toggleterm/index.html
_:

{
  opts = {
    enable = true;

    settings = {
      direction = "float";
      float_opts.border = "rounded";
      shading_factor = 2;
      size = 10;

      highlights = {
        Normal.link = "Normal";
        NormalNC.link = "NormalNC";
        NormalFloat.link = "NormalFloat";
        FloatBorder.link = "FloatBorder";
        StatusLine.link = "StatusLine";
        StatusLineNC.link = "StatusLineNC";
        WinBar.link = "WinBar";
        WinBarNC.link = "WinBarNC";
      };

      # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/toggleterm.lua#L66-L74
      on_create = ''
        function(t)
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
          if t.hidden then
            vim.keymap.set({ "n", "t", "i" }, "<F7>", function() t:toggle() end, { desc = "Toggle terminal", buffer = t.bufnr })
          end
          local term_name = rndname()
          vim.cmd(t.id .. "ToggleTermSetName " .. term_name)
        end
      '';
    };
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<Leader>tf";
      action = "<Cmd>ToggleTerm direction=float<CR>";
      options.desc = "Open floating terminal";
    }
    {
      mode = "n";
      key = "<Leader>th";
      action = "<Cmd>ToggleTerm size=10 direction=horizontal<CR>";
      options.desc = "Open terminal in horizontal split";
    }
    {
      mode = "n";
      key = "<Leader>tv";
      action = "<Cmd>ToggleTerm size=80 direction=vertical<CR>";
      options.desc = "Open terminal in vertical split";
    }
    {
      mode = "n";
      key = "<F7>";
      action = "<Cmd>execute v:count . 'ToggleTerm'<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "t";
      key = "<F7>";
      action = "<Cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "i";
      key = "<F7>";
      action = "<Esc><Cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Switch to normal mode";
    }
    {
      mode = [ "n" "t" ];
      key = "<Leader>tn";
      action.__raw = ''
        function()
          local curterm = require("toggleterm.terminal").get_focused_id()

          if curterm ~= nil then
            vim.cmd(curterm .. "ToggleTermSetName")
          end
        end
      '';
      options.desc = "Rename current terminal";
    }
    {
      mode = [ "n" "t" ];
      key = "<Leader>tl";
      action = "<cmd>TermSelect<cr>";
      options.desc = "List terminals";
    }
  ];
}
