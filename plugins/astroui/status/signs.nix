# https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/_astroui_status.lua#L5-L36
{
  __raw = ''
    (function()
      local sign_handlers = {}
      -- gitsigns handlers
      local gitsigns_handler = function(_)
        local gitsigns_avail, gitsigns = pcall(require, "gitsigns")
        if gitsigns_avail then vim.schedule(gitsigns.preview_hunk) end
      end
      for _, sign in ipairs { "Topdelete", "Untracked", "Add", "Change", "Changedelete", "Delete" } do
        local name = "GitSigns" .. sign
        if not sign_handlers[name] then sign_handlers[name] = gitsigns_handler end
      end
      sign_handlers["gitsigns_extmark_signs_"] = gitsigns_handler
      -- diagnostic handlers
      local diagnostics_handler = function(args)
        if args.mods:find "c" then
          vim.schedule(vim.lsp.buf.code_action)
        else
          vim.schedule(vim.diagnostic.open_float)
        end
      end
      for _, sign in ipairs { "Error", "Hint", "Info", "Warn" } do
        local name = "DiagnosticSign" .. sign
        if not sign_handlers[name] then sign_handlers[name] = diagnostics_handler end
      end
      -- DAP handlers
      local dap_breakpoint_handler = function(_)
        local dap_avail, dap = pcall(require, "dap")
        if dap_avail then vim.schedule(dap.toggle_breakpoint) end
      end
      for _, sign in ipairs { "", "Rejected", "Condition" } do
        local name = "DapBreakpoint" .. sign
        if not sign_handlers[name] then sign_handlers[name] = dap_breakpoint_handler end
      end

      return sign_handlers
    end)()
  '';
}
