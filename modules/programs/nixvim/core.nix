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
    enable = true;
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

    plugins.which-key.enable = true;

    keymaps = [
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
