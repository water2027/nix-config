{ lib, pkgs, ... }:
let
  startWallpaper = pkgs.writeShellScriptBin "start-wallpaper" ''
    pattern='(^|/)linux-wallpaperengine( |$).*2970412969'

    if ${pkgs.systemd}/bin/systemctl --user is-active --quiet linux-wallpaperengine.scope; then
      exit 0
    fi

    if ${pkgs.procps}/bin/pgrep -f "$pattern" >/dev/null; then
      exit 0
    fi

    ${pkgs.systemd}/bin/systemctl --user reset-failed linux-wallpaperengine.scope >/dev/null 2>&1 || true

    exec ${pkgs.systemd}/bin/systemd-run \
      --user \
      --scope \
      --collect \
      --unit=linux-wallpaperengine \
      --property=TimeoutStopSec=5s \
      --property=SendSIGKILL=yes \
      ${lib.getExe pkgs.linux-wallpaperengine} -r eDP-1 --scaling fill 2970412969
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    on = {
      _args = [
        "hyprland.start"
        (lib.generators.mkLuaInline ''
          function()
            hl.exec_cmd("hyprctl setcursor Nordzy-cursors 24")
            hl.exec_cmd("copyq --start-server")
            hl.exec_cmd("${lib.getExe startWallpaper}")
            hl.exec_cmd("systemctl --user start pipewire pipewire-pulse wireplumber")
            hl.exec_cmd("systemctl --user start hyprpolkitagent")
          end
        '')
        # hl.exec_cmd("waybar")
        # hl.exec_cmd("blueman-applet")
      ];
    };
  };
}
