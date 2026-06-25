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

    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

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
      foldmethod = "manual";
      foldlevel = 99;
      foldlevelstart = 99;
      foldnestmax = 10;
      foldcolumn = "1";
    };

    plugins.which-key = {
      enable = true;
      settings.spec = [
        {
          __unkeyed-1 = "<leader>a";
          group = "AI";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
        }
        {
          __unkeyed-1 = "<leader>d";
          group = "Debug";
        }
        {
          __unkeyed-1 = "<leader>f";
          group = "Find";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
        }
        {
          __unkeyed-1 = "<leader>l";
          group = "LeetCode";
        }
        {
          __unkeyed-1 = "<leader>R";
          group = "Requests";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Search";
        }
        {
          __unkeyed-1 = "<leader>t";
          group = "Tab";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "Problems";
        }
        {
          __unkeyed-1 = "<leader>y";
          group = "Yank";
        }
      ];
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>tabnew<CR>";
        options.desc = "New tab";
      }
      {
        mode = "n";
        key = "<leader>tc";
        action = "<cmd>tabclose<CR>";
        options.desc = "Close tab";
      }
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>tabonly<CR>";
        options.desc = "Only tab";
      }
      {
        mode = "n";
        key = "<leader>tr";
        action.__raw = ''
          function()
            vim.ui.input({ prompt = "Tab name: " }, function(name)
              if name == nil then
                return
              end

              if name == "" then
                vim.cmd("LualineRenameTab")
              else
                vim.cmd("LualineRenameTab " .. vim.fn.fnameescape(name))
              end
            end)
          end
        '';
        options.desc = "Rename tab";
      }
      {
        mode = "n";
        key = "zR";
        action.__raw = ''
          function()
            require("ufo").openAllFolds()
          end
        '';
        options.desc = "Open all folds";
      }
      {
        mode = "n";
        key = "zM";
        action.__raw = ''
          function()
            require("ufo").closeAllFolds()
          end
        '';
        options.desc = "Close all folds";
      }
      {
        mode = "n";
        key = "zr";
        action.__raw = ''
          function()
            require("ufo").openFoldsExceptKinds()
          end
        '';
        options.desc = "Open folds except selected kinds";
      }
      {
        mode = "n";
        key = "zm";
        action.__raw = ''
          function()
            require("ufo").closeFoldsWith()
          end
        '';
        options.desc = "Close folds by level";
      }
    ];
  };
}
