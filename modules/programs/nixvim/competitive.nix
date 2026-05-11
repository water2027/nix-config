{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      leetcode-nvim
    ];

    extraConfigLua = ''
      require("leetcode").setup({
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
