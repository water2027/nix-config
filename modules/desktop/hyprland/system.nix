{ config, pkgs, ... }:

{
  programs.hyprland = {
    # 是否开启 XWayland 以支持旧版应用
    xwayland.enable = true;
  };

  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
