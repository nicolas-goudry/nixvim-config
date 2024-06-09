_:

{
  opts = {
    enable = true;

    settings = {
      ignored_filetypes = [ "nofile" "quickfix" "qf" "prompt" ];
      ignored_buftypes = [ "nofile" ];
    };
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<C-H>";
      action.__raw = "function() require('smart-splits').move_cursor_left() end";
      options.desc = "Move to left split";
    }
    {
      mode = "n";
      key = "<C-J>";
      action.__raw = "function() require('smart-splits').move_cursor_down() end";
      options.desc = "Move to below split";
    }
    {
      mode = "n";
      key = "<C-K>";
      action.__raw = "function() require('smart-splits').move_cursor_up() end";
      options.desc = "Move to above split";
    }
    {
      mode = "n";
      key = "<C-L>";
      action.__raw = "function() require('smart-splits').move_cursor_right() end";
      options.desc = "Move to right split";
    }
    {
      mode = "n";
      key = "<C-Up>";
      action.__raw = "function() require('smart-splits').resize_up() end";
      options.desc = "Resize split up";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action.__raw = "function() require('smart-splits').resize_down() end";
      options.desc = "Resize split down";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action.__raw = "function() require('smart-splits').resize_left() end";
      options.desc = "Resize split left";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action.__raw = "function() require('smart-splits').resize_right() end";
      options.desc = "Resize split right";
    }
  ];
}
