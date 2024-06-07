# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua
{
  autoGroups = {
    auto_quit.clear = true;
    autoview.clear = true;
    bufferline.clear = true;
    checktime.clear = true;
    create_dir.clear = true;
    editorconfig_filetype.clear = true;
    file_user_events.clear = true;
    highlighturl.clear = true;
    highlightyank.clear = true;
    large_buf_settings.clear = true;
    q_close_windows.clear = true;
    terminal_settings.clear = true;
    unlist_quickfix.clear = true;
  };

  autoCmd = [
    # auto_quit
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L18-L46
    {
      desc = "Quit neovim if more than one window is open and only sidebar windows are list";
      event = "BufEnter";
      group = "auto_quit";

      callback.__raw = ''
        function()
          local wins = vim.api.nvim_tabpage_list_wins(0)
          -- Both neo-tree and aerial will auto-quit if there is only a single window left
          if #wins <= 1 then return end
          local sidebar_fts = { aerial = true, ["neo-tree"] = true }
          for _, winid in ipairs(wins) do
            if vim.api.nvim_win_is_valid(winid) then
              local bufnr = vim.api.nvim_win_get_buf(winid)
              local filetype = vim.bo[bufnr].filetype
              -- If any visible windows are not sidebars, early return
              if not sidebar_fts[filetype] then
                return
              -- If the visible window is a sidebar
              else
                -- only count filetypes once, so remove a found sidebar from the detection
                sidebar_fts[filetype] = nil
              end
            end
          end
          if #vim.api.nvim_list_tabpages() > 1 then
            vim.cmd.tabclose()
          else
            vim.cmd.qall()
          end
        end
      '';
    }

    # autoview
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L49-L70
    {
      desc = "Save view with mkview for real files";
      event = [ "BufWinLeave" "BufWritePost" "WinLeave" ];
      group = "autoview";

      callback.__raw = ''
        function(event)
          if vim.b[event.buf].view_activated then vim.cmd.mkview { mods = { emsg_silent = true } } end
        end
      '';
    }
    {
      desc = "Try to load file view if available and enable view saving for real files";
      event = "BufWinEnter";
      group = "autoview";

      callback.__raw = ''
        function(event)
          if not vim.b[event.buf].view_activated then
            local filetype = vim.bo[event.buf].filetype
            local buftype = vim.bo[event.buf].buftype
            local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
            if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
              vim.b[event.buf].view_activated = true
              vim.cmd.loadview { mods = { emsg_silent = true } }
            end
          end
        end
      '';
    }

    # bufferline
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L73-L115
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

    # checktime
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L118-L122
    {
      desc = "Check if buffers changed on editor focus";
      event = [ "FocusGained" "TermClose" "TermLeave" ];
      group = "checktime";
      command = "checktime";
    }

    # create_dir
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L125-L132
    {
      desc = "Automatically create parent directories if they don't exist when saving a file";
      event = "BufWritePre";
      group = "create_dir";

      callback.__raw = ''
        function(args)
          if not require("astrocore.buffer").is_valid(args.buf) then return end
          vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
        end
      '';
    }

    # editorconfig_filetype
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L135-L144
    {
      desc = "Configure editorconfig after filetype detection to override `ftplugin`s";
      event = "FileType";
      group = "editorconfig_filetype";

      callback.__raw = ''
        function(args)
          if vim.F.if_nil(vim.b.editorconfig, vim.g.editorconfig, true) then
            local editorconfig_avail, editorconfig = pcall(require, "editorconfig")
            if editorconfig_avail then editorconfig.config(args.buf) end
          end
        end
      '';
    }

    # file_user_events
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L147-L177
    {
      desc = "Astro user events for file detection (AstroFile and AstroGitFile)";
      event = [ "BufReadPost" "BufNewFile" "BufWritePost" ];
      group = "file_user_events";

      callback.__raw = ''
        function(args)
          if vim.b[args.buf].astrofile_checked then return end
          vim.b[args.buf].astrofile_checked = true
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(args.buf) then return end
            local astro = require "astrocore"
            local current_file = vim.api.nvim_buf_get_name(args.buf)
            if vim.g.vscode or not (current_file == "" or vim.bo[args.buf].buftype == "nofile") then
              astro.event "File"
              local folder = vim.fn.fnamemodify(current_file, ":p:h")
              if vim.fn.has "win32" == 1 then folder = ('"%s"'):format(folder) end
              if vim.fn.executable "git" == 1 then
                if astro.cmd({ "git", "-C", folder, "rev-parse" }, false) or astro.file_worktree() then
                  astro.event "GitFile"
                  pcall(vim.api.nvim_del_augroup_by_name, "file_user_events")
                end
              else
                pcall(vim.api.nvim_del_augroup_by_name, "file_user_events")
              end
              vim.schedule(function()
                if require("astrocore.buffer").is_valid(args.buf) then
                  vim.api.nvim_exec_autocmds(args.event, { buffer = args.buf, data = args.data })
                end
              end)
            end
          end)
        end
      '';
    }

    # highlighturl
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L180-L203
    {
      desc = "URL Highlighting";
      event = [ "VimEnter" "FileType" "BufEnter" "WinEnter" ];
      group = "highlighturl";

      callback.__raw = ''
        function(args)
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if
              vim.api.nvim_win_get_buf(win) == args.buf
              and vim.tbl_get(require "astrocore", "config", "features", "highlighturl")
              and not vim.w[win].highlighturl_enabled
            then
              require("astrocore").set_url_match(win)
            end
          end
        end
      '';
    }
    {
      desc = "Set up the default HighlightURL highlight group";
      event = [ "VimEnter" "User" ];
      group = "highlighturl";

      callback.__raw = ''
        function(args)
          if args.event == "VimEnter" or args.match == "AstroColorScheme" then
            vim.api.nvim_set_hl(0, "HighlightURL", { default = true, underline = true })
          end
        end
      '';
    }

    # highlightyank
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L206-L211
    {
      desc = "Highlight yanked text";
      event = "TextYankPost";
      group = "highlightyank";
      pattern = "*";

      callback.__raw = ''
        function()
          vim.highlight.on_yank()
        end
      '';
    }

    # large_buf_settings
    # https://github.com/AstroNvim/astrocore/blob/v1.5.0/lua/astrocore/init.lua#L473-L486
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L214-L239
    # https://www.reddit.com/r/neovim/comments/z85s1l/comment/iyfrgvb/
    {
      desc = "Disable certain functionality on very large files";
      event = "User";
      group = "large_buf_settings";
      pattern = "AstroLargeBuf";

      callback.__raw = ''
        function(args)
          vim.opt_local.wrap = true -- enable wrap, long lines in vim are slow
          vim.opt_local.list = false -- disable list chars

          vim.b[args.buf].autoformat = false -- disable autoformat on save
          vim.b[args.buf].cmp_enabled = false -- disable completion
          vim.b[args.buf].miniindentscope_disable = true -- disable indent scope
          vim.b[args.buf].matchup_matchparen_enabled = 0 -- disable vim-matchup

          local astrocore = require "astrocore"
          if vim.tbl_get(astrocore.config, "features", "highlighturl") then
            astrocore.config.features.highlighturl = false
            vim.tbl_map(function(win)
              if vim.w[win].highlighturl_enabled then astrocore.delete_url_match(win) end
            end, vim.api.nvim_list_wins())
          end

          local ibl_avail, ibl = pcall(require, "ibl") -- disable indent-blankline
          if ibl_avail then ibl.setup_buffer(args.buf, { enabled = false }) end

          local illuminate_avail, illuminate = pcall(require, "illuminate.engine") -- disable vim-illuminate
          if illuminate_avail then illuminate.stop_buf(args.buf) end

          local rainbow_avail, rainbow = pcall(require, "rainbow-delimiters") -- disable rainbow-delimiters
          if rainbow_avail then rainbow.disable(args.buf) end

          --[[
            Custom additions
          ]]--
          local ts_avail, ts = pcall(require, "nvim-treesitter.configs") -- disable treesitter
          if ts_avail then
            for _, module in ipairs(ts.available_modules()) do
              vim.cmd(("TSBufDisable %s"):format(module))
            end
          end

          vim.opt_local.foldmethod = "manual"
          vim.opt_local.spell = false
          vim.cmd("syntax off")
          vim.cmd("LspStop")
        end
      '';
    }

    # q_close_windows
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L242-L255
    {
      desc = "Make q close help, man, quickfix, dap floats";
      event = "BufWinEnter";
      group = "q_close_windows";

      callback.__raw = ''
        function(event)
          if vim.tbl_contains({ "help", "nofile", "quickfix" }, vim.bo[event.buf].buftype) then
            vim.keymap.set("n", "q", "<Cmd>close<CR>", {
              desc = "Close window",
              buffer = event.buf,
              silent = true,
              nowait = true,
            })
          end
        end
      '';
    }

    # terminal_settings
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L258-L266
    {
      desc = "Disable line number/fold column/sign column for terminals";
      event = "TermOpen";
      group = "terminal_settings";

      callback.__raw = ''
        function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.foldcolumn = "0"
          vim.opt_local.signcolumn = "no"
        end
      '';
    }

    # unlist_quickfix
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_autocmds.lua#L270-L275
    {
      desc = "Unlist quickfix buffers";
      event = "FileType";
      group = "unlist_quickfix";
      pattern = "qf";

      callback.__raw = ''
        function()
          vim.opt_local.buflisted = false
        end
      '';
    }
  ];
}
