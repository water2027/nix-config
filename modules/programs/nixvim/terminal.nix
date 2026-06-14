{
  programs.nixvim = {
    plugins.toggleterm = {
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

    keymaps = [
      {
        mode = "t";
        key = "<Esc>";
        action = "<C-\\><C-n>";
        options.desc = "Exit terminal mode";
      }
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>ToggleTerm direction=float<CR>";
        options.desc = "Toggle terminal";
      }
      {
        mode = "n";
        key = "<C-t>";
        action = "<cmd>ToggleTerm direction=float<CR>";
        options.desc = "Toggle terminal";
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>ToggleTerm direction=horizontal<CR>";
        options.desc = "Horizontal terminal";
      }
      {
        mode = "n";
        key = "<leader>tv";
        action = "<cmd>ToggleTerm direction=vertical<CR>";
        options.desc = "Vertical terminal";
      }
      {
        mode = "t";
        key = "<C-t>";
        action = "<C-\\><C-n><cmd>ToggleTerm<CR>";
        options.desc = "Toggle terminal";
      }
    ];
  };
}
