{ icons, ... }:

{
  opts = {
    enable = true;

    settings = {
      current_line_blame = true;
      current_line_blame_formatter = " <author>, <author_time:%R> – <summary>";
      current_line_blame_formatter_nc = " Uncommitted";
      current_line_blame_opts.ignore_whitespace = true;

      signs = {
        add.text = icons.GitSign;
        change.text = icons.GitSign;
        changedelete.text = icons.GitSign;
        delete.text = icons.GitSign;
        topdelete.text = icons.GitSign;
        untracked.text = icons.GitSign;
      };
    };
  };

  rootOpts = {
    # Enable catppuccin colors
    # https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/gitsigns.lua
    colorschemes.catppuccin.settings.integrations.gitsigns = true;

    keymaps = [
      {
        key = "]g";
        action.__raw = "function() require('gitsigns').next_hunk() end";
        options.desc = "Next Git hunk";
      }
      {
        key = "[g";
        action.__raw = "function() require('gitsigns').prev_hunk() end";
        options.desc = "Previous Git hunk";
      }
      {
        key = "<leader>gl";
        action.__raw = "function() require('gitsigns').blame_line { full = true } end";
        options.desc = "View full Git blame";
      }
      {
        key = "<Leader>gp";
        action.__raw = "function() require('gitsigns').preview_hunk_inline() end";
        options.desc = "Preview Git hunk";
      }
      {
        key = "<Leader>gh";
        action.__raw = "function() require('gitsigns').reset_hunk() end";
        options.desc = "Reset Git hunk";
      }
      {
        key = "<Leader>gr";
        action.__raw = "function() require('gitsigns').reset_buffer() end";
        options.desc = "Reset Git buffer";
      }
      {
        key = "<Leader>gs";
        action.__raw = "function() require('gitsigns').stage_hunk() end";
        options.desc = "Stage Git hunk";
      }
      {
        key = "<Leader>gS";
        action.__raw = "function() require('gitsigns').stage_buffer() end";
        options.desc = "Stage Git buffer";
      }
      {
        key = "<Leader>gu";
        action.__raw = "function() require('gitsigns').undo_stage_hunk() end";
        options.desc = "Unstage Git hunk";
      }
      {
        key = "<Leader>gd";
        action.__raw = "function() require('gitsigns').diffthis() end";
        options.desc = "View Git diff";
      }
    ];
  };
}
