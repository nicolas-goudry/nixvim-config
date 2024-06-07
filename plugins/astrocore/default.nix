# homepage: https://github.com/AstroNvim/astrocore
{ helpers, icons, lib, pkgs, ... }:

let
  autocmds = import ./autocmds.nix;
  diagnostics = import ./diagnostics.nix { inherit icons; };
  features = import ./features.nix;
  mappings = import ./mappings.nix;
  options = import ./options.nix { inherit lib; };
  rooter = import ./rooter.nix;
  sessions = import ./sessions.nix;
in
{
  extra = {
    packages = [
      (import ./package { inherit lib pkgs; })
    ];

    config = ''
      require("astrocore").setup({
        diagnostics = ${helpers.toLuaObject diagnostics},
        features = ${helpers.toLuaObject features},
        options = ${helpers.toLuaObject options.astrocore},
        rooter = ${helpers.toLuaObject rooter},
        sessions = ${helpers.toLuaObject sessions},
        on_keys = {
          auto_hlsearch = {
            function(char)
              if vim.fn.mode() == "n" then
                local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
                if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
              end
            end,
          },
        },
      })
    '';
  };

  rootOpts = {
    inherit (autocmds) autoGroups autoCmd;
    inherit (mappings) keymaps;
    inherit (options) opts;

    plugins.which-key.registrations = mappings.mapSections;
  };
}
