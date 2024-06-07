# UI/UX toggles
# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_mappings.lua#L128-L145
[
  {
    key = "<Leader>uA";
    options.desc = "Toggle rooter autochdir";

    action.__raw = ''
      function()
        require("astrocore.toggles").autochdir()
      end
    '';
  }
  {
    key = "<Leader>ub";
    options.desc = "Toggle background";

    action.__raw = ''
      function()
        require("astrocore.toggles").background()
      end
    '';
  }
  {
    key = "<Leader>ud";
    options.desc = "Toggle diagnostics";

    action.__raw = ''
      function()
        require("astrocore.toggles").diagnostics()
      end
    '';
  }
  {
    key = "<Leader>ug";
    options.desc = "Toggle signcolumn";

    action.__raw = ''
      function()
        require("astrocore.toggles").signcolumn()
      end
    '';
  }
  {
    key = "<Leader>u>";
    options.desc = "Toggle foldcolumn";

    action.__raw = ''
      function()
        require("astrocore.toggles").foldcolumn()
      end
    '';
  }
  {
    key = "<Leader>ui";
    options.desc = "Change indent setting";

    action.__raw = ''
      function()
        require("astrocore.toggles").indent()
      end
    '';
  }
  {
    key = "<Leader>ul";
    options.desc = "Toggle statusline";

    action.__raw = ''
      function()
        require("astrocore.toggles").statusline()
      end
    '';
  }
  {
    key = "<Leader>un";
    options.desc = "Change line numbering";

    action.__raw = ''
      function()
        require("astrocore.toggles").number()
      end
    '';
  }
  {
    key = "<Leader>uN";
    options.desc = "Toggle Notifications";

    action.__raw = ''
      function()
        require("astrocore.toggles").notifications()
      end
    '';
  }
  {
    key = "<Leader>up";
    options.desc = "Toggle paste mode";

    action.__raw = ''
      function()
        require("astrocore.toggles").paste()
      end
    '';
  }
  {
    key = "<Leader>us";
    options.desc = "Toggle spellcheck";

    action.__raw = ''
      function()
        require("astrocore.toggles").spell()
      end
    '';
  }
  {
    key = "<Leader>uS";
    options.desc = "Toggle conceal";

    action.__raw = ''
      function()
        require("astrocore.toggles").conceal()
      end
    '';
  }
  {
    key = "<Leader>ut";
    options.desc = "Toggle tabline";

    action.__raw = ''
      function()
        require("astrocore.toggles").tabline()
      end
    '';
  }
  {
    key = "<Leader>uu";
    options.desc = "Toggle URL highlight";

    action.__raw = ''
      function()
        require("astrocore.toggles").url_match()
      end
    '';
  }
  {
    key = "<Leader>uw";
    options.desc = "Toggle wrap";

    action.__raw = ''
      function()
        require("astrocore.toggles").wrap()
      end
    '';
  }
  {
    key = "<Leader>uy";
    options.desc = "Toggle syntax highlight";

    action.__raw = ''
      function()
        require("astrocore.toggles").buffer_syntax()
      end
    '';
  }
]
