{ config, pkgs, ... }:

{
  programs.hyprland = {
    # 是否开启 XWayland 以支持旧版应用
    xwayland.enable = true;
  };

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      # 提供 Wayland 下的屏幕捕获/录制（OBS 的 PipeWire 采集依赖它）
      pkgs.xdg-desktop-portal-hyprland
    ];
    config = {
      common.default = "*";
      hyprland.default = [ "hyprland" ];
    };
  };
}
