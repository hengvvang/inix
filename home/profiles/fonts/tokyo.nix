{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "tokyo") {
    home.packages = with pkgs; [
      # 主要字体 - 日式简约现代
      noto-fonts-cjk-sans  # Google 现代中日韩字体
      
      # 编程字体 - 现代简洁
      source-code-pro      # 简洁专业
      jetbrains-mono       # 现代等宽字体
      
      # 西文字体 - 简约现代
      inter                # 现代几何设计
      source-sans-pro      # Adobe 系统字体风格
      
      # 中文字体 - 东亚现代美学
      source-han-sans      # Adobe 思源黑体
      source-han-serif     # Adobe 思源宋体
      noto-fonts-cjk-serif # Google 传统中文
      
      # 系统字体
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Han Serif SC" "Noto Serif CJK SC" ];
        sansSerif = [ "Inter" "Source Han Sans SC" "Source Sans Pro" ];
        monospace = [ "JetBrains Mono" "Source Code Pro" "Source Han Sans SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
