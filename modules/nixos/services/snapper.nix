{ username, ... }:

{
  systemd.tmpfiles.rules = [
    # 如果路径不存在，就自动创建一个 Btrfs 子卷 (Subvolume)
    "v /home/${username}/.local/share/Steam 0755 ${username} users -"

    # 关闭 CoW (No Copy-on-Write)
    "h /home/${username}/.local/share/Steam - - - - +C"
  ];
  services.snapper = {
    snapshotInterval = "hourly"; # 每小时触发一次快照检查
    cleanupInterval = "1d"; # 每天触发一次清理检查
    configs = {
      home = {
        SUBVOLUME = "/home"; # 指定要保护的子卷挂载点
        ALLOW_USERS = [ username ]; # 允许你的普通用户直接管理快照，不用每次都 sudo
        TIMELINE_CREATE = true; # 开启定时快照
        TIMELINE_CLEANUP = true; # 开启自动清理

        TIMELINE_LIMIT_HOURLY = "5"; # 保留最近 5 个小时的快照
        TIMELINE_LIMIT_DAILY = "7"; # 保留最近 7 天的快照
        TIMELINE_LIMIT_WEEKLY = "2"; # 保留最近 2 周的快照
        TIMELINE_LIMIT_MONTHLY = "0"; # 不保留月度快照
        TIMELINE_LIMIT_YEARLY = "0"; # 不保留年度快照
      };
    };
  };
}
