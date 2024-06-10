_:

{
  opts = {
    enable = true;
    # highlight.pattern = ".*<(KEYWORDS)\s*";
    # search.pattern = "\\b(KEYWORDS)";
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>fT";
      action.__raw = "function() TelescopeWithTheme('todo', {}, 'todo-comments') end";
      options.desc = "Find TODOs";
    }
    {
      mode = "n";
      key = "]T";
      action.__raw = "function() require('todo-comments').jump_next() end";
      options.desc = "Next TODO comment";
    }
    {
      mode = "n";
      key = "[T";
      action.__raw = "function() require('todo-comments').jump_prev() end";
      options.desc = "Previous TODO comment";
    }
  ];
}
