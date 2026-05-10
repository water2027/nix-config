{ ... }:

{
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, Q, exec, kitty"
    "$mainMod, D, exec, copyq toggle"
    "$mainMod, C, killactive"
    "$mainMod, comma, splitratio, -0.05"
    "$mainMod, period, splitratio, +0.05"
    "$mainMod SHIFT, h, layoutmsg, colresize -0.05"
    "$mainMod SHIFT, l, layoutmsg, colresize +0.05"
    "$mainMod, E, exec, $fileManager"
    "$mainMod, V, togglefloating"
    "$mainMod, R, exec, $menu"
    "$mainMod, O, exec, pkill waybar || waybar &"
    "$mainMod, P, exec, pkill linux-wallpaper || linux-wallpaperengine -r 'eDP-1' --scaling fill 2970412969"
    "$mainMod, h, movefocus, l"
    "$mainMod, l, movefocus, r"
    "$mainMod, k, movefocus, u"
    "$mainMod, j, movefocus, d"
    "$mainMod, F, fullscreen, 0"
    "$mainMod, Escape, exec, pkill wlogout || wlogout"
    "$mainMod, 1, workspace, 1"
    "$mainMod, 2, workspace, 2"
    "$mainMod, 3, workspace, 3"
    "$mainMod, 4, workspace, 4"
    "$mainMod, 5, workspace, 5"
    "$mainMod SHIFT, 1, movetoworkspace, 1"
    "$mainMod SHIFT, 2, movetoworkspace, 2"
    "$mainMod SHIFT, 3, movetoworkspace, 3"
    "$mainMod SHIFT, 4, movetoworkspace, 4"
    "$mainMod SHIFT, 5, movetoworkspace, 5"
  ];
  wayland.windowManager.hyprland.settings.bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];
  wayland.windowManager.hyprland.settings.bindel = [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
    ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
  ];
  wayland.windowManager.hyprland.settings.bindl = [
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPause, exec, playerctl play-pause"
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPrev, exec, playerctl previous"
    '', PRINT, exec, sh -c 'FILE=~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png && grim -g "$(slurp -w 0)" $FILE && wl-copy < $FILE' ''
  ];
}
