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

  programs.nixvim.plugins.grug-far = {
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

  programs.nixvim.plugins.fzf-lua = {
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
}
