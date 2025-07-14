# Zen 禅意主题 - 宁静专注的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "zen") {
    home.packages = with pkgs; [
      # 主力编程字体 - 专注清晰
      (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" "InconsolataGo" ]; })
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
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Source Han Sans SC" "LXGW WenKai" ];
        serif = [ "Source Serif Pro" "Source Han Serif SC" ];
        monospace = [ "Iosevka Nerd Font" "Monaspace Xenon" "LXGW WenKai Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
