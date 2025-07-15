# 🌔 盈凸月 - 完整开发环境
# 提供完整的编程和开发工具链
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.waxingGibbous.enable {
    environment.systemPackages = with pkgs; [
      # 高级编辑器
      helix             # 现代文本编辑器
      
      # 版本控制增强
      gh                # GitHub CLI
      
      # 开发语言和运行时
      nodejs            # Node.js 运行时
      python3           # Python 解释器
      rustc             # Rust 编译器
      cargo             # Rust 包管理器
      
      # 构建工具
      cmake             # 构建系统
      gnumake           # Make 构建工具
      
      # 调试和分析工具
      gdb               # GNU 调试器
      strace            # 系统调用跟踪
      valgrind          # 内存分析工具
      hyperfine         # 基准测试工具
      
      # 容器工具
      docker            # 容器平台
      docker-compose    # 容器编排
      
      # 系统监控
      htop              # 进程监控
      btop              # 现代系统监控
      bottom            # 系统资源监控
      procs             # 现代 ps (进程信息)
      pstree            # 进程树
      iotop             # IO 监控
      nethogs           # 网络监控
      
      # 高级文件工具
      rclone            # 云存储同步
      nnn               # 快速文件导航
      dust              # 现代 du (磁盘使用)
      duf               # 现代 df (磁盘信息)
      ncdu              # 磁盘使用分析
      
      # 开发辅助
      direnv            # 目录环境变量
      watchexec         # 文件监控执行
      tokei             # 代码统计
      
      # 高级网络工具
      xh                # 更快的 HTTP 客户端
      dog               # 现代 dig (DNS 查询)
      nmap              # 网络扫描
      tcpdump           # 网络包分析
      iperf3            # 网络性能测试
      bandwhich         # 网络带宽监控
      
      # 数据处理
      visidata          # 表格数据查看器
      
      # 加密工具
      age               # 现代文件加密
      
      # 硬件信息
      lshw              # 硬件信息
      usbutils          # USB 工具
      pciutils          # PCI 工具
      
      # 系统工具
      killall           # 批量结束进程
      zstd              # 高效压缩
    ];
  };
}
