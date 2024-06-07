let
  forceWrite = {
    action = "<cmd>silent! update! | redraw<cr>";
    options.desc = "Force write";
  };
in
[
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
    key = "\\";
    action = "<cmd>split<cr>";
    options.desc = "Horizontal split";
  }
  {
    key = "gx";
    action.__raw = "require('astrocore').system_open";
    options.desc = "Open the file under cursor with system app";
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
]
