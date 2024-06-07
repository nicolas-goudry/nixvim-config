let
  forceWrite = {
    action = "<cmd>silent! update! | redraw<cr>";
    options.desc = "Force write";
  };
in
{
  keymaps = [
    # Standard operations
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L27-L44
    {
      key = "j";
      mode = [ "n" "x" ];
      action = "v:count == 0 ? 'gj' : 'j'";

      options = {
        desc = "Move cursor down";
        expr = true;
        silent = true;
      };
    }
    {
      key = "k";
      mode = [ "n" "x" ];
      action = "v:count == 0 ? 'gk' : 'k'";

      options = {
        desc = "Move cursor up";
        expr = true;
        silent = true;
      };
    }
    {
      key = "<leader>w";
      action = "<cmd>w<cr>";
      options.desc = "Save";
    }
    {
      key = "<leader>q";
      action = "<cmd>confirm q<cr>";
      options.desc = "Quit window";
    }
    {
      key = "<leader>Q";
      action = "<cmd>confirm qall<cr>";
      options.desc = "Exit neovim";
    }
    {
      key = "<leader>n";
      action = "<cmd>enew<cr>";
      options.desc = "New file";
    }
    {
      inherit (forceWrite) action options;
      key = "<c-s>";
    }
    {
      inherit (forceWrite) options;
      key = "<c-s>";
      mode = [ "i" "x" ];
      action = "<esc>" + forceWrite.action;
    }
    {
      key = "<c-q>";
      action = "<cmd>q!<cr>";
      options.desc = "Force quit";
    }
    {
      key = "|";
      action = "<cmd>vsplit<cr>";
      options.desc = "Vertical split";
    }
    {
      key = "\\\\";
      action = "<cmd>split<cr>";
      options.desc = "Horizontal split";
    }
    {
      key = "gx";
      action.__raw = "require('astrocore').system_open";
      options.desc = "Open the file under cursor with system app";
    }

    # Manage buffers
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L56-L89
    {
      key = "<leader>c";
      options.desc = "Close buffer";

      action.__raw = ''
        function()
          require("astrocore.buffer").close()
        end
      '';
    }
    {
      key = "<leader>C";
      options.desc = "Force close buffer";

      action.__raw = ''
        function()
          require("astrocore.buffer").close(0, true)
        end
      '';
    }
    {
      key = "]b";
      options.desc = "Next buffer in tabline";

      action.__raw = ''
        function()
          require("astrocore.buffer").nav(vim.v.count1)
        end
      '';
    }
    {
      key = "[b";
      options.desc = "Previous buffer in tabline";

      action.__raw = ''
        function()
          require("astrocore.buffer").nav(-vim.v.count1)
        end
      '';
    }
    {
      key = ">b";
      options.desc = "Move buffer tab right";

      action.__raw = ''
        function()
          require("astrocore.buffer").move(vim.v.count1)
        end
      '';
    }
    {
      key = "<b";
      options.desc = "Move buffer tab left";

      action.__raw = ''
        function()
          require("astrocore.buffer").move(-vim.v.count1)
        end
      '';
    }
    {
      key = "<leader>bc";
      options.desc = "Close all buffers except current";

      action.__raw = ''
        function()
          require("astrocore.buffer").close_all(true)
        end
      '';
    }
    {
      key = "<leader>bC";
      options.desc = "Close all buffers";

      action.__raw = ''
        function()
          require("astrocore.buffer").close_all()
        end
      '';
    }
    {
      key = "<leader>bl";
      options.desc = "Close all buffers to the left";

      action.__raw = ''
        function()
          require("astrocore.buffer").close_left()
        end
      '';
    }
    {
      key = "<leader>bp";
      options.desc = "Previous buffer";

      action.__raw = ''
        function()
          require("astrocore.buffer").prev()
        end
      '';
    }
    {
      key = "<leader>br";
      options.desc = "Close all buffers to the right";

      action.__raw = ''
        function()
          require("astrocore.buffer").close_right()
        end
      '';
    }
    {
      key = "<Leader>bse";
      options.desc = "By extension";

      action.__raw = ''
        function()
          require("astrocore.buffer").sort "extension"
        end
      '';
    }
    {
      key = "<Leader>bsr";
      options.desc = "By relative path";

      action.__raw = ''
        function()
          require("astrocore.buffer").sort "unique_path"
        end
      '';
    }
    {
      key = "<Leader>bsp";
      options.desc = "By full path";

      action.__raw = ''
        function()
          require("astrocore.buffer").sort "full_path"
        end
      '';
    }
    {
      key = "<Leader>bsi";
      options.desc = "By buffer number";

      action.__raw = ''
        function()
          require("astrocore.buffer").sort "bufnr"
        end
      '';
    }
    {
      key = "<Leader>bsm";
      options.desc = "By modification";

      action.__raw = ''
        function()
          require("astrocore.buffer").sort "modified"
        end
      '';
    }

    # Diagnostics
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L92-L100
    {
      key = "<Leader>ld";
      options.desc = "Hover diagnostics";

      action.__raw = ''
        function()
          vim.diagnostic.open_float()
        end
      '';
    }
    {
      key = "[d";
      options.desc = "Previous diagnostic";

      action.__raw = ''
        function()
          vim.diagnostic.goto_prev()
        end
      '';
    }
    {
      key = "]d";
      options.desc = "Next diagnostic";

      action.__raw = ''
        function()
          vim.diagnostic.goto_next()
        end
      '';
    }
    {
      key = "gl";
      options.desc = "Hover diagnostics";

      action.__raw = ''
        function()
          vim.diagnostic.open_float()
        end
      '';
    }

    # Navigate tabs
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L103-L104
    {
      key = "]t";
      options.desc = "Next tab";

      action.__raw = ''
        function()
          vim.cmd.tabnext()
        end
      '';
    }
    {
      key = "[t";
      options.desc = "Previous tab";

      action.__raw = ''
        function()
          vim.cmd.tabprevious()
        end
      '';
    }

    # Split navigation
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L107-L114
    {
      key = "<C-H>";
      action = "<C-w>h";
      options.desc = "Move to left split";
    }
    {
      key = "<C-J>";
      action = "<C-w>j";
      options.desc = "Move to below split";
    }
    {
      key = "<C-K>";
      action = "<C-w>k";
      options.desc = "Move to above split";
    }
    {
      key = "<C-L>";
      action = "<C-w>l";
      options.desc = "Move to right split";
    }
    {
      key = "<C-Up>";
      action = "<Cmd>resize -2<CR>";
      options.desc = "Resize split up";
    }
    {
      key = "<C-Down>";
      action = "<Cmd>resize +2<CR>";
      options.desc = "Resize split down";
    }
    {
      key = "<C-Left>";
      action = "<Cmd>vertical resize -2<CR>";
      options.desc = "Resize split left";
    }
    {
      key = "<C-Right>";
      action = "<Cmd>vertical resize +2<CR>";
      options.desc = "Resize split right";
    }

    # Stay in indent mode
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L117-L118
    {
      key = "<S-Tab>";
      mode = [ "v" ];
      action = "<gv";
      options.desc = "Unindent line";
    }
    {
      key = "<Tab>";
      mode = [ "v" ];
      action = ">gv";
      options.desc = "Indent line";
    }

    # Improved terminal navigation
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L121-L124
    {
      key = "<C-H>";
      mode = [ "t" ];
      action = "<Cmd>wincmd h<CR>";
      options.desc = "Terminal left window navigation";
    }
    {
      key = "<C-J>";
      mode = [ "t" ];
      action = "<Cmd>wincmd j<CR>";
      options.desc = "Terminal down window navigation";
    }
    {
      key = "<C-K>";
      mode = [ "t" ];
      action = "<Cmd>wincmd k<CR>";
      options.desc = "Terminal up window navigation";
    }
    {
      key = "<C-L>";
      mode = [ "t" ];
      action = "<Cmd>wincmd l<CR>";
      options.desc = "Terminal right window navigation";
    }

    # UI/UX toggles
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L128-L145
    {
      key = "<Leader>uA";
      options.desc = "Toggle rooter autochdir";

      action.__raw = ''
        function()
          require("astrocore.toggles").autochdir()
        end
      '';
    }
    {
      key = "<Leader>ub";
      options.desc = "Toggle background";

      action.__raw = ''
        function()
          require("astrocore.toggles").background()
        end
      '';
    }
    {
      key = "<Leader>ud";
      options.desc = "Toggle diagnostics";

      action.__raw = ''
        function()
          require("astrocore.toggles").diagnostics()
        end
      '';
    }
    {
      key = "<Leader>ug";
      options.desc = "Toggle signcolumn";

      action.__raw = ''
        function()
          require("astrocore.toggles").signcolumn()
        end
      '';
    }
    {
      key = "<Leader>u>";
      options.desc = "Toggle foldcolumn";

      action.__raw = ''
        function()
          require("astrocore.toggles").foldcolumn()
        end
      '';
    }
    {
      key = "<Leader>ui";
      options.desc = "Change indent setting";

      action.__raw = ''
        function()
          require("astrocore.toggles").indent()
        end
      '';
    }
    {
      key = "<Leader>ul";
      options.desc = "Toggle statusline";

      action.__raw = ''
        function()
          require("astrocore.toggles").statusline()
        end
      '';
    }
    {
      key = "<Leader>un";
      options.desc = "Change line numbering";

      action.__raw = ''
        function()
          require("astrocore.toggles").number()
        end
      '';
    }
    {
      key = "<Leader>uN";
      options.desc = "Toggle Notifications";

      action.__raw = ''
        function()
          require("astrocore.toggles").notifications()
        end
      '';
    }
    {
      key = "<Leader>up";
      options.desc = "Toggle paste mode";

      action.__raw = ''
        function()
          require("astrocore.toggles").paste()
        end
      '';
    }
    {
      key = "<Leader>us";
      options.desc = "Toggle spellcheck";

      action.__raw = ''
        function()
          require("astrocore.toggles").spell()
        end
      '';
    }
    {
      key = "<Leader>uS";
      options.desc = "Toggle conceal";

      action.__raw = ''
        function()
          require("astrocore.toggles").conceal()
        end
      '';
    }
    {
      key = "<Leader>ut";
      options.desc = "Toggle tabline";

      action.__raw = ''
        function()
          require("astrocore.toggles").tabline()
        end
      '';
    }
    {
      key = "<Leader>uu";
      options.desc = "Toggle URL highlight";

      action.__raw = ''
        function()
          require("astrocore.toggles").url_match()
        end
      '';
    }
    {
      key = "<Leader>uw";
      options.desc = "Toggle wrap";

      action.__raw = ''
        function()
          require("astrocore.toggles").wrap()
        end
      '';
    }
    {
      key = "<Leader>uy";
      options.desc = "Toggle syntax highlight";

      action.__raw = ''
        function()
          require("astrocore.toggles").buffer_syntax()
        end
      '';
    }
  ];

  mapSectionsLua = ''

  '';
}
