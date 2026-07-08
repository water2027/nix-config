{ pkgs, ... }:
{
  programs.nixvim = {
    globals = {
      diffs = {
        integrations = {
          neogit = true;
          gitsigns = true;
        };
      };
    };

    plugins = {
      gitsigns.enable = true;
      neogit.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      diffs-nvim
    ];

    keymaps = [
      {
        mode = "n";
        key = "<C-g>";
        action = "<cmd>Neogit<CR>";
        options.desc = "Git status";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<Plug>(diffs-gdiff)";
        options.desc = "Current file diff";
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<Plug>(diffs-gvdiff)";
        options.desc = "Current file diff vertical";
      }
      {
        mode = "n";
        key = "<leader>gh";
        action = "<cmd>NeogitLogCurrent<CR>";
        options.desc = "File history";
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
