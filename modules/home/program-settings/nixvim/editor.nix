{
  lib,
  pkgs,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  fcitx5Remote = lib.getExe' pkgs.fcitx5 "fcitx5-remote";
in
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
  }
  // lib.optionalAttrs isLinux {
    extraConfigLua = ''
      local fcitx5_remote = "${fcitx5Remote}"
      local fcitx5_was_active = false

      local function fcitx5_available()
        return vim.fn.executable(fcitx5_remote) == 1
      end

      local function fcitx5_is_active()
        if not fcitx5_available() then
          return false
        end

        local state = vim.fn.system({ fcitx5_remote })
        return vim.v.shell_error == 0 and vim.trim(state) == "2"
      end

      local function fcitx5_close()
        if fcitx5_available() then
          vim.fn.jobstart({ fcitx5_remote, "-c" }, { detach = true })
        end
      end

      local function fcitx5_open()
        if fcitx5_available() then
          vim.fn.jobstart({ fcitx5_remote, "-o" }, { detach = true })
        end
      end

      local insert_modes = {
        i = true,
        ic = true,
        ix = true,
        R = true,
        Rc = true,
        Rx = true,
        Rv = true,
        Rvc = true,
        Rvx = true,
      }

      local function came_from_insert_mode(match)
        local previous_mode = match:match("^(.-):")
        return insert_modes[previous_mode] == true
      end

      local fcitx5_group = vim.api.nvim_create_augroup("Fcitx5InputMode", { clear = true })

      vim.api.nvim_create_autocmd("ModeChanged", {
        group = fcitx5_group,
        pattern = "*:n",
        callback = function(event)
          if came_from_insert_mode(event.match) then
            fcitx5_was_active = fcitx5_is_active()
          end

          fcitx5_close()
        end,
      })

      vim.api.nvim_create_autocmd("InsertEnter", {
        group = fcitx5_group,
        callback = function()
          if fcitx5_was_active then
            fcitx5_open()
          end
        end,
      })
    '';
  };
}
