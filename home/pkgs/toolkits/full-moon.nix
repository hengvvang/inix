# 🌕 满月 - 完整工具生态

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.fullMoon.enable {
    home.packages = with pkgs; [
      
      # 高级网络分析
      tcpdump           # 网络包分析
      # wireshark         # 网络包分析 GUI (可能需要额外配置)
      
      # 系统调试工具
      strace            # 系统调用跟踪
      ltrace            # 库函数调用跟踪
      gdb               # 调试器
      
      # 性能分析
      # perf-tools        # 性能分析工具 (可能不存在该包名)
      
      # 高级文件工具
      rmlint            # 重复文件清理
      fdupes            # 重复文件查找
      
      # 备份工具
      borgbackup        # 现代备份工具
      
      # 虚拟化工具
      qemu              # 虚拟化
      
      # 多媒体工具
      ffmpeg            # 音视频处理
      
      # 文档工具
      pandoc            # 文档转换
      
      # 科学计算
      bc                # 计算器
      units             # 单位转换
      
    ];
  };
}
