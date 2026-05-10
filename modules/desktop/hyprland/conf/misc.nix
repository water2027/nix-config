{
  wayland.windowManager.hyprland.settings = {
    misc = {
      force_default_wallpaper = 0; # 关闭默认壁纸/看板娘
      disable_hyprland_logo = false; # 是否禁用标志
      mouse_move_enables_dpms = true; # 鼠标移动唤醒屏幕
      key_press_enables_dpms = true; # 按键唤醒屏幕
      vrr = 1; # 可变刷新率 (0-off, 1-on, 2-fullscreen only)
      enable_swallow = true; # 开启窗口吞吐 (Swallow)
      swallow_regex = "^(kitty)$"; # 匹配吞吐的窗口类名
    };
  };
}