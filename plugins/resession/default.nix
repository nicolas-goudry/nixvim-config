# homepage: https://github.com/stevearc/resession.nvim
{ lib, pkgs, ... }:

{
  extra = {
    packages = [
      (import ./package.nix { inherit lib pkgs; })
    ];

    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/resession.lua#L45-L49
    config = ''
      require("resession").setup({
        buf_filter = function(bufnr) return require("astrocore.buffer").is_restorable(bufnr) end,
        tab_buf_filter = function(tabpage, bufnr) return vim.tbl_contains(vim.t[tabpage].bufs, bufnr) end,
        extensions = { astrocore = { enable_in_tab = true } },
      })
    '';
  };

  rootOpts = {
    autoGroups.resession = { };
    autoCmd = [
      {
        desc = "Save session on close";
        event = "VimLeavePre";
        group = "resession";

        # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/resession.lua#L31-L39
        callback.__raw = ''
          function()
            local buf_utils = require "astrocore.buffer"
            local autosave = buf_utils.sessions.autosave
            if autosave and buf_utils.is_valid_session() then
              local save = require("resession").save
              if autosave.last then save("last", { notify = false }) end
              if autosave.cwd then save(vim.fn.getcwd(), { dir = "dirsession", notify = false }) end
            end
          end
        '';
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>sl";
        action.__raw = "function() require('resession').load 'last' end";
        options.desc = "Load last session";
      }
      {
        mode = "n";
        key = "<leader>ss";
        action.__raw = "function() require('resession').save() end";
        options.desc = "Save this session";
      }
      {
        mode = "n";
        key = "<leader>sS";
        action.__raw = "function() require('resession').save(vim.fn.getcwd(), { dir = 'dirsession' }) end";
        options.desc = "Save this dirsession";
      }
      {
        mode = "n";
        key = "<leader>st";
        action.__raw = "function() require('resession').save_tab() end";
        options.desc = "Save this tab's session";
      }
      {
        mode = "n";
        key = "<leader>sd";
        action.__raw = "function() require('resession').delete() end";
        options.desc = "Delete a session";
      }
      {
        mode = "n";
        key = "<leader>sD";
        action.__raw = "function() require('resession').delete(nil, { dir = 'dirsession' }) end";
        options.desc = "Delete a dirsession";
      }
      {
        mode = "n";
        key = "<leader>sf";
        action.__raw = "function() require('resession').load() end";
        options.desc = "Load a session";
      }
      {
        mode = "n";
        key = "<leader>sF";
        action.__raw = "function() require('resession').load(nil, { dir = 'dirsession' }) end";
        options.desc = "Load a dirsession";
      }
      {
        mode = "n";
        key = "<leader>s.";
        action.__raw = "function() require('resession').load(vim.fn.getcwd(), { dir = 'dirsession' }) end";
        options.desc = "Load current dirsession";
      }
    ];
  };
}
