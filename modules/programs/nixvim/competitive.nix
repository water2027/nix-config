{
  programs.nixvim = {
    plugins.leetcode = {
      enable = true;
      settings = {
        cn = {
          enabled = true;
        };
        lang = "cpp";
        picker = {
          provider = "fzf-lua";
        };
        plugins = {
          non_standalone = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>lm";
        action = "<cmd>Leet<CR>";
        options.desc = "LeetCode menu";
      }
      {
        mode = "n";
        key = "<leader>ll";
        action = "<cmd>Leet list<CR>";
        options.desc = "LeetCode list";
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = "<cmd>Leet run<CR>";
        options.desc = "LeetCode run";
      }
      {
        mode = "n";
        key = "<leader>ls";
        action = "<cmd>Leet submit<CR>";
        options.desc = "LeetCode submit";
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>Leet daily<CR>";
        options.desc = "LeetCode daily";
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>Leet random<CR>";
        options.desc = "LeetCode random";
      }
      {
        mode = "n";
        key = "<leader>lL";
        action = "<cmd>Leet lang<CR>";
        options.desc = "LeetCode language";
      }
      {
        mode = "n";
        key = "<leader>lu";
        action = "<cmd>Leet cookie update<CR>";
        options.desc = "LeetCode cookie";
      }
    ];
  };
}
