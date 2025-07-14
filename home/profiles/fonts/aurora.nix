# Aurora 极光主题 - 绚烂多彩的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "aurora") {
    home.packages = with pkgs; [
      # 主力编程字体 - 现代科技感
      (nerdfonts.override { fonts = [ "CascadiaCode" "FiraCode" "VictorMono" "Iosevka" ]; })
      monaspace
      
      # 中文字体 - 现代设计
      lxgw-wenkai
      noto-fonts-cjk-sans
      sarasa-gothic
      source-han-sans
      
      # 西文字体 - 现代时尚
      inter
      roboto
      ubuntu_font_family
      noto-fonts
      noto-fonts-emoji
      
      # 特色字体
      cascadia-code
      victor-mono
      fira-sans
      
      # 编程字体
      fira-code
      victor-mono
      cascadia-code
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Roboto" "Sarasa Gothic SC" ];
        serif = [ "Source Serif Pro" "Noto Serif CJK SC" ];
        monospace = [ "Cascadia Code Nerd Font" "Monaspace Krypton" "Victor Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
