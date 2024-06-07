# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore.lua#L40-L61
{ icons, ... }:

{
  underline = true;
  update_in_insert = true;
  severity_sort = true;
  virtual_text = true;

  float = {
    focused = false;
    style = "minimal";
    border = "rounded";
    source = "always";
    header = "";
    prefix = "";
  };

  signs = {
    text = {
      # vim.diagnostic.severity.ERROR
      "1" = icons.DiagnosticError;
      # vim.diagnostic.severity.WARN
      "2" = icons.DiagnosticWarn;
      # vim.diagnostic.severity.INFO
      "3" = icons.DiagnosticInfo;
      # vim.diagnostic.severity.HINT
      "4" = icons.DiagnosticHint;
    };
  };
}
