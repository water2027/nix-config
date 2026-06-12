{ pkgs, lib, ... }:
{
  programs.nixvim.plugins.dap.enable = true;
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
}
