{ config, ... }:
let
  powerAction = "${config.home.homeDirectory}/.local/bin/power-action.sh";
in
{
  imports = [
    ./style.nix
  ];
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
      action = "systemctl hibernate";
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
      action = "systemctl poweroff";
      text = "关机 (s)";
      keybind = "s";
    }
    {
      label = "suspend";
      action = "systemctl suspend";
      text = "睡眠 (u)";
      keybind = "u";
    }
    {
      label = "reboot";
      action = "systemctl reboot";
      text = "重启 (r)";
      keybind = "r";
    }
  ];
}
