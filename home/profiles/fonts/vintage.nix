{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "vintage") {
    home.packages = with pkgs; [

      liberation_ttf       # 包含 Times New Roman 风格字体
      dejavu_fonts         # 经典字体包
      source-serif-pro     # Adobe 现代衬线字体
      crimson              # 优雅的阅读字体
      
      # 完整 Nerd Font 支持 - 复古经典风格
      (nerdfonts.override { 
        fonts = [ 
          "InconsolataGo" "SourceCodePro" "JetBrainsMono" "DejaVuSansMono"
          "LiberationMono" "DroidSansMono" "AnonymousPro" "ProFont"
          "ProggyClean" "Terminus" "FiraCode" "Iosevka" "Hack"
          "RobotoMono" "SpaceMono" "UbuntuMono" "CascadiaCode" "Meslo"
        ]; 
      })
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
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      dejavu_fonts
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
      powerline-fonts     # Powerline 字体支持
    ];

    # 字体配置 - 复古经典优化
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Liberation Serif" "Source Han Serif SC" "LXGW WenKai" ];
        sansSerif = [ "Source Sans Pro" "Open Sans" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ 
          "Inconsolata Go Nerd Font" 
          "Source Code Pro Nerd Font"
          "JetBrains Mono Nerd Font"
          "DejaVu Sans Mono Nerd Font"
          "Liberation Mono Nerd Font"
          "Monaspace Radon" 
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
