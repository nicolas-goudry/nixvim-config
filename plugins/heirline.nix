# homepage: https://github.com/rebelot/heirline.nvim
{ pkgs, ... }:

{
  extra = {
    packages = [ pkgs.vimPlugins.heirline-nvim ];

    # Config from AstroNvim
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/heirline.lua
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/configs/heirline.lua
    config = ''
      local status = require("astroui.status")
      local screenkey = require("screenkey")
      vim.g.screenkey_statusline_component = true

      require("heirline").setup({
        opts = {
          colors = require("astroui").config.status.setup_colors(),
          disable_winbar_cb = function(args)
            return not require("astrocore.buffer").is_valid(args.buf)
              or status.condition.buffer_matches({ buftype = { "terminal", "nofile" } }, args.buf)
          end,
        },
        statusline = { -- statusline
          hl = { fg = "fg", bg = "bg" },
          status.component.mode(),
          status.component.git_branch(),
          status.component.file_info(),
          status.component.git_diff(),
          status.component.diagnostics(),
          status.component.fill(),
          status.component.cmd_info(),
          status.component.fill(),
          status.component.lsp(),
          status.component.virtual_env(),
          status.component.treesitter(),
          {
            provider = function()
              local keys = screenkey.get_keys()
              if keys == nil or keys == "" then
                return
              end
              return "  " .. keys
            end,
            update = {
              "User",
              pattern = "Screenkey*",
              callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
            },
          },
          status.component.nav(),
          status.component.mode { surround = { separator = "right" } },
        },
        winbar = { -- winbar
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          fallthrough = false,
          {
            condition = function() return not status.condition.is_active() end,
            status.component.separated_path(),
            status.component.file_info {
              file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
              filename = {},
              filetype = false,
              file_read_only = false,
              hl = status.hl.get_attributes("winbarnc", true),
              surround = false,
              update = "BufEnter",
            },
          },
          status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
        },
        tabline = { -- bufferline
          { -- automatic sidebar padding
            condition = function(self)
              self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
              self.winwidth = vim.api.nvim_win_get_width(self.winid)
              return self.winwidth ~= vim.o.columns -- only apply to sidebars
                and not require("astrocore.buffer").is_valid(vim.api.nvim_win_get_buf(self.winid)) -- if buffer is not in tabline
            end,
            provider = function(self) return (" "):rep(self.winwidth + 1) end,
            hl = { bg = "tabline_bg" },
          },
          status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
          status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
          { -- tab list
            condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
            status.heirline.make_tablist { -- component for each tab
              provider = status.provider.tabnr(),
              hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
            },
            { -- close button for current tab
              provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
              hl = status.hl.get_attributes("tab_close", true),
              on_click = {
                callback = function() require("astrocore.buffer").close_tab() end,
                name = "heirline_tabline_close_tab_callback",
              },
            },
          },
        },
        statuscolumn = {
          init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
          status.component.foldcolumn(),
          status.component.numbercolumn(),
          status.component.signcolumn(),
        },
      })
    '';
  };

  rootOpts = {
    autoGroups = {
      bufferline = { };
      heirline = { };
    };

    autoCmd = [
      {
        desc = "Update buffers when adding new buffers";
        event = [ "BufAdd" "BufEnter" "TabNewEntered" ];
        group = "bufferline";

        callback.__raw = ''
          function(args)
            local buf_utils = require "astrocore.buffer"
            if not vim.t.bufs then vim.t.bufs = {} end
            if not buf_utils.is_valid(args.buf) then return end
            if args.buf ~= buf_utils.current_buf then
              buf_utils.last_buf = buf_utils.is_valid(buf_utils.current_buf) and buf_utils.current_buf or nil
              buf_utils.current_buf = args.buf
            end
            local bufs = vim.t.bufs
            if not vim.tbl_contains(bufs, args.buf) then
              table.insert(bufs, args.buf)
              vim.t.bufs = bufs
            end
            vim.t.bufs = vim.tbl_filter(buf_utils.is_valid, vim.t.bufs)
            require("astrocore").event "BufsUpdated"
          end
        '';
      }
      {
        desc = "Update buffers when deleting buffers";
        event = [ "BufDelete" "TermClose" ];
        group = "bufferline";

        callback.__raw = ''
          function(args)
            local removed
            for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
              local bufs = vim.t[tab].bufs
              if bufs then
                for i, bufnr in ipairs(bufs) do
                  if bufnr == args.buf then
                    removed = true
                    table.remove(bufs, i)
                    vim.t[tab].bufs = bufs
                    break
                  end
                end
              end
            end
            vim.t.bufs = vim.tbl_filter(require("astrocore.buffer").is_valid, vim.t.bufs)
            if removed then require("astrocore").event "BufsUpdated" end
            vim.cmd.redrawtabline()
          end
        '';
      }
      {
        desc = "Refresh heirline colors on colorscheme load";
        event = [ "ColorScheme" ];
        group = "heirline";
        callback.__raw = "function() require('astroui.status.heirline').refresh_colors() end";
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>bb";
        options.desc = "Select buffer from tabline";

        action.__raw = ''
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr) vim.api.nvim_win_set_buf(0, bufnr) end)
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>bd";
        options.desc = "Close buffer from tabline";

        action.__raw = ''
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>b\\";
        options.desc = "Horizontal split buffer from tabline";

        action.__raw = ''
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.split()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>b|";
        options.desc = "Vertical split buffer from tabline";

        action.__raw = ''
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              vim.cmd.vsplit()
              vim.api.nvim_win_set_buf(0, bufnr)
            end)
          end
        '';
      }
    ];
  };
}
