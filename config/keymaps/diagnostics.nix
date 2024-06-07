# Diagnostics
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L92-L100
[
  {
    key = "<Leader>ld";
    options.desc = "Hover diagnostics";

    action.__raw = ''
      function()
        vim.diagnostic.open_float()
      end
    '';
  }
  {
    key = "[d";
    options.desc = "Previous diagnostic";

    action.__raw = ''
      function()
        vim.diagnostic.goto_prev()
      end
    '';
  }
  {
    key = "]d";
    options.desc = "Next diagnostic";

    action.__raw = ''
      function()
        vim.diagnostic.goto_next()
      end
    '';
  }
  {
    key = "gl";
    options.desc = "Hover diagnostics";

    action.__raw = ''
      function()
        vim.diagnostic.open_float()
      end
    '';
  }
]
