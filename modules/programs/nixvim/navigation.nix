{
  programs.nixvim = {
    plugins.flash.enable = true;

    keymaps = [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "<leader>s";
        action.__raw = ''
          function()
            require("flash").jump()
          end
        '';
        options.desc = "Flash jump";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Window left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Window down";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Window up";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Window right";
      }
      {
        mode = "n";
        key = "<A-h>";
        action = "<cmd>vertical resize -2<CR>";
        options.desc = "Decrease window width";
      }
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>resize -2<CR>";
        options.desc = "Decrease window height";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>resize +2<CR>";
        options.desc = "Increase window height";
      }
      {
        mode = "n";
        key = "<A-l>";
        action = "<cmd>vertical resize +2<CR>";
        options.desc = "Increase window width";
      }
    ];
  };
}
