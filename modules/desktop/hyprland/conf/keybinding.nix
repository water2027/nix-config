{ lib, pkgs, ... }:

let
  lua = lib.generators.mkLuaInline;
  mainMod = "SUPER";
  bind = keys: action: {
    _args = [
      keys
      (lua action)
    ];
  };
  bindWith = keys: action: options: {
    _args = [
      keys
      (lua action)
      options
    ];
  };
  toLua = lib.generators.toLua { };
  exec = command: "hl.dsp.exec_cmd(${toLua command})";
  pgrep = "${pkgs.procps}/bin/pgrep";
  pkill = "${pkgs.procps}/bin/pkill";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  systemdRun = "${pkgs.systemd}/bin/systemd-run";
  wlogout = lib.getExe pkgs.wlogout;
  waybar = lib.getExe pkgs.waybar;
  waybarPattern = lib.escapeShellArg "(^|/)(waybar|\\.waybar-wrapped)( |$)";
  linuxWallpaperEngine = lib.getExe pkgs.linux-wallpaperengine;
  togglePowerMenu = pkgs.writeShellScriptBin "toggle-power-menu" ''
    if ${pgrep} -x wlogout >/dev/null; then
      ${pkill} -x wlogout
      exit 0
    fi

    exec ${wlogout}
  '';
  toggleWaybar = pkgs.writeShellScriptBin "toggle-waybar" ''
    if ${pgrep} -f ${waybarPattern} >/dev/null; then
      ${pkill} -TERM -f ${waybarPattern}
    else
      exec ${waybar}
    fi
  '';
  toggleWallpaper = pkgs.writeShellScriptBin "toggle-wallpaper" ''
    pattern='(^|/)linux-wallpaperengine( |$).*3248298131'

    if ${systemctl} --user is-active --quiet linux-wallpaperengine.scope; then
      exec ${systemctl} --user stop linux-wallpaperengine.scope
    elif ${pgrep} -f "$pattern" >/dev/null; then
      exec ${pkill} -TERM -f "$pattern"
    else
      ${systemctl} --user reset-failed linux-wallpaperengine.scope >/dev/null 2>&1 || true

      exec ${systemdRun} \
        --user \
        --scope \
        --collect \
        --unit=linux-wallpaperengine \
        --property=TimeoutStopSec=5s \
        --property=SendSIGKILL=yes \
        ${linuxWallpaperEngine} -r eDP-1 --scaling fill 3248298131
    fi
  '';
  workspace = number: bind "${mainMod} + ${number}" ''hl.dsp.focus({ workspace = "${number}" })'';
  moveToWorkspace =
    number:
    bind "${mainMod} + SHIFT + ${number}" ''hl.dsp.window.move({ workspace = "${number}", follow = false })'';
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      (bind "${mainMod} + Q" (exec "kitty"))
      (bind "${mainMod} + D" (exec "copyq toggle"))
      (bind "${mainMod} + C" "hl.dsp.window.close()")
      (bind "${mainMod} + E" (exec "thunar"))
      (bind "${mainMod} + R" (exec "fuzzel"))
      (bind "${mainMod} + O" (exec (lib.getExe toggleWaybar)))
      (bind "${mainMod} + P" (exec (lib.getExe toggleWallpaper)))
      (bind "${mainMod} + Escape" (exec (lib.getExe togglePowerMenu)))

      (bind "${mainMod} + SHIFT + h" ''hl.dsp.layout("colresize -0.05")'')
      (bind "${mainMod} + SHIFT + l" ''hl.dsp.layout("colresize +0.05")'')
      (bind "${mainMod} + V" ''hl.dsp.window.float({ action = "toggle" })'')

      (bind "${mainMod} + h" ''hl.dsp.focus({ direction = "l" })'')
      (bind "${mainMod} + l" ''hl.dsp.focus({ direction = "r" })'')
      (bind "${mainMod} + k" ''hl.dsp.focus({ direction = "u" })'')
      (bind "${mainMod} + j" ''hl.dsp.focus({ direction = "d" })'')
      (bind "${mainMod} + F" ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
    ]
    ++ map workspace [
      "1"
      "2"
      "3"
      "4"
      "5"
    ]
    ++ map moveToWorkspace [
      "1"
      "2"
      "3"
      "4"
      "5"
    ]
    ++ [
      (bindWith "${mainMod} + mouse:272" "hl.dsp.window.drag()" { mouse = true; })
      (bindWith "${mainMod} + mouse:273" "hl.dsp.window.resize()" { mouse = true; })
    ]
    ++ [
      (bindWith "XF86AudioRaiseVolume" (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") {
        locked = true;
        repeating = true;
      })
      (bindWith "XF86AudioLowerVolume" (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") {
        locked = true;
        repeating = true;
      })
      (bindWith "XF86AudioMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
        locked = true;
        repeating = true;
      })
      (bindWith "XF86AudioMicMute" (exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") {
        locked = true;
        repeating = true;
      })
      (bindWith "XF86MonBrightnessUp" (exec "brightnessctl set 5%+") {
        locked = true;
        repeating = true;
      })
      (bindWith "XF86MonBrightnessDown" (exec "brightnessctl set 5%-") {
        locked = true;
        repeating = true;
      })
    ]
    ++ [
      (bindWith "XF86AudioNext" (exec "playerctl next") { locked = true; })
      (bindWith "XF86AudioPause" (exec "playerctl play-pause") { locked = true; })
      (bindWith "XF86AudioPlay" (exec "playerctl play-pause") { locked = true; })
      (bindWith "XF86AudioPrev" (exec "playerctl previous") { locked = true; })
      (bindWith "PRINT"
        (exec ''sh -c 'FILE=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png && grim -g "$(slurp -w 0)" $FILE && wl-copy < $FILE' '')
        { locked = true; }
      )
    ];
  };
}
