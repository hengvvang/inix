{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "bauhaus") {
    home.packages = with pkgs; [
      # 主要字体 - 包豪斯几何风格
      source-sans-pro      # Adobe 现代几何设计
      inter                # 现代几何无衬线字体
      
      # 编程字体 - 几何简洁
      jetbrains-mono       # 现代几何等宽字体
      
      # 显示字体 - 构成主义风格
      source-serif-pro     # 现代衬线字体
      
      # 中文字体 - 几何现代
      noto-fonts-cjk-sans  # Google 几何中文
      source-han-sans      # Adobe 思源黑体
      
      # 系统字体
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Source Han Serif SC" ];
        sansSerif = [ "Source Sans Pro" "Inter" "Source Han Sans SC" ];
        monospace = [ "IBM Plex Mono" "JetBrains Mono" "Source Han Sans SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
