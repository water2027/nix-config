{ config, pkgs, ... }:
let
  powerAction = "${config.home.homeDirectory}/.local/bin/power-action.sh";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  hyprlock = "${pkgs.hyprlock}/bin/hyprlock";
  pgrep = "${pkgs.procps}/bin/pgrep";
  pkill = "${pkgs.procps}/bin/pkill";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in
{
  imports = [
    ./style.nix
  ];

  home.file.".local/bin/power-action.sh" = {
    executable = true;
    text = ''
      #!${pkgs.bash}/bin/bash
      set -euo pipefail

      close_menu() {
        ${pkill} -x wlogout >/dev/null 2>&1 || true
      }

      case "''${1:-}" in
        lock)
          close_menu
          if ${pgrep} -x hyprlock >/dev/null; then
            exit 0
          fi
          exec ${hyprlock}
          ;;
        logout)
          close_menu
          exec ${hyprctl} dispatch exit
          ;;
        shutdown)
          close_menu
          exec ${systemctl} poweroff
          ;;
        reboot)
          close_menu
          exec ${systemctl} reboot
          ;;
        suspend)
          close_menu
          exec ${systemctl} suspend
          ;;
        hibernate)
          close_menu
          exec ${systemctl} hibernate
          ;;
        *)
          echo "Usage: $0 {lock|logout|shutdown|reboot|suspend|hibernate}" >&2
          exit 64
          ;;
      esac
    '';
  };

  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      hide_cursor = true
    }

    background {
      monitor =
      color = rgba(12, 12, 12, 0.95)
    }

    input-field {
      monitor =
      size = 280, 54
      outline_thickness = 2
      dots_size = 0.22
      dots_spacing = 0.35
      dots_center = true
      outer_color = rgb(7aa2f7)
      inner_color = rgb(1a1b26)
      font_color = rgb(c0caf5)
      fade_on_empty = false
      placeholder_text = Password
      hide_input = false
      position = 0, -30
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] date +"%H:%M"
      color = rgb(c0caf5)
      font_size = 64
      position = 0, 80
      halign = center
      valign = center
    }
  '';

  programs.wlogout.enable = true;
  programs.wlogout.layout = [
    {
      label = "lock";
      action = "${powerAction} lock";
      text = "锁定 (l)";
      keybind = "l";
    }
    {
      label = "hibernate";
      action = "${powerAction} hibernate";
      text = "休眠 (h)";
      keybind = "h";
    }
    {
      label = "logout";
      action = "${powerAction} logout";
      text = "登出 (e)";
      keybind = "e";
    }
    {
      label = "shutdown";
      action = "${powerAction} shutdown";
      text = "关机 (s)";
      keybind = "s";
    }
    {
      label = "suspend";
      action = "${powerAction} suspend";
      text = "睡眠 (u)";
      keybind = "u";
    }
    {
      label = "reboot";
      action = "${powerAction} reboot";
      text = "重启 (r)";
      keybind = "r";
    }
  ];
}
