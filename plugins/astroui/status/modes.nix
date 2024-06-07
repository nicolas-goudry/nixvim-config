# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astroui_status.lua#L58-L93
{
  # Forced to use raw Lua value to avoid Nix transforming special chars to unicode sequence
  __raw = ''
    {
      ["n"] = { "NORMAL", "normal" },
      ["no"] = { "OP", "normal" },
      ["nov"] = { "OP", "normal" },
      ["noV"] = { "OP", "normal" },
      ["no"] = { "OP", "normal" },
      ["niI"] = { "NORMAL", "normal" },
      ["niR"] = { "NORMAL", "normal" },
      ["niV"] = { "NORMAL", "normal" },
      ["i"] = { "INSERT", "insert" },
      ["ic"] = { "INSERT", "insert" },
      ["ix"] = { "INSERT", "insert" },
      ["t"] = { "TERM", "terminal" },
      ["nt"] = { "TERM", "terminal" },
      ["v"] = { "VISUAL", "visual" },
      ["vs"] = { "VISUAL", "visual" },
      ["V"] = { "LINES", "visual" },
      ["Vs"] = { "LINES", "visual" },
      [""] = { "BLOCK", "visual" },
      ["s"] = { "BLOCK", "visual" },
      ["R"] = { "REPLACE", "replace" },
      ["Rc"] = { "REPLACE", "replace" },
      ["Rx"] = { "REPLACE", "replace" },
      ["Rv"] = { "V-REPLACE", "replace" },
      ["s"] = { "SELECT", "visual" },
      ["S"] = { "SELECT", "visual" },
      [""] = { "BLOCK", "visual" },
      ["c"] = { "COMMAND", "command" },
      ["cv"] = { "COMMAND", "command" },
      ["ce"] = { "COMMAND", "command" },
      ["r"] = { "PROMPT", "inactive" },
      ["rm"] = { "MORE", "inactive" },
      ["r?"] = { "CONFIRM", "inactive" },
      ["!"] = { "SHELL", "inactive" },
      ["null"] = { "null", "inactive" },
    }
  '';
}
