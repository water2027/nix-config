{
  programs.nixvim = {
    plugins = {
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
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-e>";
        action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>";
        options.desc = "Open file explorer";
      }
      {
        mode = "n";
        key = "<leader>yp";
        action.__raw = ''
          function()
            local path = vim.fn.expand("%:p")
            if path == "" then
              vim.notify("No file path to copy", vim.log.levels.WARN)
              return
            end

            vim.fn.setreg("+", path)
            vim.notify("Copied file path: " .. path)
          end
        '';
        options.desc = "Copy file path";
      }
    ];
  };
}
