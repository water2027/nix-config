{
  programs.nixvim = {
    plugins = {
      grug-far = {
        enable = true;
        settings = {
          debounceMs = 300;
          minSearchChars = 2;
          normalModeSearch = false;
          engine = "ripgrep";
          engines.ripgrep = {
            path = "rg";
            showReplaceDiff = true;
            placeholders = {
              enabled = true;
              search = "ex: foo   foo([a-z0-9]*)";
              replacement = "ex: bar   \${1}_foo";
              filesFilter = "ex: *.nix   *.{lua;js;ts}   !result/**";
              flags = "ex: --fixed-strings --ignore-case --case-sensitive --word-regexp";
              paths = "ex: ./modules   ~/.config";
            };
          };
        };
      };

      fzf-lua = {
        enable = true;
        profile = "telescope";
        settings = {
          ui_select = true;
          winopts = {
            height = 0.85;
            width = 0.9;
            row = 0.35;
            col = 0.5;
            border = "rounded";
            preview = {
              layout = "flex";
              horizontal = "right:55%";
              vertical = "down:45%";
              hidden = false;
              wrap = false;
            };
          };
          fzf_opts = {
            "--layout" = "reverse";
            "--info" = "inline-right";
            "--cycle" = true;
          };
          defaults = {
            file_icons = true;
            git_icons = true;
            color_icons = true;
            formatter = "path.filename_first";
          };
          keymap.fzf = {
            tab = "down";
            btab = "up";
          };
          files = {
            hidden = true;
            follow = false;
            no_ignore = false;
            multiprocess = true;
            git_icons = true;
            file_icons = true;
            color_icons = true;
          };
          grep = {
            rg_glob = true;
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e";
          };
          oldfiles = {
            include_current_session = true;
            cwd_only = false;
          };
          buffers = {
            sort_lastused = true;
            ignore_current_buffer = true;
          };
          lsp = {
            jump1 = false;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-p>";
        action = "<cmd>FzfLua files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>FzfLua live_grep<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>FzfLua buffers<CR>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>FzfLua oldfiles<CR>";
        options.desc = "Recent files";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>FzfLua helptags<CR>";
        options.desc = "Help tags";
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>FzfLua diagnostics_workspace<CR>";
        options.desc = "Diagnostics";
      }
      {
        mode = "n";
        key = "<leader>fs";
        action = "<cmd>FzfLua lsp_document_symbols<CR>";
        options.desc = "Document symbols";
      }
      {
        mode = "n";
        key = "<leader>fS";
        action = "<cmd>FzfLua lsp_workspace_symbols<CR>";
        options.desc = "Workspace symbols";
      }
      {
        mode = "n";
        key = "<leader>fl";
        action = "<cmd>FzfLua lsp_finder<CR>";
        options.desc = "LSP finder";
      }
      {
        mode = "n";
        key = "<leader>fq";
        action = "<cmd>FzfLua quickfix<CR>";
        options.desc = "Quickfix";
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>FzfLua keymaps<CR>";
        options.desc = "Keymaps";
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>FzfLua commands<CR>";
        options.desc = "Commands";
      }
      {
        mode = "n";
        key = "<C-f>";
        action = "<cmd>FzfLua blines<CR>";
        options.desc = "Buffer lines";
      }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>GrugFar<CR>";
        options.desc = "Search and replace";
      }
      {
        mode = "x";
        key = "<leader>sr";
        action.__raw = ''
          function()
            require("grug-far").with_visual_selection()
          end
        '';
        options.desc = "Search selection";
      }
      {
        mode = "n";
        key = "<leader>sw";
        action.__raw = ''
          function()
            require("grug-far").open({
              prefills = {
                search = vim.fn.expand("<cword>"),
                flags = "--fixed-strings --word-regexp",
              },
            })
          end
        '';
        options.desc = "Search word";
      }
      {
        mode = "n";
        key = "<leader>sR";
        action.__raw = ''
          function()
            require("grug-far").open({
              prefills = {
                paths = vim.fn.expand("%"),
              },
            })
          end
        '';
        options.desc = "Search file";
      }
    ];
  };
}
