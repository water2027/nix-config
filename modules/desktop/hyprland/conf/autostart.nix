{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor Nordzy-cursors 24"
      "waybar"

      "swaync"
      "copyq --start-server"
      "linux-wallpaperengine -r 'eDP-1' --scaling fill 2970412969"

      # "fcitx5 --replace -d"

      # 系统服务启动
      "systemctl --user start pipewire pipewire-pulse wireplumber"
      "systemctl --user start hyprpolkitagent"
      "blueman-applet"
    ];
  };
}
