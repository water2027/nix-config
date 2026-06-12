{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  home.packages = lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) (
    with pkgs;
    [
      nixfmt
    ]
  );

  programs.nixvim = {
    nixpkgs.source = inputs.nixpkgs.outPath;

    globals = {
      mapleader = ";";
      maplocalleader = ";";
    };
    enable = true;
    clipboard = {
      register = "unnamedplus";
    };
    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
      update_in_insert = false;
      severity_sort = true;
    };

    viAlias = true;
    vimAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      ignorecase = true;
      smartcase = true;
      splitright = true;
      splitbelow = true;
      scrolloff = 8;
      cursorline = true;
      updatetime = 250;
      timeoutlen = 500;
      showmode = false;
      laststatus = 3;
      signcolumn = "yes:2";
      ruler = false;
      foldenable = true;
      foldmethod = "indent";
      foldlevel = 99;
      foldlevelstart = 99;
      foldnestmax = 10;
      foldcolumn = "0";
    };

    plugins = {
      which-key.enable = true;
      gitsigns.enable = true;
      diffview.enable = true;
      neogit = {
        enable = true;
        settings = {
          integrations.diffview = true;
        };
      };
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          cmake
          cpp
          css
          dockerfile
          go
          gomod
          gosum
          html
          javascript
          json
          json5
          lua
          markdown
          markdown_inline
          nix
          python
          rust
          toml
          typst
          tsx
          typescript
          vue
          yaml
        ];
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      luasnip.enable = true;
      web-devicons.enable = true;
      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          change_to_vcs_root = true;
          config = {
            packages.enable = false;
            project.enable = false;
            mru = {
              limit = 8;
              cwd_only = false;
            };
            header = [
              ""
              "      N I X V I M"
              ""
            ];
            shortcut = [
              {
                icon = "F ";
                desc = "Find files";
                group = "Label";
                key = "f";
                action = "FzfLua files";
              }
              {
                icon = "G ";
                desc = "Live grep";
                group = "Label";
                key = "g";
                action = "FzfLua live_grep";
              }
              {
                icon = "R ";
                desc = "Recent files";
                group = "Label";
                key = "r";
                action = "FzfLua oldfiles";
              }
              {
                icon = "N ";
                desc = "New file";
                group = "Label";
                key = "n";
                action = "enew";
              }
              {
                icon = "Q ";
                desc = "Quit";
                group = "Label";
                key = "q";
                action = "qa";
              }
            ];
            footer = [ "Ready." ];
          };
        };
      };
      trouble.enable = true;
      oil = {
        enable = true;
        settings = {
          default_file_explorer = false;
          columns = [ "icon" ];
          view_options.show_hidden = true;
          win_options = {
            wrap = false;
            signcolumn = "yes:2";
            cursorcolumn = false;
            foldcolumn = "0";
            spell = false;
            list = false;
            conceallevel = 3;
            concealcursor = "ncv";
          };
        };
      };
      mini-files = {
        enable = true;
        settings = {
          options = {
            permanent_delete = false;
            use_as_default_explorer = true;
          };
          windows = {
            preview = true;
            width_focus = 35;
            width_preview = 80;
          };
        };
      };
      mini-ai.enable = true;
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
      direnv.enable = true;
      flash.enable = true;
      comment.enable = true;
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };
      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          start_in_insert = true;
          shade_terminals = true;
          float_opts = {
            border = "curved";
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      monokai-pro-nvim
    ];

    extraConfigLua = ''
      require("monokai-pro").setup({
        filter = "pro",
        transparent_background = true,
      })
      vim.cmd.colorscheme("monokai-pro")

      local semantic_groups = {
        ["@lsp.type.class"] = "@type",
        ["@lsp.type.enum"] = "@type",
        ["@lsp.type.interface"] = "@type",
        ["@lsp.type.struct"] = "@type",
        ["@lsp.type.type"] = "@type",
        ["@lsp.type.namespace"] = "@module",
        ["@lsp.type.function"] = "@function",
        ["@lsp.type.method"] = "@function.method",
        ["@lsp.type.parameter"] = "@variable.parameter",
        ["@lsp.type.property"] = "@property",
        ["@lsp.type.variable"] = "@variable",
        ["@lsp.mod.readonly"] = "@constant",
      }

      for group, link in pairs(semantic_groups) do
        vim.api.nvim_set_hl(0, group, { link = link, default = true })
      end
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>Neogit<CR>";
        options.desc = "Git status";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>DiffviewOpen<CR>";
        options.desc = "Git diff";
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>DiffviewClose<CR>";
        options.desc = "Close git diff";
      }
      {
        mode = "n";
        key = "<leader>gh";
        action = "<cmd>DiffviewFileHistory %<CR>";
        options.desc = "File history";
      }
      {
        mode = "n";
        key = "<leader>gH";
        action = "<cmd>DiffviewFileHistory<CR>";
        options.desc = "Repository history";
      }
      {
        mode = "n";
        key = "]h";
        action = "<cmd>Gitsigns next_hunk<CR>";
        options.desc = "Next git hunk";
      }
      {
        mode = "n";
        key = "[h";
        action = "<cmd>Gitsigns prev_hunk<CR>";
        options.desc = "Previous git hunk";
      }
      {
        mode = "n";
        key = "<leader>gp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options.desc = "Preview hunk";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Gitsigns blame_line<CR>";
        options.desc = "Git blame line";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>gs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options.desc = "Stage hunk";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>gr";
        action = "<cmd>Gitsigns reset_hunk<CR>";
        options.desc = "Reset hunk";
      }
    ];
  };
}
