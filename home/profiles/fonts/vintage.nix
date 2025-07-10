{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "vintage") {
    home.packages = with pkgs; [
      # 主要字体 - 复古经典风格
      liberation_ttf       # 包含 Times New Roman 风格字体
      dejavu_fonts         # 经典字体包
      
      # 编程字体 - 经典风格
      courier-prime        # 现代复古等宽字体
      inconsolata          # 现代复古等宽字体
      
      # 中文字体 - 传统优雅
      noto-fonts-cjk-serif # Google 传统中文衬线
      source-han-serif     # Adobe 思源宋体
      source-han-sans      # Adobe 思源黑体
      
      # 系统字体
      noto-fonts
      noto-fonts-emoji
      liberation_ttf
      dejavu_fonts
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Liberation Serif" "Source Han Serif SC" ];
        sansSerif = [ "Liberation Sans" "Source Han Sans SC" ];
        monospace = [ "Courier Prime" "Inconsolata" "Source Han Sans SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
