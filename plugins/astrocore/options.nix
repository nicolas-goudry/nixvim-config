{ lib, ... }:

{
  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_options.lua#L49-L53
  astrocore = {
    g.markdown_recommended_style = 0;

    t.bufs.__raw = ''
      (function()
        if not vim.t.bufs then vim.t.bufs = vim.api.nvim_list_bufs() end
        return vim.t.bufs
      end)()
    '';
  };

  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astrocore_options.lua#L6-L47
  opts = {
    # Don't stop backspace at insert
    backspace = lib.mkDefault {
      __raw = ''
        vim.list_extend(vim.opt.backspace:get(), { "nostop" })
      '';
    };

    # Wrap indent to match line start
    breakindent = lib.mkDefault true;

    # Connection to the system clipboard
    clipboard = lib.mkDefault "unnamedplus";

    # Hide command line unless needed
    cmdheight = lib.mkDefault 0;

    # Options for insert mode completion
    completeopt = lib.mkDefault [ "menu" "menuone" "noselect" ];

    # Raise a dialog asking if you wish to save the current file(s)
    confirm = lib.mkDefault true;

    # Copy the previous indentation on autoindenting
    copyindent = lib.mkDefault true;

    # Highlight the text line of the cursor
    cursorline = lib.mkDefault true;

    # Enable linematch diff algorithm
    diffopt = lib.mkDefault {
      __raw = ''
        vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
      '';
    };

    # Enable the use of space in tab
    expandtab = lib.mkDefault true;

    # Disable `~` on nonexistent lines
    fillchars = lib.mkDefault { eob = " "; };

    # Show foldcolumn
    foldcolumn = lib.mkDefault "1";

    # Enable fold for nvim-ufo
    foldenable = lib.mkDefault true;

    # Set high foldlevel for nvim-ufo
    foldlevel = lib.mkDefault 99;

    # Start with all code unfolded
    foldlevelstart = lib.mkDefault 99;

    # Case insensitive searching
    ignorecase = lib.mkDefault true;

    # Infer cases in keyword completion
    infercase = lib.mkDefault true;

    # Global statusline
    laststatus = lib.mkDefault 3;

    # Wrap lines at 'breakat'
    linebreak = lib.mkDefault true;

    # Enable mouse support
    mouse = lib.mkDefault "a";

    # Show numberline
    number = lib.mkDefault true;

    # Preserve indent structure as much as possible
    preserveindent = lib.mkDefault true;

    # Height of the pop up menu
    pumheight = lib.mkDefault 10;

    # Show relative numberline
    relativenumber = lib.mkDefault true;

    # Number of space inserted for indentation; when zero the 'tabstop' value will be used
    shiftwidth = lib.mkDefault 0;

    # Disable search count wrap and startup messages
    shortmess = lib.mkDefault {
      __raw = ''
        vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true })
      '';
    };

    # Disable showing modes in command line
    showmode = lib.mkDefault false;

    # Always display tabline
    showtabline = lib.mkDefault 2;

    # Always show the sign column
    signcolumn = lib.mkDefault "yes";

    # Case sensitive searching
    smartcase = lib.mkDefault true;

    # Splitting a new window below the current one
    splitbelow = lib.mkDefault true;

    # Splitting a new window at the right of the current one
    splitright = lib.mkDefault true;

    # Number of space in a tab
    tabstop = lib.mkDefault 2;

    # Enable 24-bit RGB color in the TUI
    termguicolors = lib.mkDefault true;

    # Shorten key timeout length a little bit for which-key
    timeoutlen = lib.mkDefault 500;

    # Set terminal title to the filename and path
    title = lib.mkDefault true;

    # Enable persistent undo
    undofile = lib.mkDefault true;

    # Length of time to wait before triggering the plugin
    updatetime = lib.mkDefault 300;

    viewoptions = lib.mkDefault {
      __raw = ''
        vim.tbl_filter(function(val) return val ~= "curdir" end, vim.opt.viewoptions:get())
      '';
    };

    # Allow going past end of line in visual block mode
    virtualedit = lib.mkDefault "block";

    # Disable wrapping of lines longer than the width of window
    wrap = lib.mkDefault false;

    # Disable making a backup before overwriting a file
    writebackup = lib.mkDefault false;
  };
}
