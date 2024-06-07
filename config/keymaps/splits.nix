# Split navigation
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L107-L114
[
  {
    key = "<C-H>";
    action = "<C-w>h";
    options.desc = "Move to left split";
  }
  {
    key = "<C-J>";
    action = "<C-w>j";
    options.desc = "Move to below split";
  }
  {
    key = "<C-K>";
    action = "<C-w>k";
    options.desc = "Move to above split";
  }
  {
    key = "<C-L>";
    action = "<C-w>l";
    options.desc = "Move to right split";
  }
  {
    key = "<C-Up>";
    action = "<Cmd>resize -2<CR>";
    options.desc = "Resize split up";
  }
  {
    key = "<C-Down>";
    action = "<Cmd>resize +2<CR>";
    options.desc = "Resize split down";
  }
  {
    key = "<C-Left>";
    action = "<Cmd>vertical resize -2<CR>";
    options.desc = "Resize split left";
  }
  {
    key = "<C-Right>";
    action = "<Cmd>vertical resize +2<CR>";
    options.desc = "Resize split right";
  }
]
