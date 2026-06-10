{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };
    };
  };

  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
      };
    };
  };

  programs.nixvim.plugins.fzf-lua = {
    enable = true;
    profile = "telescope";
    settings = {
      keymap.fzf = {
        tab = "down";
        btab = "up";
      };
      files = {
        hidden = true;
        git_icons = true;
        file_icons = true;
        color_icons = true;
      };
      grep = {
        rg_glob = true;
      };
    };
  };
}
