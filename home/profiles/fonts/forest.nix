{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "forest") {
    home.packages = with pkgs; [
      # 主要字体 - 自然有机风格
      source-serif-pro     # 温暖的阅读字体
      merriweather         # 自然优雅的衬线
      
      # 无衬线字体 - 温暖人文
      open-sans            # 人文主义无衬线
      lato                 # 温暖现代风格
      source-sans-pro      # 友好易读
      
      # 编程字体 - 温和舒适
      fira-code            # 连字编程字体
      source-code-pro      # 人文主义等宽字体
      
      # 中文字体 - 温暖自然
      noto-fonts-cjk-sans  # Google 现代中文
      source-han-sans      # Adobe 思源黑体
      source-han-serif     # Adobe 思源宋体
      
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
        serif = [ "Source Serif Pro" "Merriweather" "Source Han Serif SC" ];
        sansSerif = [ "Open Sans" "Lato" "Source Han Sans SC" ];
        monospace = [ "Fira Code" "Source Code Pro" "Source Han Sans SC" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
