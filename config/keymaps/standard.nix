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
    mode = [ "n" "x" ];
    key = "j";
    action = "v:count == 0 ? 'gj' : 'j'";

    options = {
      desc = "Move cursor down";
      expr = true;
      silent = true;
    };
  }
  {
    mode = [ "n" "x" ];
    key = "k";
    action = "v:count == 0 ? 'gk' : 'k'";

    options = {
      desc = "Move cursor up";
      expr = true;
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>w";
    action = "<cmd>w<cr>";
    options.desc = "Save";
  }
  {
    mode = "n";
    key = "<leader>q";
    action = "<cmd>confirm q<cr>";
    options.desc = "Quit window";
  }
  {
    mode = "n";
    key = "<leader>Q";
    action = "<cmd>confirm qall<cr>";
    options.desc = "Exit neovim";
  }
  {
    mode = "n";
    key = "<leader>n";
    action = "<cmd>enew<cr>";
    options.desc = "New file";
  }
  {
    inherit (forceWrite) action options;
    mode = "n";
    key = "<c-s>";
  }
  {
    inherit (forceWrite) options;
    mode = [ "i" "x" ];
    key = "<c-s>";
    action = "<esc>" + forceWrite.action;
  }
  {
    mode = "n";
    key = "<c-q>";
    action = "<cmd>q!<cr>";
    options.desc = "Force quit";
  }
  {
    mode = "n";
    key = "|";
    action = "<cmd>vsplit<cr>";
    options.desc = "Vertical split";
  }
  {
    mode = "n";
    key = "\\";
    action = "<cmd>split<cr>";
    options.desc = "Horizontal split";
  }
  {
    mode = "n";
    key = "gx";
    action.__raw = "require('astrocore').system_open";
    options.desc = "Open the file under cursor with system app";
  }

  # Stay in indent mode
  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L117-L118
  {
    mode = "v";
    key = "<S-Tab>";
    action = "<gv";
    options.desc = "Unindent line";
  }
  {
    mode = "v";
    key = "<Tab>";
    action = ">gv";
    options.desc = "Indent line";
  }
]
