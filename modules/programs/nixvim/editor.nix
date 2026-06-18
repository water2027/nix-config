{
  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            javascript = [
              "eslint_d"
              "prettier"
            ];
            typescript = [
              "eslint_d"
              "prettier"
            ];
            javascriptreact = [
              "eslint_d"
              "prettier"
            ];
            typescriptreact = [
              "eslint_d"
              "prettier"
            ];
            vue = [
              "eslint_d"
              "prettier"
            ];
          };
        };
      };

      mini-ai.enable = true;
      mini-cursorword.enable = true;
      mini-surround.enable = true;
      mini-splitjoin.enable = true;
      mini-trailspace.enable = true;
      mini-indentscope = {
        enable = true;
        settings = {
          draw.animation.__raw = "require('mini.indentscope').gen_animation.none()";
        };
      };

      todo-comments = {
        enable = true;
        keymaps = {
          todoFzfLua = {
            key = "<leader>fT";
            options.desc = "Find TODOs";
          };
          todoTrouble = {
            key = "<leader>xt";
            options.desc = "TODOs";
          };
        };
      };

      trouble.enable = true;
      direnv.enable = true;
      comment.enable = true;
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format({ lsp_fallback = true })<CR>";
        options.desc = "Format file";
      }
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options.desc = "Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
        options.desc = "Buffer diagnostics panel";
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>";
        options.desc = "Previous diagnostic";
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>";
        options.desc = "Next diagnostic";
      }
      {
        mode = "n";
        key = "<C-/>";
        action.__raw = ''
          function()
            require("Comment.api").toggle.linewise.current()
          end
        '';
        options.desc = "Toggle comment";
      }
      {
        mode = "n";
        key = "<C-_>";
        action.__raw = ''
          function()
            require("Comment.api").toggle.linewise.current()
          end
        '';
        options.desc = "Toggle comment";
      }
      {
        mode = "x";
        key = "<C-/>";
        action.__raw = ''
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
          end
        '';
        options.desc = "Toggle comment";
      }
      {
        mode = "x";
        key = "<C-_>";
        action.__raw = ''
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
            require("Comment.api").toggle.linewise(vim.fn.visualmode())
          end
        '';
        options.desc = "Toggle comment";
      }
    ];
  };
}
