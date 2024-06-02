# homepage: https://github.com/stevearc/dressing.nvim
# nixvim doc: https://nix-community.github.io/nixvim/plugins/dressing/index.html
_:

{
  opts = {
    enable = true;

    settings = {
      input = {
        default_prompt = "> ";
        title_pos = "center";
      };

      select.backend = [ "telescope" "builtin" ];
    };
  };
}
