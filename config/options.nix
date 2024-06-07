# Neovim options
# Use :options to get the list of all options
# Use :h <option> to load help for given <option>
{
  opts = {
    # Show substitution preview in split window
    inccommand = "split";

    # Enable list mode
    list = true;

    # Set custom strings for list mode
    # - tabulations are shown as ‒▶
    # - trailing spaces are shown as ·
    # - multiple non-leading consecutive spaces are shown as bullets (·)
    # - non-breakable spaces are shown as ⎕
    listchars = "tab:‒▶,trail:·,multispace:·,lead: ,nbsp:⎕";

    # Minimal number of lines to keep around the cursor
    # This has the effect to move the view along with current line
    #scrolloff = 999;

    # Number of spaces input on <Tab>
    softtabstop = 2;
  };
}
