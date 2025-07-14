# Sakura 樱花主题 - 优雅的日式美学字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "sakura") {
    home.packages = with pkgs; [
      # 主力编程字体
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Iosevka" "CascadiaCode" ]; })
      monaspace
      
      # 中文字体 - 优雅的中日文支持
      lxgw-wenkai
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-han-sans
      source-han-serif
      
      # 西文字体 - 现代简约
      inter
      source-sans-pro
      source-serif-pro
      noto-fonts
      noto-fonts-emoji
      
      # 特色字体 - 日式风格
      klee-one
      zen-old-mincho
      
      # 终端和编辑器字体
      fira-code
      jetbrains-mono
      cascadia-code
      victor-mono
    ];

    # 字体配置
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Noto Sans CJK SC" "LXGW WenKai" ];
        serif = [ "Source Serif Pro" "Noto Serif CJK SC" "LXGW WenKai" ];
        monospace = [ "JetBrains Mono Nerd Font" "Monaspace Neon" "LXGW WenKai Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
