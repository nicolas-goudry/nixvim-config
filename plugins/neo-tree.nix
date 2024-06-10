# homepage: https://github.com/nvim-neo-tree/neo-tree.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/neo-tree/index.html
{ icons, ... }:

{
  opts = {
    enable = true;

    # Automatically clean up broken neo-tree buffers saved in sessions
    autoCleanAfterSessionRestore = true;

    # Close Neo-tree if it is the last window left in the tab
    closeIfLastWindow = true;

    # Disable fold column (gutter)
    eventHandlers = {
      neo_tree_buffer_enter = ''
        function(_)
          vim.opt_local.signcolumn = "auto"
          vim.opt_local.foldcolumn = "0"
        end
      '';
    };

    # Extra options not exposed by the plugin
    extraOptions = {
      # Custom functions (taken from AstroNvim)
      commands = {
        # Focus first directory child item or open directory
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L120-L135
        child_or_open.__raw = ''
          function(state)
            local node = state.tree:get_node()
            if node:has_children() then
              if not node:is_expanded() then -- if unexpanded, expand
                state.commands.toggle_node(state)
              else -- if expanded and has children, select the next child
                if node.type == "file" then
                  state.commands.open(state)
                else
                  require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                end
              end
            else -- if has no children
              state.commands.open(state)
            end
          end
        '';

        # Copy various path format of currently focused item
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L136-L168
        copy_selector.__raw = ''
          function(state)
            local notify = require("astrocore").notify
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local vals = {
              ["BASENAME"] = modify(filename, ":r"),
              ["EXTENSION"] = modify(filename, ":e"),
              ["FILENAME"] = filename,
              ["PATH (CWD)"] = modify(filepath, ":."),
              ["PATH (HOME)"] = modify(filepath, ":~"),
              ["PATH"] = filepath,
              ["URI"] = vim.uri_from_fname(filepath),
            }

            local options = vim.tbl_filter(function(val) return vals[val] ~= "" end, vim.tbl_keys(vals))
            if vim.tbl_isempty(options) then
              notify("No values to copy", vim.log.levels.WARN)
              return
            end
            table.sort(options)
            vim.ui.select(options, {
              prompt = "Choose to copy to clipboard:",
              format_item = function(item) return ("%s: %s"):format(item, vals[item]) end,
            }, function(choice)
              local result = vals[choice]
              if result then
                notify(("Copied: `%s`"):format(result))
                vim.fn.setreg("+", result)
              end
            end)
          end
        '';

        # Find file in currently focused item if it is a directory, or its closest parent directory
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L205-L209
        find_file_in_dir.__raw = ''
          function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            TelescopeWithTheme('find_files', { cwd = path }, "")
          end
        '';

        # Live grep in currently focused item if it is a directory, or its closest parent directory
        grep_in_dir.__raw = ''
          function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            TelescopeWithTheme('live_grep', { cwd = path }, "")
          end
        '';

        # Focus parent directory of currently focused item or close directory
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L112-L119
        parent_or_close.__raw = ''
          function(state)
            local node = state.tree:get_node()
            if node:has_children() and node:is_expanded() then
              state.commands.toggle_node(state)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end
        '';
      };

      window = {
        # Keymaps for filter popup window in fuzzy finder mode (ie. "/")
        fuzzy_finder_mappings = {
          "<C-J>" = "move_cursor_down";
          "<C-K>" = "move_cursor_up";
        };

        # Keymaps when neotree window is focused
        mappings = {
          "[b" = "prev_source";
          "]b" = "next_source";

          # Disable default behavior to toggle node on Space keypress
          "<Space>".__raw = "false";

          # See extraOptions.commands for details on following keymaps
          h = "parent_or_close";
          l = "child_or_open";
          F = "find_file_in_dir";
          W = "grep_in_dir";
          Y = "copy_selector";
        };
      };
    };

    defaultComponentConfigs = {
      gitStatus.symbols = {
        added = icons.GitAdd;
        conflict = icons.GitConflict;
        deleted = icons.GitDelete;
        ignored = icons.GitIgnored;
        modified = icons.GitChange;
        renamed = icons.GitRenamed;
        staged = icons.GitStaged;
        unstaged = icons.GitUnstaged;
        untracked = icons.GitUntracked;
      };
    };

    filesystem = {
      # Find and focus file in active buffer
      followCurrentFile.enabled = true;

      # Open neotree "fullscreen" when opening a directory
      hijackNetrwBehavior = "open_current";
    };

    # Sources tabs
    sourceSelector = {
      # Label position
      contentLayout.__raw = "'center'";

      # No tabs separator
      separator = "";

      # Show tabs on winbar
      winbar = true;

      # Sources to show and their labels
      sources = [
        {
          displayName = "${icons.FolderClosed} Files";
          source = "filesystem";
        }
        {
          displayName = "${icons.DefaultFile} Bufs";
          source = "buffers";
        }
        {
          displayName = "${icons.Git} Git";
          source = "git_status";
        }
      ];
    };
  };

  rootOpts = {
    # Enable catppuccin colors
    # https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/neotree.lua
    colorschemes.catppuccin.settings.integrations.neotree = true;
    autoGroups.neotree = { };

    # Custom autocommands (taken from AstroNvim)
    autoCmd =
      let
        refresh = ''
          function()
            local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
            if manager_avail then
              for _, source in ipairs { "filesystem", "git_status", "document_symbols" } do
                local module = "neo-tree.sources." .. source
                if package.loaded[module] then manager.refresh(require(module).name) end
              end
            end
          end
        '';
      in
      [
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L21-L37
        {
          desc = "Open explorer on startup with directory";
          event = "BufEnter";
          group = "neotree";

          callback.__raw = ''
            function()
              if package.loaded["neo-tree"] then
                return true
              else
                local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
                if stats and stats.type == "directory" then
                  return true
                end
              end
            end
          '';
        }
        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L25-L35
        {
          desc = "Refresh explorer sources when closing lazygit";
          event = "TermClose";
          group = "neotree";
          pattern = "*lazygit*";
          callback.__raw = refresh;
        }
        {
          desc = "Refresh explorer sources on focus";
          event = "FocusGained";
          group = "neotree";
          callback.__raw = refresh;
        }
      ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle explorer";
      }
      {
        mode = "n";
        key = "<leader>o";
        options.desc = "Toggle explorer focus";

        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/neo-tree.lua#L12-L18
        action.__raw = ''
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end
        '';
      }
    ];
  };
}
