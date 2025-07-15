# 🌒 峨眉月 - 基础终端增强
# 提供基本的终端体验改善，让命令行使用更加舒适
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.toolkits.waxingCrescent.enable {
    environment.systemPackages = with pkgs; [
      # 改进的 Shell
      fish              # 友好的交互式 shell
      zsh               # 高度可定制的 shell
      
      # 基础终端模拟器
      alacritty         # 高性能终端
      
      # 基础命令行工具增强
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
      neofetch          # 系统信息显示
    ];
  };
}
