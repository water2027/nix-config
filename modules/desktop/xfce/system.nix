{ ... }:

{
  # 备用桌面：Xorg (X11) 下运行，供 Wayland 不友好的软件使用。
  # 这里只提供 XFCE 会话，不修改默认会话——默认会话由
  # profiles/nixos/personal-system.nix 显式指定为 Hyprland。
  services.xserver.desktopManager.xfce = {
    enable = true;
    enableXfwm = true;
  };
}
