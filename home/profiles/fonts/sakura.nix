# Sakura 樱花主题 - 优雅的日式美学字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "sakura") {
    home.packages = with pkgs; [
      # 主力编程字体
      # 完整 Nerd Font 支持 - 樱花优雅风格
      (nerdfonts.override { 
        fonts = [ 
          "JetBrainsMono" "FiraCode" "Iosevka" "CascadiaCode" "SourceCodePro"
          "RobotoMono" "Hack" "Ubuntu" "UbuntuMono" "DejaVuSansMono"
          "InconsolataGo" "SpaceMono" "DroidSansMono" "Meslo" "AnonymousPro"
          "LiberationMono" "ProFont" "ProggyClean" "GoMono" "Agave"
          "VictorMono" "BigBlueTerminal" "Terminus"
        ]; 
      })
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
      
      # 图标和符号字体
      font-awesome
      material-design-icons
      powerline-fonts
      noto-fonts-emoji-blob-bin
      openmoji-color
      twemoji-color-font
    ];

    # 字体配置 - 樱花优雅风格
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ 
          "Inter" "Noto Sans CJK SC" "LXGW WenKai" 
          "Font Awesome 6 Free" "Material Design Icons"
        ];
        serif = [ 
          "Source Serif Pro" "Noto Serif CJK SC" "LXGW WenKai"
          "Klee One" "Zen Old Mincho"
        ];
        monospace = [ 
          "JetBrains Mono Nerd Font" "Monaspace Neon Var" "LXGW WenKai Mono"
          "Cascadia Code NF" "Victor Mono Nerd Font" "Iosevka Nerd Font"
        ];
        emoji = [ 
          "Noto Color Emoji" "OpenMoji Color" "Twemoji" "Font Awesome 6 Free"
        ];
      };
    };
  };
}
