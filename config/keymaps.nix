let
  forceWrite = {
    action = "<cmd>silent! update! | redraw<cr>";
    options.desc = "Force write";
  };
in
[
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
    mode = [ "i" "x" ];
    key = "<c-s>";
    action = "<esc>${forceWrite.action}";
  }
  {
    key = "|";
    action = "<cmd>vsplit<cr>";
    options.desc = "Split vertically";
  }
  {
    key = "\\";
    action = "<cmd>split<cr>";
    options.desc = "Split horizontally";
  }
]
