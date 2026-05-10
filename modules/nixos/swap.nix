{ ... }:

{
  swapDevices = [
    {
      # 指定 swapfile 的路径，通常放在根目录或 /var 下
      device = "/var/lib/swapfile";

      # 指定 swapfile 的大小，单位是 MB。
      # 例如：16GB = 16 * 1024 = 16384 MB
      # 只要指定了 size，NixOS 就会在启动时自动为你创建和格式化这个文件！
      size = 20480;

      # 设置较低的优先级，确保系统优先塞满 zRAM 后，再使用磁盘 Swap
      priority = 0;
    }
  ];
}
