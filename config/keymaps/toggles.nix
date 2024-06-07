# UI/UX toggles
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L128-L145
[
  {
    mode = "n";
    key = "<Leader>uA";
    options.desc = "Toggle rooter autochdir";

    action.__raw = ''
      function()
        require("astrocore.toggles").autochdir()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>ub";
    options.desc = "Toggle background";

    action.__raw = ''
      function()
        require("astrocore.toggles").background()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>ud";
    options.desc = "Toggle diagnostics";

    action.__raw = ''
      function()
        require("astrocore.toggles").diagnostics()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>ug";
    options.desc = "Toggle signcolumn";

    action.__raw = ''
      function()
        require("astrocore.toggles").signcolumn()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>u>";
    options.desc = "Toggle foldcolumn";

    action.__raw = ''
      function()
        require("astrocore.toggles").foldcolumn()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>ui";
    options.desc = "Change indent setting";

    action.__raw = ''
      function()
        require("astrocore.toggles").indent()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>ul";
    options.desc = "Toggle statusline";

    action.__raw = ''
      function()
        require("astrocore.toggles").statusline()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>un";
    options.desc = "Change line numbering";

    action.__raw = ''
      function()
        require("astrocore.toggles").number()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>uN";
    options.desc = "Toggle Notifications";

    action.__raw = ''
      function()
        require("astrocore.toggles").notifications()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>up";
    options.desc = "Toggle paste mode";

    action.__raw = ''
      function()
        require("astrocore.toggles").paste()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>us";
    options.desc = "Toggle spellcheck";

    action.__raw = ''
      function()
        require("astrocore.toggles").spell()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>uS";
    options.desc = "Toggle conceal";

    action.__raw = ''
      function()
        require("astrocore.toggles").conceal()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>ut";
    options.desc = "Toggle tabline";

    action.__raw = ''
      function()
        require("astrocore.toggles").tabline()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>uu";
    options.desc = "Toggle URL highlight";

    action.__raw = ''
      function()
        require("astrocore.toggles").url_match()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>uw";
    options.desc = "Toggle wrap";

    action.__raw = ''
      function()
        require("astrocore.toggles").wrap()
      end
    '';
  }
  {
    mode = "n";
    key = "<Leader>uy";
    options.desc = "Toggle syntax highlight";

    action.__raw = ''
      function()
        require("astrocore.toggles").buffer_syntax()
      end
    '';
  }
]
