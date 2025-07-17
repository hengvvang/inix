# 🌔 盈凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.waxingGibbous.enable {
    home.packages = with pkgs; [
      
      # 高级压缩工具
      zstd              # 高效压缩
      
      # 文件同步和传输
      rsync             # 文件同步
      rclone            # 云存储同步
      
      # 高级文件管理
      yazi              # 现代文件管理器
      
      # 硬件信息
      neofetch          # 经典系统信息显示
      lshw              # 硬件信息
      usbutils          # USB 工具
      pciutils          # PCI 工具
      
      # 高级网络工具
      httpie            # 现代 curl
      xh                # 更快的 HTTP 客户端
      dog               # 现代 dig (DNS 查询)
      nmap              # 网络扫描
      iperf3            # 网络性能测试
      bandwhich         # 网络带宽监控
      
      # 高级监控工具
      bottom            # 另一个系统监控
      pstree            # 进程树
      iotop             # IO 监控
      nethogs           # 网络监控
      killall           # 批量结束进程
      
      # 高级安全工具
      age               # 现代文件加密
      gnupg             # GPG 加密
      
      # 图像处理
      imagemagick       # 图像处理套件
      
    ];
  };
}
