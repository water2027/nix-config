{
  wayland.windowManager.hyprland.settings = {
    # 窗口规则配置
    windowrule = [
      # 忽略来自应用的 maximize 请求
      "match:class .*, suppress_event maximize"

      # 修复 XWayland 的一些拖动问题
      "match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, no_focus 1"
    ];
  };
}