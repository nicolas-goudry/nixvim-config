# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astroui_status.lua
let
  attributes = import ./attributes.nix;
  colors = import ./colors.nix;
  icon_highlights = import ./icon-highlights.nix;
  modes = import ./modes.nix;
  separators = import ./separators.nix;
  sign_handlers = import ./signs.nix;
in
{
  inherit attributes icon_highlights modes separators sign_handlers;

  fallback_colors = colors.fallback;
  setup_colors = colors.setup;
}
