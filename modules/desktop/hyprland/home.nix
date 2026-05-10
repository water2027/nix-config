{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fuzzel
    swaynotificationcenter
    copyq
    grim
    slurp
    wl-clipboard
    linux-wallpaperengine
  ];
  imports = [
    ./conf/declare.nix
    ./conf/autostart.nix
    ./conf/animations.nix
    ./conf/environment.nix
    ./conf/input.nix
    ./conf/monitor.nix
    ./conf/workspace.nix
    ./conf/window.nix
    ./conf/windowrule.nix
    ./conf/workspace.nix
    ./conf/keybinding.nix
    ./conf/layout.nix
    ./conf/misc.nix

    ../common/waybar/home.nix
    ../common/wlogout/home.nix
    ../common/fcitx/home.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland = {
    systemd.enable = true;
    settings = {
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "GDK_BACKEND,wayland,x11,*"
      ];
    };
  };
}
