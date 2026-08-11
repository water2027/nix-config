{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;

    # Vulkan/OpenGL 游戏捕获（独占全屏游戏无法用 PipeWire 截屏时使用）。
    # 用法：Steam 启动选项填 `obs-vkcapture %command%`。
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
    ];
  };
}
