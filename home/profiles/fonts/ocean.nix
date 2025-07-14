# Ocean 海洋主题 - 深邃宁静的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "ocean") {
    home.packages = with pkgs; [
      # 主力编程字体 - 清晰流畅
      (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" "Hack" "SourceCodePro" ]; })
      monaspace
      
      # 中文字体 - 现代简洁
      lxgw-wenkai
      noto-fonts-cjk-sans
      source-han-sans
      sarasa-gothic
      
      # 西文字体 - 现代设计
      roboto
      open-sans
      source-sans-pro
      noto-fonts
      noto-fonts-emoji
      
      # 特色字体
      fira-sans
      ubuntu_font_family
      
      # 编程和终端
      fira-code
      source-code-pro
      hack-font
      iosevka
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Roboto" "Noto Sans CJK SC" "Sarasa Gothic SC" ];
        serif = [ "Source Serif Pro" "Noto Serif CJK SC" ];
        monospace = [ "Fira Code Nerd Font" "Monaspace Argon" "LXGW WenKai Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
