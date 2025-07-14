{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "vintage") {
    home.packages = with pkgs; [
      # 主要字体 - 复古经典风格
      liberation_ttf       # 包含 Times New Roman 风格字体
      dejavu_fonts         # 经典字体包
      source-serif-pro     # Adobe 现代衬线字体
      crimson              # 优雅的阅读字体
      
      # 编程字体 - 经典风格
      (nerdfonts.override { fonts = [ "InconsolataGo" "SourceCodePro" "JetBrainsMono" ]; })
      monaspace            # GitHub 现代编程字体
      courier-prime        # 现代复古等宽字体
      inconsolata          # 现代复古等宽字体
      source-code-pro      # Adobe 经典编程字体
      
      # 无衬线字体 - 经典现代
      source-sans-pro      # Adobe 经典无衬线
      open-sans           # 经典人文主义字体
      
      # 中文字体 - 传统优雅
      lxgw-wenkai         # 霞鹜文楷，传统美感
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
        serif = [ "Source Serif Pro" "Liberation Serif" "Source Han Serif SC" "LXGW WenKai" ];
        sansSerif = [ "Source Sans Pro" "Open Sans" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ "Inconsolata Go Nerd Font" "Monaspace Radon" "Source Code Pro" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
