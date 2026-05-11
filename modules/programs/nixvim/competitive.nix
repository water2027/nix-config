{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      leetcode-nvim
    ];

    extraConfigLua = ''
      require("leetcode").setup({
        cn = {
          enabled = true,
        },
        lang = "cpp",
        picker = {
          provider = "telescope",
        },
        plugins = {
          non_standalone = true,
        },
      })
    '';

  };
}
