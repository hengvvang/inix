{ config, lib, pkgs, ... }:

{
  # 实用工具
  home.packages = with pkgs; [
    # 文件管理
    tree          # 目录树显示
    fd            # 快速文件查找
    ripgrep       # 快速文本搜索
    
    # 系统工具
    htop          # 系统监控
    btop          # 现代系统监控
    neofetch      # 系统信息显示
    
    # 压缩工具
    unzip
    zip
    p7zip
    
    # 网络工具
    wget
    curl
    
    # 其他实用工具
    jq            # JSON 处理
    yq            # YAML 处理
    bat           # 更好的 cat
    eza           # 更好的 ls
  ];
}