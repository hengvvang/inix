# 🌒 峨眉月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.waxingCrescent.enable {
    home.packages = with pkgs; [
      
      wget              # 文件下载
      curl              # HTTP 客户端
      httpie            # 现代 curl


      bat               # 更好的 cat (语法高亮)
      eza               # 更好的 ls (彩色、图标)
      fd                # 现代 find (快速文件查找)
      lsd               # 另一个现代 ls
      ripgrep           # 现代 grep (rg - 更快搜索)
      tree              # 目录树显示
      fzf               # 模糊查找
      zoxide            # 智能 cd (z - 记录常用目录)
      tealdeer          # 快速 man 页面 (tldr)
      dog               # 现代 dig (DNS 查询)
      
      # 进程监控
      gping             # 现代 ping
      htop              # 进程监控
      btop              # 现代系统监控
      procs             # 现代 ps (进程信息)
      dust              # 现代 du (磁盘使用)
      duf               # 现代 df (磁盘信息)
      hexyl             # 十六进制查看器
      ncdu              # 磁盘使用分析
      hyperfine         # 基准测试工具
      tokei             # 代码统计
      watchexec         # 文件监控执行
      fastfetch
      lshw              # 硬件信息
      choose            # 更好的 cut

      # 高级压缩工具
      zstd              # 高效压缩
      
      
      # 文件同步和传输
      rsync             # 文件同步
      rclone            # 云存储同步
      
      # 硬件信息
      usbutils          # USB 工具
      pciutils          # PCI 工具
      
      # 高级网络工具
      xh                # 更快的 HTTP 客户端
      nmap              # 网络扫描
      iperf3            # 网络性能测试
      bandwhich         # 网络带宽监控
      
      # 高级监控工具
      bottom            # 另一个系统监控
      pstree            # 进程树
      iotop             # IO 监控
      nethogs           # 网络监控
      killall           # 批量结束进程
      
      # 图像处理
      imagemagick       # 图像处理套件
      
      
      
      unzip             # 解压缩
      zip               # 压缩
      p7zip             # 7zip 支持
      
      
      # 基础文本处理
      jq                # JSON 处理
      
      # 基础安全工具
      openssh           # SSH 客户端

      # 高级网络分析
      tcpdump           # 网络包分析
      # wireshark         # 网络包分析 GUI (可能需要额外配置)
      
      # 系统调试工具
      strace            # 系统调用跟踪
      ltrace            # 库函数调用跟踪
      
      # 性能分析
      # perf-tools        # 性能分析工具 (可能不存在该包名)
      
      # 高级文件工具
      rmlint            # 重复文件清理
      fdupes            # 重复文件查找
      
      
      # 虚拟化工具
      qemu              # 虚拟化
      
      # 多媒体工具
      ffmpeg            # 音视频处理
      
      # 文档工具
      pandoc            # 文档转换
      
      # 科学计算
      bc                # 计算器
      units             # 单位转换
      
      
      # 高级文本处理
      sd                # 现代 sed
      yq                # YAML 处理
      delta             # 更好的 git diff
      
    ];
  };
}
