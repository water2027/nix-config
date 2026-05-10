{ pkgs, ... }:

{
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
  ];

  services.gvfs.enable = true; # 提供回收站、挂载、网络共享等功能
  services.tumbler.enable = true; # 提供图片、视频等文件的缩略图支持

  environment.systemPackages = with pkgs; [
    file-roller # GNOME 的解压工具，与 Thunar 配合良好
  ];
}
