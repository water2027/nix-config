{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function()
            hl.exec_cmd("hyprctl setcursor Nordzy-cursors 24")
            hl.exec_cmd("waybar")
            hl.exec_cmd("swaync")
            hl.exec_cmd("copyq --start-server")
            hl.exec_cmd("linux-wallpaperengine -r 'eDP-1' --scaling fill 2970412969")
            hl.exec_cmd("systemctl --user start pipewire pipewire-pulse wireplumber")
            hl.exec_cmd("systemctl --user start hyprpolkitagent")
            hl.exec_cmd("blueman-applet")
          end
        '')
      ];
    };
  };
}
