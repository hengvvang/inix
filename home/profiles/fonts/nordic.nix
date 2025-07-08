{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "nordic") {
    home.packages = with pkgs; [
      # 主要字体 - 北欧简约风格
      inter                # 现代几何设计，简洁优雅
      source-sans-pro      # Adobe 清晰易读的无衬线字体
      work-sans            # 工作场景优化的简约字体
      
      # 编程字体 - 简洁专业
      source-code-pro      # Adobe 简洁编程字体
      roboto-mono          # Google 简约等宽字体
      
      # 衬线字体 - 优雅传统
      source-serif-pro     # Adobe 现代衬线字体
      crimson              # 优雅的阅读字体
      
      # 中文字体 - 简约现代
      noto-fonts-cjk-sans  # Google 现代中文
      source-han-sans      # Adobe 思源黑体
      source-han-serif     # Adobe 思源宋体
      
      # 系统基础字体
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
      dejavu_fonts
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Work Sans" "Source Han Sans SC" ];
        monospace = [ "Source Code Pro" "Roboto Mono" "Source Han Sans SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
