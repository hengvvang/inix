# Zen 禅意主题 - 宁静专注的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "zen") {
    home.packages = with pkgs; [

      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.roboto-mono
      nerd-fonts.hack
      nerd-fonts.caskaydia-mono
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.inconsolata-go
      nerd-fonts.space-mono
      nerd-fonts.droid-sans-mono
      nerd-fonts.meslo-lg
      nerd-fonts.anonymice
      nerd-fonts.liberation
      nerd-fonts.profont
      nerd-fonts.proggy-clean-tt
      nerd-fonts.go-mono
      nerd-fonts.agave

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

    # 字体配置 - 禅意美学优化
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
