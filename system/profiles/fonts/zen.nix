{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "zen") {
    fonts.packages = with pkgs; [
      (nerdfonts.override { 
        fonts = [ 
          "Iosevka" "JetBrainsMono" "InconsolataGo" "SourceCodePro" "FiraCode"
          "RobotoMono" "Hack" "CascadiaCode" "Ubuntu" "UbuntuMono"
          "DejaVuSansMono" "SpaceMono" "DroidSansMono" "Meslo" "AnonymousPro"
          "LiberationMono" "ProFont" "ProggyClean" "GoMono" "Agave"
        ]; 
      })
      monaspace
      
      # 中文字体 - 传统与现代融合
      lxgw-wenkai
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-han-sans
      source-han-serif
      
      # 西文字体 - 简约优雅
      inter
      source-sans-pro
      source-serif-pro
      noto-fonts
      
      # 特色字体 - 禅意设计
      inconsolata
      ubuntu_font_family
      
      # 编程字体
      iosevka
      jetbrains-mono
      inconsolata-go
      
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

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Source Han Sans SC" "LXGW WenKai" ];
        serif = [ "Source Serif Pro" "Source Han Serif SC" "LXGW WenKai" ];
        monospace = [ 
          "Iosevka Nerd Font" 
          "JetBrains Mono Nerd Font"
          "Inconsolata Go Nerd Font"
          "Source Code Pro Nerd Font"
          "Monaspace Xenon" 
          "LXGW WenKai Mono" 
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
