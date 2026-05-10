{ username, ... }:

{
  # 启用 libvirtd 守护进程
  virtualisation.libvirtd.enable = true;

  # 安装并启用 virt-manager 图形界面
  programs.virt-manager.enable = true;

  # 请将 "your_username" 替换为你实际的用户名
  users.users."${username}".extraGroups = [ "libvirtd" ];
}
