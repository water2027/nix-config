{ config, pkgs, ... }:

{
	programs.hyprland = {
    enable = true;
    # 是否开启 XWayland 以支持旧版应用
    xwayland.enable = true;
  };

	services.dbus.enable = true;
	xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}