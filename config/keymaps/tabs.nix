# Navigate tabs
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L103-L104
[
  {
    key = "]t";
    options.desc = "Next tab";

    action.__raw = ''
      function()
        vim.cmd.tabnext()
      end
    '';
  }
  {
    key = "[t";
    options.desc = "Previous tab";

    action.__raw = ''
      function()
        vim.cmd.tabprevious()
      end
    '';
  }
]
