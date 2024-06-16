{ icons, pkgs, ... }:

{
  extra = {
    packages = [ pkgs.vimPlugins.nvim-dap-ui ];

    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/configs/nvim-dap-ui.lua
    # https://github.com/AstroNvim/AstroNvim/blob/v4.7.7/lua/astronvim/plugins/dap.lua#L37
    config = ''
      local dap, dapui = require "dap", require "dapui"

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      dapui.setup({ floating = { border = "rounded" } })
    '';
  };

  opts = {
    enable = true;

    signs = {
      dapBreakpoint = {
        text = icons.DapBreakpoint;
        texthl = "DiagnosticInfo";
      };

      dapBreakpointCondition = {
        text = icons.DapBreakpointCondition;
        texthl = "DiagnosticInfo";
      };

      dapBreakpointRejected = {
        text = icons.DapBreakpointRejected;
        texthl = "DiagnosticError";
      };

      dapLogPoint = {
        text = icons.DapLogPoint;
        texthl = "DiagnosticInfo";
      };

      dapStopped = {
        text = icons.DapStopped;
        texthl = "DiagnosticWarn";
      };
    };
  };

  # rootOpts.plugins.cmp-dap.enable = true;
  rootOpts.keymaps = [
    {
      mode = "n";
      key = "<leader>dE";
      options.desc = "Evaluate input";

      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Expression: " }, function(expr)
            if expr then require("dapui").eval(expr, { enter = true }) end
          end)
        end
      '';
    }
    {
      mode = "n";
      key = "<Leader>du";
      action.__raw = "function() require('dapui').toggle() end";
      options.desc = "Toggle Debugger UI";
    }
    {
      mode = "n";
      key = "<Leader>dh";
      action.__raw = "function() require('dap.ui.widgets').hover() end";
      options.desc = "Debugger Hover";
    }
    {
      mode = "v";
      key = "<Leader>dE";
      action.__raw = "function() require('dapui').eval() end";
      options.desc = "Evaluate Input";
    }
    {
      mode = "n";
      key = "<F5>";
      action.__raw = "function() require('dap').continue() end";
      options.desc = "Debugger: Start";
    }
    # Shift+F5
    {
      mode = "n";
      key = "<F17>";
      action.__raw = "function() require('dap').terminate() end";
      options.desc = "Debugger: Stop";
    }
    # Shift+F9
    {
      mode = "n";
      key = "<F21>";
      options.desc = "Debugger: Conditional Breakpoint";

      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then require("dap").set_breakpoint(condition) end
          end)
        end
      '';
    }
    # Control+F5
    {
      mode = "n";
      key = "<F29>";
      action.__raw = "function() require('dap').restart_frame() end";
      options.desc = "Debugger: Restart";
    }
    {
      mode = "n";
      key = "<F6>";
      action.__raw = "function() require('dap').pause() end";
      options.desc = "Debugger: Pause";
    }
    {
      mode = "n";
      key = "<F9>";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options.desc = "Debugger: Toggle Breakpoint";
    }
    {
      mode = "n";
      key = "<F10>";
      action.__raw = "function() require('dap').step_over() end";
      options.desc = "Debugger: Step Over";
    }
    {
      mode = "n";
      key = "<F11>";
      action.__raw = "function() require('dap').step_into() end";
      options.desc = "Debugger: Step Into";
    }
    # Shift+F11
    {
      mode = "n";
      key = "<F23>";
      action.__raw = "function() require('dap').step_out() end";
      options.desc = "Debugger: Step Out";
    }
    {
      mode = "n";
      key = "<Leader>db";
      action.__raw = "function() require('dap').toggle_breakpoint() end";
      options.desc = "Toggle Breakpoint (F9)";
    }
    {
      mode = "n";
      key = "<Leader>dB";
      action.__raw = "function() require('dap').clear_breakpoints() end";
      options.desc = "Clear Breakpoints";
    }
    {
      mode = "n";
      key = "<Leader>dc";
      action.__raw = "function() require('dap').continue() end";
      options.desc = "Start/Continue (F5)";
    }
    {
      mode = "n";
      key = "<Leader>dC";
      options.desc = "Conditional Breakpoint (S-F9)";

      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Condition: " }, function(condition)
            if condition then require("dap").set_breakpoint(condition) end
          end)
        end
      '';
    }
    {
      mode = "n";
      key = "<Leader>di";
      action.__raw = "function() require('dap').step_into() end";
      options.desc = "Step Into (F11)";
    }
    {
      mode = "n";
      key = "<Leader>do";
      action.__raw = "function() require('dap').step_over() end";
      options.desc = "Step Over (F10)";
    }
    {
      mode = "n";
      key = "<Leader>dO";
      action.__raw = "function() require('dap').step_out() end";
      options.desc = "Step Out (S-F11)";
    }
    {
      mode = "n";
      key = "<Leader>dq";
      action.__raw = "function() require('dap').close() end";
      options.desc = "Close Session";
    }
    {
      mode = "n";
      key = "<Leader>dQ";
      action.__raw = "function() require('dap').terminate() end";
      options.desc = "Terminate Session (S-F5)";
    }
    {
      mode = "n";
      key = "<Leader>dp";
      action.__raw = "function() require('dap').pause() end";
      options.desc = "Pause (F6)";
    }
    {
      mode = "n";
      key = "<Leader>dr";
      action.__raw = "function() require('dap').restart_frame() end";
      options.desc = "Restart (C-F5)";
    }
    {
      mode = "n";
      key = "<Leader>dR";
      action.__raw = "function() require('dap').repl.toggle() end";
      options.desc = "Toggle REPL";
    }
    {
      mode = "n";
      key = "<Leader>ds";
      action.__raw = "function() require('dap').run_to_cursor() end";
      options.desc = "Run To Cursor";
    }
  ];
}
