# 🌓 上弦月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.firstQuarter.enable {
    home.packages = with pkgs; [
      
      # 高级文件工具
      dust              # 现代 du (磁盘使用)
      duf               # 现代 df (磁盘信息)
      lsd               # 另一个现代 ls
      hexyl             # 十六进制查看器
      ncdu              # 磁盘使用分析
      
      # 高级文本处理
      sd                # 现代 sed
      yq                # YAML 处理
      visidata          # 表格数据查看器
      delta             # 更好的 git diff
      tealdeer          # 快速 man 页面 (tldr)
      
      # 开发工具
      hyperfine         # 基准测试工具
      tokei             # 代码统计
      watchexec         # 文件监控执行
      
      # Git 工具
      lazygit           # Git GUI
      gitui             # 另一个 Git TUI
      
      # 进程监控
      htop              # 进程监控
      btop              # 现代系统监控
      procs             # 现代 ps (进程信息)
      
      # 网络基础工具
      wget              # 文件下载
      curl              # HTTP 客户端
      gping             # 现代 ping
      
    ];
  };
}
