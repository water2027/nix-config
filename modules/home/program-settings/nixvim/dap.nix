{ pkgs, lib, ... }:
{
  programs.nixvim.plugins.dap.enable = true;
  programs.nixvim.plugins.overseer.enable = true;
  programs.nixvim.plugins.dap-view = {
    enable = true;
    package = pkgs.vimPlugins.nvim-dap-view.overrideAttrs (_: {
      name = "vimplugin-nvim-dap-view-1.2.0";
      version = "1.2.0";
      src = pkgs.fetchFromGitHub {
        owner = "igorlfs";
        repo = "nvim-dap-view";
        rev = "v1.2.0";
        hash = "sha256-JRFLk+Ok8Fo8yJzwVxstcnfSIztsg+I+yQp+3g3DMcA=";
      };
    });
    settings = {
      auto_toggle = true;
      winbar.controls.enabled = true;
      windows.terminal.hide = [ "go" ];
    };
  };

  programs.nixvim.extraConfigLua = ''
    local dap = require("dap")
    local js_debug = "${lib.getExe pkgs.vscode-js-debug}"
    local codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"

    local function configure_dap_signs()
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff6188", bold = true })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ab9df2", bold = true })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#fc9867", bold = true })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#78dce8", bold = true })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#ffd866", bold = true })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#403622" })

      vim.fn.sign_define("DapBreakpoint", {
        text = "●",
        texthl = "DapBreakpoint",
        numhl = "DapBreakpoint",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = "◆",
        texthl = "DapBreakpointCondition",
        numhl = "DapBreakpointCondition",
      })
      vim.fn.sign_define("DapBreakpointRejected", {
        text = "○",
        texthl = "DapBreakpointRejected",
        numhl = "DapBreakpointRejected",
      })
      vim.fn.sign_define("DapLogPoint", {
        text = "◆",
        texthl = "DapLogPoint",
        numhl = "DapLogPoint",
      })
      vim.fn.sign_define("DapStopped", {
        text = "▶",
        texthl = "DapStopped",
        linehl = "DapStoppedLine",
        numhl = "DapStopped",
      })
    end

    configure_dap_signs()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = configure_dap_signs,
    })

    for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "pwa-msedge" }) do
      dap.adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "''${port}",
        executable = {
          command = js_debug,
          args = { "''${port}" },
        },
      }
    end

    dap.adapters.go = {
      type = "server",
      host = "127.0.0.1",
      port = "''${port}",
      executable = {
        command = "${lib.getExe pkgs.delve}",
        args = { "dap", "-l", "127.0.0.1:''${port}" },
      },
    }

    dap.adapters.codelldb = {
      type = "server",
      port = "''${port}",
      executable = {
        command = codelldb,
        args = { "--port", "''${port}" },
      },
    }
  '';

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<F5>";
      action = "<cmd>lua require('dap').continue()<CR>";
      options.desc = "DAP continue";
    }
    {
      mode = "n";
      key = "<F17>";
      action.__raw = ''
        function()
          require("dap").terminate()
          vim.cmd("DapViewClose!")
        end
      '';
      options.desc = "DAP stop";
    }
    {
      mode = "n";
      key = "<F4>";
      action = "<cmd>lua require('dap').restart()<CR>";
      options.desc = "DAP restart";
    }
    {
      mode = "n";
      key = "<F6>";
      action = "<cmd>lua require('dap').pause()<CR>";
      options.desc = "DAP pause";
    }
    {
      mode = "n";
      key = "<F9>";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
      options.desc = "DAP breakpoint";
    }
    {
      mode = "n";
      key = "<F10>";
      action = "<cmd>lua require('dap').step_over()<CR>";
      options.desc = "DAP step over";
    }
    {
      mode = "n";
      key = "<F11>";
      action = "<cmd>lua require('dap').step_into()<CR>";
      options.desc = "DAP step into";
    }
    {
      mode = "n";
      key = "<F23>";
      action = "<cmd>lua require('dap').step_out()<CR>";
      options.desc = "DAP step out";
    }
    {
      mode = "n";
      key = "<leader>dB";
      action.__raw = ''
        function()
          require("dap").clear_breakpoints()
        end
      '';
      options.desc = "DAP clear breakpoints";
    }
    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
            if condition and condition ~= "" then
              require("dap").set_breakpoint(condition)
            end
          end)
        end
      '';
      options.desc = "DAP conditional breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dh";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Hit condition: " }, function(hit_condition)
            if hit_condition and hit_condition ~= "" then
              require("dap").set_breakpoint(nil, hit_condition)
            end
          end)
        end
      '';
      options.desc = "DAP hit condition breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Log point message: " }, function(log_message)
            if log_message and log_message ~= "" then
              require("dap").set_breakpoint(nil, nil, log_message)
            end
          end)
        end
      '';
      options.desc = "DAP log point";
    }
    {
      mode = "n";
      key = "<leader>du";
      action = "<cmd>DapViewToggle!<CR>";
      options.desc = "DAP toggle UI";
    }
    {
      mode = "n";
      key = "<leader>dL";
      action = "<cmd>lua require('dap').run_last()<CR>";
      options.desc = "DAP run last";
    }
  ];
}
