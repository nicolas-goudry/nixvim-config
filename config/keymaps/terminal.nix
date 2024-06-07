# Improved terminal navigation
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L121-L124
[
  {
    mode = "t";
    key = "<C-H>";
    action = "<Cmd>wincmd h<CR>";
    options.desc = "Terminal left window navigation";
  }
  {
    mode = "t";
    key = "<C-J>";
    action = "<Cmd>wincmd j<CR>";
    options.desc = "Terminal down window navigation";
  }
  {
    mode = "t";
    key = "<C-K>";
    action = "<Cmd>wincmd k<CR>";
    options.desc = "Terminal up window navigation";
  }
  {
    mode = "t";
    key = "<C-L>";
    action = "<Cmd>wincmd l<CR>";
    options.desc = "Terminal right window navigation";
  }
]
