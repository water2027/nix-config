{ pkgs, ... }:

{
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
  ];

  environment.systemPackages = with pkgs; [
    file-roller # GNOME 的解压工具，与 Thunar 配合良好
  ];
}
