{ pkgs, lib, ... }:
{
  home.packages = lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) (
    with pkgs;
    [
      nixfmt
    ]
  );

  programs.nixvim = {
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
    };

    plugins = {
      which-key.enable = true;
      gitsigns.enable = true;
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
      trouble.enable = true;
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
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
      todo-comments = {
        enable = true;
        keymaps = {
          todoTelescope = {
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
        transparent_background = false,
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
  };
}
