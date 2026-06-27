{ pkgs, ... }:

let
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  pgrep = "${pkgs.procps}/bin/pgrep";
in

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

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pgrep} -x hyprlock >/dev/null || ${hyprlock}";
        before_sleep_cmd = "${loginctl} lock-session";
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
      };

      listener = [
        {
          timeout = 600;
          on-timeout = "${loginctl} lock-session";
        }
        {
          timeout = 900;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ];
    };
  };

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
