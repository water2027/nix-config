{ pkgs, lib, ... }:
{
  programs.nixvim.plugins.dap.enable = true;
  programs.nixvim.plugins.dap-ui.enable = true;

  programs.nixvim.extraConfigLua = ''
    local dap = require("dap")
    local dapui = require("dapui")
    local js_debug = "${lib.getExe pkgs.vscode-js-debug}"
    local codelldb = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb"

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

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

    dap.configurations.go = {
      {
        type = "go",
        request = "launch",
        name = "Debug current file",
        program = "''${file}",
      },
      {
        type = "go",
        request = "launch",
        name = "Debug current package",
        program = "''${fileDirname}",
      },
      {
        type = "go",
        request = "attach",
        name = "Attach Go process",
        mode = "local",
        processId = require("dap.utils").pick_process,
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

    dap.configurations.rust = {
      {
        type = "codelldb",
        request = "launch",
        name = "Launch executable",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "''${workspaceFolder}",
        stopOnEntry = false,
      },
      {
        type = "codelldb",
        request = "attach",
        name = "Attach Rust process",
        pid = require("dap.utils").pick_process,
        cwd = "''${workspaceFolder}",
      },
    }

    local function web_url()
      if vim.env.DAP_WEB_URL ~= nil and vim.env.DAP_WEB_URL ~= "" then
        return vim.env.DAP_WEB_URL
      end

      return vim.fn.input("Dev server URL: ", "http://localhost:5173")
    end

    for _, language in ipairs({
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "vue",
    }) do
      dap.configurations[language] = {
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch Chrome",
          url = web_url,
          webRoot = "''${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-chrome",
          request = "attach",
          name = "Attach Chrome: 9222",
          port = 9222,
          webRoot = "''${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file with Node",
          program = "''${file}",
          cwd = "''${workspaceFolder}",
          sourceMaps = true,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach Node process",
          processId = require("dap.utils").pick_process,
          cwd = "''${workspaceFolder}",
          sourceMaps = true,
        },
      }
    end
  '';
}
