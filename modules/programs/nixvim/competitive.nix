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
  };
}
