# homepage: https://github.com/kevinhwang91/nvim-ufo
# nixvim doc: https://nix-community.github.io/nixvim/plugins/nvim-ufo/index.html
_:

{
  opts = {
    enable = true;

    preview.mappings = {
      scrollB = "<c-b>";
      scrollD = "<c-d>";
      scrollF = "<c-f>";
      scrollU = "<c-u>";
    };

    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/nvim-ufo.lua#L28-L44
    providerSelector = ''
      function(_, filetype, buftype)
        local function handleFallbackException(bufnr, err, providerName)
          if type(err) == "string" and err:match "UfoFallbackException" then
            return require("ufo").getFolds(bufnr, providerName)
          else
            return require("promise").reject(err)
          end
        end

        return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
          or function(bufnr)
            return require("ufo")
              .getFolds(bufnr, "lsp")
              :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
              :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
          end
      end
    '';
  };

  rootOpts.keymaps = [
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/nvim-ufo.lua#L15
    {
      mode = "n";
      key = "zp";
      action.__raw = "function() require('ufo').peekFoldedLinesUnderCursor() end";
      options.desc = "Peek fold";
    }
  ];
}
