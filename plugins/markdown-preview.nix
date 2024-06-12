# homepage: https://github.com/iamcco/markdown-preview.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/markdown-preview/index.html
_:

{
  opts = {
    enable = true;
    settings.auto_close = false;
  };

  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>mp";
      action = "<cmd>MarkdownPreview<cr>";
      options.desc = "Start Markdown preview";
    }
    {
      mode = "n";
      key = "<leader>ms";
      action = "<cmd>MarkdownPreviewStop<cr>";
      options.desc = "Stop Markdown preview";
    }
    {
      mode = "n";
      key = "<leader>mt";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options.desc = "Toggle Markdown preview";
    }
  ];
}
