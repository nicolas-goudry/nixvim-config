# homepage: https://github.com/goolord/alpha-nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/alpha/index.html
{ helpers, icons, pkgs, ... }:

let
  header = {
    type = "text";

    # Use color defined by catppuccin
    opts = {
      hl = "AlphaHeader";
      position = "center";
    };

    # Generated from https://www.asciiart.eu/text-to-ascii-art
    # Font used: Graffiti
    val = [
      "  ________  ____   ____.___   _____   "
      " /  _____/  \\   \\ /   /|   | /     \\  "
      "/   \\  ___   \\   Y   / |   |/  \\ /  \\ "
      "\\    \\_\\  \\   \\     /  |   /    Y    \\"
      " \\______  / /\\ \\___/   |___\\____|__  /"
      "        \\/  \\/                     \\/ "
    ];
  };

  buttons = {
    type = "group";
    opts.spacing = 1;

    # Use function defined in lua config (see extra.config) to generate buttons
    val = [
      { __raw = "alpha_button('LDR s l', '${icons.Refresh}  Last Session')"; }
      { __raw = "alpha_button('LDR e  ', '${icons.FolderOpen}  Explorer')"; }
      { __raw = "alpha_button('LDR f o', '${icons.DefaultFile}  Recents')"; }
      { __raw = "alpha_button('LDR f f', '${icons.Search}  Find File')"; }
      { __raw = "alpha_button('LDR f g', '${icons.WordFile}  Live Grep')"; }
      { __raw = "alpha_button('LDR n  ', '${icons.FileNew}  New File')"; }
    ];
  };

  # Show random fortune as footer
  footer = {
    type = "text";

    # Defined by Alpha
    # https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/fortune.lua
    val.__raw = "require('alpha.fortune')()";

    # Use color defined by catppuccin
    opts = {
      hl = "AlphaFooter";
      position = "center";
    };
  };

  layout = [
    # Padding size depending on window height (taken from AstroNvim)
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/alpha.lua#L141
    {
      type = "padding";
      val.__raw = "vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }";
    }
    header
    { type = "padding"; val = 5; }
    buttons
    { type = "padding"; val = 3; }
    footer
  ];
in
{
  extra = {
    packages = with pkgs.vimPlugins; [
      alpha-nvim
      nvim-web-devicons
    ];

    # Based on Alpha dashboard theme with tweaks from AstroNvim
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/alpha.lua#L86-L112
    # https://github.com/goolord/alpha-nvim/blob/main/lua/alpha/themes/dashboard.lua#L46-L73
    config = ''
      local alpha_leader = "LDR"

      function alpha_button(shortcut, desc, keybind, keybind_opts)
        local sc = shortcut:gsub("%s", ""):gsub(alpha_leader, "<leader>")

        local real_leader = vim.g.mapleader
        if real_leader == " " then real_leader = "SPC" end

        local opts = {
          position = "center",
          shortcut = shortcut:gsub(alpha_leader, real_leader),
          cursor = -2,
          width = 36,
          align_shortcut = "right",
          hl = "AlphaButtons",
          hl_shortcut = "AlphaShortcut",
        }

        if keybind then
          keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true, desc = desc })
          opts.keymap = { "n", sc, keybind, keybind_opts }
        end

        local function on_press()
          local key = vim.api.nvim_replace_termcodes(keybind or sc .. "<ignore>", true, false, true)
          vim.api.nvim_feedkeys(key, "t", false)
        end

        return {
          type = "button",
          val = desc,
          on_press = on_press,
          opts = opts,
        }
      end

      require("alpha").setup({
        layout = ${helpers.toLuaObject layout},
      })
    '';
  };

  rootOpts = {
    autoGroups.alpha = { };

    # Custom autocommand (taken from AstroNvim)
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/alpha.lua#L19-L43
    autoCmd = [
      {
        desc = "Disable status, tablines and cmdheight for alpha";
        event = [ "User" "BufWinEnter" ];
        group = "alpha";

        callback.__raw = ''
          function(event)
            if
              (
                (event.event == "User" and event.file == "AlphaReady")
                or (event.event == "BufWinEnter" and vim.bo[event.buf].filetype == "alpha")
              ) and not vim.g.before_alpha
            then
              vim.g.before_alpha = {
                showtabline = vim.opt.showtabline:get(),
                laststatus = vim.opt.laststatus:get(),
                cmdheight = vim.opt.cmdheight:get(),
              }
              vim.opt.showtabline, vim.opt.laststatus, vim.opt.cmdheight = 0, 0, 0
            elseif vim.g.before_alpha and event.event == "BufWinEnter" and vim.bo[event.buf].buftype ~= "nofile" then
              vim.opt.laststatus, vim.opt.showtabline, vim.opt.cmdheight =
                vim.g.before_alpha.laststatus, vim.g.before_alpha.showtabline, vim.g.before_alpha.cmdheight
              vim.g.before_alpha = nil
            end
          end
        '';
      }
    ];

    colorschemes.catppuccin.settings = {
      # Enable catppuccin colors
      # https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/alpha.lua
      integrations.alpha = true;

      # Override default catppuccin header color
      custom_highlights = ''
        function(colors)
          return {
            AlphaHeader = { fg = colors.red },
          }
        end
      '';
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>h";
        options.desc = "Home screen";

        # Open alpha in a non neo-tree window (taken from AstroNvim)
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/alpha.lua#L10-L16
        action.__raw = ''
          function()
            local wins = vim.api.nvim_tabpage_list_wins(0)
            if #wins > 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
              vim.fn.win_gotoid(wins[2])
            end
            require("alpha").start(false)
          end
        '';
      }
    ];
  };
}
