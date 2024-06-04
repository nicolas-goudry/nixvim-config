# homepage: https://github.com/numtostr/comment.nvim/
# nixvim doc: https://nix-community.github.io/nixvim/plugins/comment/index.html
_:

{
  opts = {
    enable = true;
    settings.pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
  };
}
