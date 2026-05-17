{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fuzzel
    swaynotificationcenter
    copyq
    brightnessctl
    grim
    pavucontrol
    playerctl
    slurp
    wl-clipboard
    linux-wallpaperengine
  ];
  imports = [
    ./conf/autostart.nix
    ./conf/animations.nix
    ./conf/environment.nix
    ./conf/input.nix
    ./conf/monitor.nix
    ./conf/workspace.nix
    ./conf/window.nix
    ./conf/windowrule.nix
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
    configType = "lua";
    settings = {
      env = [
        {
          _args = [
            "XDG_CURRENT_DESKTOP"
            "Hyprland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_TYPE"
            "wayland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_DESKTOP"
            "Hyprland"
          ];
        }
        {
          _args = [
            "QT_QPA_PLATFORM"
            "wayland;xcb"
          ];
        }
        {
          _args = [
            "GDK_BACKEND"
            "wayland,x11,*"
          ];
        }
      ];
    };
  };
}
