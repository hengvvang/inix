# 🌒 峨眉月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.toolkits.waxingCrescent.enable {
    home.packages = with pkgs; [
      
      # 现代文件操作基础
      bat               # 更好的 cat (语法高亮)
      eza               # 更好的 ls (彩色、图标)
      fd                # 现代 find (快速文件查找)
      ripgrep           # 现代 grep (rg - 更快搜索)
      
      # 基础文件工具
      tree              # 目录树显示
      fzf               # 模糊查找
      zoxide            # 智能 cd (z - 记录常用目录)
      
      # 基础压缩工具
      unzip             # 解压缩
      zip               # 压缩
      p7zip             # 7zip 支持
      
      # 系统信息
      fastfetch         # 现代系统信息显示
      
      # 基础文本处理
      jq                # JSON 处理
      choose            # 更好的 cut
      
      # 基础安全工具
      openssh           # SSH 客户端
      
    ];
  };
}
