# Improved terminal navigation
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L121-L124
[
  {
    key = "<C-H>";
    mode = [ "t" ];
    action = "<Cmd>wincmd h<CR>";
    options.desc = "Terminal left window navigation";
  }
  {
    key = "<C-J>";
    mode = [ "t" ];
    action = "<Cmd>wincmd j<CR>";
    options.desc = "Terminal down window navigation";
  }
  {
    key = "<C-K>";
    mode = [ "t" ];
    action = "<Cmd>wincmd k<CR>";
    options.desc = "Terminal up window navigation";
  }
  {
    key = "<C-L>";
    mode = [ "t" ];
    action = "<Cmd>wincmd l<CR>";
    options.desc = "Terminal right window navigation";
  }
]
