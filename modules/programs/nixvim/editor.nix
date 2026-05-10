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

  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native = {
      enable = true;
      settings = {
        fuzzy = true;
        override_file_sorter = true;
        override_generic_sorter = true;
        case_mode = "smart_case";
      };
    };
  };
}
