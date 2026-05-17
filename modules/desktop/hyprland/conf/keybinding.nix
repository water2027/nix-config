{ lib, ... }:

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
      (bind "${mainMod} + O" (exec "pgrep -x waybar >/dev/null && pkill -x waybar || waybar"))
      (bind "${mainMod} + P" (
        exec "pgrep -f 'linux-wallpaperengine.*2970412969' >/dev/null && pkill -f 'linux-wallpaperengine.*2970412969' || linux-wallpaperengine -r 'eDP-1' --scaling fill 2970412969"
      ))
      (bind "${mainMod} + Escape" (exec "pgrep -x wlogout >/dev/null && pkill -x wlogout || wlogout"))

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
