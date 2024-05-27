# homepage: https://github.com/nvim-telescope/telescope.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/telescope/index.html
{ libn, pkgs, ... }:

{
  opts = {
    enable = true;
  };

  rootOpts = {
    # Needed for live grep
    extraPackages = [ pkgs.ripgrep ];

    # Enable catppuccin colors
    # https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/telescope.lua
    colorschemes.catppuccin.settings.integrations.telescope.enabled = true;

    # Set custom behavior for dropdown theme:
    # - use 80% of window width
    # - use all window height
    # - display preview at bottom
    # ┌──────────────────────────────────────────────────┐
    # │    ┌────────────────────────────────────────┐    │
    # │    │                 Prompt                 │    │
    # │    ├────────────────────────────────────────┤    │
    # │    │                 Result                 │    │
    # │    │                 Result                 │    │
    # │    └────────────────────────────────────────┘    │
    # │    ┌────────────────────────────────────────┐    │
    # │    │                 Preview                │    │
    # │    │                 Preview                │    │
    # │    │                 Preview                │    │
    # │    │                 Preview                │    │
    # │    │                 Preview                │    │
    # │    │                 Preview                │    │
    # │    └────────────────────────────────────────┘    │
    # └──────────────────────────────────────────────────┘
    extraConfigLuaPre = ''
      local TelescopeWithTheme = function(fn, args)
        args.layout_config = {
          anchor = "N",
          mirror = true,
          width = 0.8,
        }

        if fn == "keymaps" or fn == "registers" then args.layout_config.height = function(_, _, max_lines) return max_lines end end

        require("telescope.builtin")[fn](require("telescope.themes").get_dropdown(args))
      end
    '';

    # Use root keymaps to allow usage of custom TelescopeWithTheme function
    keymaps =
      let
        mkTelescopeKeymap =
          { key
          , mode ? "n"
          , fn
          , args ? { __empty = true; }
          , desc ? ""
          }: {
            inherit key mode;

            action.__raw = "function() TelescopeWithTheme('${fn}', ${libn.helpers.toLuaObject args}) end";
            options = { inherit desc; };
          };
      in
      map mkTelescopeKeymap [
        {
          desc = "Resume previous search";
          key = "<leader>f<cr>";
          fn = "resume";
        }
        {
          desc = "Find words in current buffer";
          key = "<leader>f/";
          fn = "current_buffer_fuzzy_find";
        }
        {
          desc = "Find buffers";
          key = "<leader>fb";
          fn = "buffers";
        }
        {
          desc = "Find files";
          key = "<leader>ff";
          fn = "find_files";
        }
        {
          desc = "Find all files";
          key = "<leader>fF";
          fn = "find_files";
          args = {
            hidden = true;
            no_ignore = true;
          };
        }
        {
          desc = "Find words";
          key = "<leader>fg";
          fn = "live_grep";
        }
        {
          desc = "Find help tags";
          key = "<leader>fh";
          fn = "help_tags";
        }
        {
          desc = "Find keymaps";
          key = "<leader>fk";
          fn = "keymaps";
        }
        {
          desc = "Find history";
          key = "<leader>fo";
          fn = "oldfiles";
        }
        {
          desc = "Find registers";
          key = "<leader>fr";
          fn = "registers";
        }
        {
          desc = "Find word under cursor";
          key = "<leader>fw";
          fn = "grep_string";
        }
        {
          desc = "Search references";
          key = "gr";
          fn = "lsp_references";
        }
      ];
  };
}
