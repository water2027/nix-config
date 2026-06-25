{ ... }:

{
  zramSwap = {
    # 允许 zRAM 使用的最大物理内存百分比，默认是 50
    memoryPercent = 50;
    # 使用 zstd 压缩算法（压缩率和速度的绝佳平衡）
    algorithm = "zstd";
    # zRAM 的默认优先级是 5。数值越高，系统越优先使用。
  };
}
