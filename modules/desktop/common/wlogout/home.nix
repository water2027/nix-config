{ pkgs, ... }:
let
  powerAction = "/home/water/.local/bin/power-action.sh";
in
{
	imports = [
		./style.nix
	];
	programs.wlogout.enable = true;
  programs.wlogout.layout = [
		{
      label = "lock";
      action = "/home/water/.local/bin/power-action.sh lock";
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
      action = "/home/water/.local/bin/power-action.sh logout";
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