# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore.lua#L62-L72
{
  enabled = true;
  autochdir = false;
  notify = false;
  scope = "global";

  detector = [
    "lsp"
    [
      ".git"
      "_darcs"
      ".hg"
      ".bzr"
      ".svn"
    ]
    [
      "lua"
      "MakeFile"
      "package.json"
    ]
  ];

  ignore = {
    dirs = { };
    servers = { };
  };
}
