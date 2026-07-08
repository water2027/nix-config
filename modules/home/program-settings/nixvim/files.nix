let
  copyPathAction =
    {
      absolute ? false,
      withLine ? false,
      label,
    }:
    ''
      function()
        local absolute_path = vim.fn.expand("%:p")
        if absolute_path == "" then
          vim.notify("No file path to copy", vim.log.levels.WARN)
          return
        end

        local path = absolute_path
        if not ${if absolute then "true" else "false"} then
          path = vim.fs.relpath(vim.fn.getcwd(), absolute_path) or vim.fn.fnamemodify(absolute_path, ":.")
        end

        if ${if withLine then "true" else "false"} then
          path = path .. ":" .. vim.api.nvim_win_get_cursor(0)[1]
        end

        vim.fn.setreg("+", path)
        vim.notify("Copied ${label}: " .. path)
      end
    '';
in
{
  programs.nixvim = {
    plugins = {
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
        action.__raw = copyPathAction {
          label = "relative path";
        };
        options.desc = "Copy relative path";
      }
      {
        mode = "n";
        key = "<leader>yP";
        action.__raw = copyPathAction {
          absolute = true;
          label = "absolute path";
        };
        options.desc = "Copy absolute path";
      }
      {
        mode = "n";
        key = "<leader>yl";
        action.__raw = copyPathAction {
          withLine = true;
          label = "relative path with line";
        };
        options.desc = "Copy relative path with line";
      }
      {
        mode = "n";
        key = "<leader>yL";
        action.__raw = copyPathAction {
          absolute = true;
          withLine = true;
          label = "absolute path with line";
        };
        options.desc = "Copy absolute path with line";
      }
    ];
  };
}
