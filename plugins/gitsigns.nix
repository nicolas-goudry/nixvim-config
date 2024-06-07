# homepage: https://github.com/lewis6991/gitsigns.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/gitsigns/index.html
{ icons, ... }:

{
  opts = {
    enable = true;

    settings = {
      # Show line blame with custom text
      current_line_blame = true;
      current_line_blame_formatter = " <author>, <author_time:%R> – <summary>";
      current_line_blame_formatter_nc = " Uncommitted";
      current_line_blame_opts.ignore_whitespace = true;

      # Use same icon for all signs (only color matters)
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

    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/gitsigns.lua#L9-L21
    keymaps = [
      {
        mode = "n";
        key = "]g";
        action.__raw = "function() require('gitsigns').next_hunk() end";
        options.desc = "Next Git hunk";
      }
      {
        mode = "n";
        key = "[g";
        action.__raw = "function() require('gitsigns').prev_hunk() end";
        options.desc = "Previous Git hunk";
      }
      {
        mode = "n";
        key = "<leader>gl";
        action.__raw = "function() require('gitsigns').blame_line { full = true } end";
        options.desc = "View full Git blame";
      }
      {
        mode = "n";
        key = "<Leader>gp";
        action.__raw = "function() require('gitsigns').preview_hunk_inline() end";
        options.desc = "Preview Git hunk";
      }
      {
        mode = "n";
        key = "<Leader>gh";
        action.__raw = "function() require('gitsigns').reset_hunk() end";
        options.desc = "Reset Git hunk";
      }
      {
        mode = "n";
        key = "<Leader>gr";
        action.__raw = "function() require('gitsigns').reset_buffer() end";
        options.desc = "Reset Git buffer";
      }
      {
        mode = "n";
        key = "<Leader>gs";
        action.__raw = "function() require('gitsigns').stage_hunk() end";
        options.desc = "Stage Git hunk";
      }
      {
        mode = "n";
        key = "<Leader>gS";
        action.__raw = "function() require('gitsigns').stage_buffer() end";
        options.desc = "Stage Git buffer";
      }
      {
        mode = "n";
        key = "<Leader>gu";
        action.__raw = "function() require('gitsigns').undo_stage_hunk() end";
        options.desc = "Unstage Git hunk";
      }
      {
        mode = "n";
        key = "<Leader>gd";
        action.__raw = "function() require('gitsigns').diffthis() end";
        options.desc = "View Git diff";
      }
    ];
  };
}
