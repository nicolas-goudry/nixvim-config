# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore.lua#L32-L39
{
  # Enable autopairs at start
  autopairs = true;

  # Enable completion at start
  cmp = true;

  # Enable diagnostics by default
  diagnostics_mode = 3;

  # Highlight URLs by default
  highlighturl = true;

  # Disable notifications
  notifications = true;

  # Set global limits for large files
  large_buf = {
    lines = 10000;
    size = 1024 * 500;
  };
}
