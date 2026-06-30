{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.lsp =
      let
        fallbackLsp = {
          enable = true;
          packageFallback = true;
        };
      in
      {
        enable = true;
        capabilities = ''
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        '';
        servers = {
          nixd = fallbackLsp;
          clangd = fallbackLsp;
          gopls = fallbackLsp;

          rust_analyzer = fallbackLsp // {
            installCargo = false;
            installRustc = false;
            installRustfmt = false;
          };
          tsgo = fallbackLsp;
          eslint = fallbackLsp;
          vue_ls = fallbackLsp // {
            package = pkgs.vue-language-server;
            vtslsIntegration = false;
          };
          html = fallbackLsp;
          cssls = fallbackLsp;
          jsonls = fallbackLsp // {
            settings = {
              json = {
                validate.enable = true;
              };
            };
          };
          pyright = fallbackLsp;
          tinymist = fallbackLsp;
        };
      };

    extraPlugins = with pkgs.vimPlugins; [
      hover-nvim
    ];

    extraConfigLua = builtins.readFile ./lua/hover.lua;

    keymaps = [
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        options.desc = "Go to declaration";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options.desc = "Implementation";
      }
      {
        mode = "n";
        key = "K";
        action.__raw = ''
          function()
            local bufnr = vim.api.nvim_get_current_buf()
            local hover_win = vim.b[bufnr].hover_preview

            if hover_win and vim.api.nvim_win_is_valid(hover_win) then
              require("hover").enter()
              return
            end

            require("hover").open()
          end
        '';
        options.desc = "Diagnostics and LSP hover";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "<leader>cr";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename symbol";
      }
    ];
  };
}
