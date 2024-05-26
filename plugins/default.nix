# This file will load all plugins defined in the current directory (plugins)
# and load their content in the 'plugins' nixvim attribute.

# Each plugin file must export a lambda, which is called with an attrset
# containing nixpkgs library as 'lib'. Plugins may or may not use it.

# For plugins natively supported by nixvim, the plugin file must have the same
# name as the plugin attribute name expected by nixvim (ie. 'telescope.nix' for
# 'plugins.telescope'). The plugin lambda must return an attrset with at least
# the 'opts' attribute, this attribute is the plugin options as expected by
# nixvim.

# For plugins not supported by nixvim, the plugin file can have any name. The
# plugin lambda must return an attrset with the 'extra' attribute which is also
# an attrset with two attributes: 'package' and 'config'. The 'package'
# attribute is the plugin package in nixpkgs (ie. vimPlugins.<plugin>). The
# 'config' attribute is the plugin configuration in Lua format.

# Additionally, a 'rootOpts' can be returned alongside other attributes, this
# attribute will be used to set extra options to the root nixvim options. For
# example, this allows to set keymaps for plugins that do not have an internal
# option to set keymaps.

{ lib, ... }@args:

let
  # Flag to enable LSP plugin with servers
  # Given as an extra special arg when building nixvim module
  withLSP = args.withLSP or true;

  # Load plugins filenames in list
  definitions = lib.attrNames (
    lib.filterAttrs
      (filename: kind:
        filename != "default.nix"
        && (kind == "regular" || kind == "directory")
        # If file is an LSP plugin, respect withLSP flag
        && (if filename == "lsp.nix" then withLSP else true)
      )
      (builtins.readDir ./.)
  );
in
lib.mkMerge (
  map
    (file:
    let
      pluginName = lib.elemAt (lib.splitString "." file) 0;
      plugin = import ./${file} args;
    in
    lib.mkMerge [
      (lib.optionalAttrs (plugin ? opts) {
        plugins.${pluginName} = plugin.opts;
      })
      (lib.optionalAttrs (plugin ? extra) {
        extraConfigLua = plugin.extra.config or "";
        extraPlugins = plugin.extra.packages;
      })
      (plugin.rootOpts or { })
    ]
    )
    definitions
)
