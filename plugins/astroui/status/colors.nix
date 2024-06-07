{
  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astroui_status.lua#L39-L57
  fallback = {
    none = "NONE";
    fg = "#abb2bf";
    bg = "#1e222a";
    dark_bg = "#2c323c";
    blue = "#61afef";
    green = "#98c379";
    grey = "#5c6370";
    bright_grey = "#777d86";
    dark_grey = "#5c5c5c";
    orange = "#ff9640";
    purple = "#c678dd";
    bright_purple = "#a9a1e1";
    red = "#e06c75";
    bright_red = "#ec5f67";
    white = "#c9c9c9";
    yellow = "#e5c07b";
    bright_yellow = "#ebae34";
  };

  # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astroui_status.lua#L118-L239
  setup.__raw = ''
    function()
      local astroui = require "astroui"
      ---@type AstroUIStatusOpts
      local status_opts = astroui.config.status
      local color = assert(status_opts.fallback_colors)
      local get_hlgroup = astroui.get_hlgroup
      local lualine_mode = require("astroui.status.hl").lualine_mode
      local function resolve_lualine(orig, ...) return (not orig or orig == "NONE") and lualine_mode(...) or orig end

      local Normal = get_hlgroup("Normal", { fg = color.fg, bg = color.bg })
      local Comment = get_hlgroup("Comment", { fg = color.bright_grey, bg = color.bg })
      local Error = get_hlgroup("Error", { fg = color.red, bg = color.bg })
      local StatusLine = get_hlgroup("StatusLine", { fg = color.fg, bg = color.dark_bg })
      local TabLine = get_hlgroup("TabLine", { fg = color.grey, bg = color.none })
      local TabLineFill = get_hlgroup("TabLineFill", { fg = color.fg, bg = color.dark_bg })
      local TabLineSel = get_hlgroup("TabLineSel", { fg = color.fg, bg = color.none })
      local WinBar = get_hlgroup("WinBar", { fg = color.bright_grey, bg = color.bg })
      local WinBarNC = get_hlgroup("WinBarNC", { fg = color.grey, bg = color.bg })
      local Conditional = get_hlgroup("Conditional", { fg = color.bright_purple, bg = color.dark_bg })
      local String = get_hlgroup("String", { fg = color.green, bg = color.dark_bg })
      local TypeDef = get_hlgroup("TypeDef", { fg = color.yellow, bg = color.dark_bg })
      local NvimEnvironmentName = get_hlgroup("NvimEnvironmentName", { fg = color.yellow, bg = color.dark_bg })
      local GitSignsAdd = get_hlgroup("GitSignsAdd", { fg = color.green, bg = color.dark_bg })
      local GitSignsChange = get_hlgroup("GitSignsChange", { fg = color.orange, bg = color.dark_bg })
      local GitSignsDelete = get_hlgroup("GitSignsDelete", { fg = color.bright_red, bg = color.dark_bg })
      local DiagnosticError = get_hlgroup("DiagnosticError", { fg = color.bright_red, bg = color.dark_bg })
      local DiagnosticWarn = get_hlgroup("DiagnosticWarn", { fg = color.orange, bg = color.dark_bg })
      local DiagnosticInfo = get_hlgroup("DiagnosticInfo", { fg = color.white, bg = color.dark_bg })
      local DiagnosticHint = get_hlgroup("DiagnosticHint", { fg = color.bright_yellow, bg = color.dark_bg })
      local HeirlineInactive =
        resolve_lualine(get_hlgroup("HeirlineInactive", { bg = nil }).bg, "inactive", color.dark_grey)
      local HeirlineNormal = resolve_lualine(get_hlgroup("HeirlineNormal", { bg = nil }).bg, "normal", color.blue)
      local HeirlineInsert = resolve_lualine(get_hlgroup("HeirlineInsert", { bg = nil }).bg, "insert", color.green)
      local HeirlineVisual = resolve_lualine(get_hlgroup("HeirlineVisual", { bg = nil }).bg, "visual", color.purple)
      local HeirlineReplace =
        resolve_lualine(get_hlgroup("HeirlineReplace", { bg = nil }).bg, "replace", color.bright_red)
      local HeirlineCommand =
        resolve_lualine(get_hlgroup("HeirlineCommand", { bg = nil }).bg, "command", color.bright_yellow)
      local HeirlineTerminal =
        resolve_lualine(get_hlgroup("HeirlineTerminal", { bg = nil }).bg, "insert", HeirlineInsert)

      local colors = {
        close_fg = Error.fg,
        fg = StatusLine.fg,
        bg = StatusLine.bg,
        section_fg = StatusLine.fg,
        section_bg = StatusLine.bg,
        git_branch_fg = Conditional.fg,
        mode_fg = StatusLine.bg,
        treesitter_fg = String.fg,
        virtual_env_fg = NvimEnvironmentName.fg,
        scrollbar = TypeDef.fg,
        git_added = GitSignsAdd.fg,
        git_changed = GitSignsChange.fg,
        git_removed = GitSignsDelete.fg,
        diag_ERROR = DiagnosticError.fg,
        diag_WARN = DiagnosticWarn.fg,
        diag_INFO = DiagnosticInfo.fg,
        diag_HINT = DiagnosticHint.fg,
        winbar_fg = WinBar.fg,
        winbar_bg = WinBar.bg,
        winbarnc_fg = WinBarNC.fg,
        winbarnc_bg = WinBarNC.bg,
        tabline_bg = TabLineFill.bg,
        tabline_fg = TabLineFill.bg,
        buffer_fg = Comment.fg,
        buffer_path_fg = WinBarNC.fg,
        buffer_close_fg = Comment.fg,
        buffer_bg = TabLineFill.bg,
        buffer_active_fg = Normal.fg,
        buffer_active_path_fg = WinBarNC.fg,
        buffer_active_close_fg = Error.fg,
        buffer_active_bg = Normal.bg,
        buffer_visible_fg = Normal.fg,
        buffer_visible_path_fg = WinBarNC.fg,
        buffer_visible_close_fg = Error.fg,
        buffer_visible_bg = Normal.bg,
        buffer_overflow_fg = Comment.fg,
        buffer_overflow_bg = TabLineFill.bg,
        buffer_picker_fg = Error.fg,
        tab_close_fg = Error.fg,
        tab_close_bg = TabLineFill.bg,
        tab_fg = TabLine.fg,
        tab_bg = TabLine.bg,
        tab_active_fg = TabLineSel.fg,
        tab_active_bg = TabLineSel.bg,
        inactive = HeirlineInactive,
        normal = HeirlineNormal,
        insert = HeirlineInsert,
        visual = HeirlineVisual,
        replace = HeirlineReplace,
        command = HeirlineCommand,
        terminal = HeirlineTerminal,
      }

      local user_colors = status_opts.colors
      if type(user_colors) == "table" then
        colors = require("astrocore").extend_tbl(colors, user_colors)
      elseif type(user_colors) == "function" then
        local new_colors = user_colors(colors)
        if new_colors then colors = new_colors end
      end

      for _, section in ipairs {
        "git_branch",
        "file_info",
        "git_diff",
        "diagnostics",
        "lsp",
        "macro_recording",
        "mode",
        "cmd_info",
        "treesitter",
        "nav",
        "virtual_env",
      } do
        if not colors[section .. "_bg"] then colors[section .. "_bg"] = colors["section_bg"] end
        if not colors[section .. "_fg"] then colors[section .. "_fg"] = colors["section_fg"] end
      end

      return colors
    end
  '';
}
