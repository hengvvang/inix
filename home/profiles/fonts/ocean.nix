# Ocean 海洋主题 - 深邃宁静的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "ocean") {
    home.packages = with pkgs; [
      # 主力编程字体 - 清晰流畅
      # 完整 Nerd Font 支持 - 海洋深邃风格
      (nerdfonts.override { 
        fonts = [ 
          "FiraCode" "Iosevka" "JetBrainsMono" "Hack" "SourceCodePro"
          "RobotoMono" "CascadiaCode" "Ubuntu" "UbuntuMono" "DejaVuSansMono"
          "InconsolataGo" "SpaceMono" "DroidSansMono" "Meslo" "AnonymousPro"
          "LiberationMono" "ProFont" "ProggyClean" "GoMono" "Agave"
          "VictorMono" "BigBlueTerminal" "Terminus"
        ]; 
      })
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
      
      # 图标和符号字体
      font-awesome
      material-design-icons
      powerline-fonts
      noto-fonts-emoji-blob-bin
      openmoji-color
      twemoji-color-font
    ];

    # 字体配置 - 海洋深邃风格
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ 
          "Roboto" "Noto Sans CJK SC" "Sarasa Gothic SC"
          "Font Awesome 6 Free" "Material Design Icons"
        ];
        serif = [ 
          "Source Serif Pro" "Noto Serif CJK SC" "Sarasa Gothic SC"
        ];
        monospace = [ 
          "Fira Code Nerd Font" "Monaspace Argon Var" "LXGW WenKai Mono"
          "Hack Nerd Font" "Iosevka Nerd Font" "Source Code Pro Nerd Font"
        ];
        emoji = [ 
          "Noto Color Emoji" "OpenMoji Color" "Twemoji" "Font Awesome 6 Free"
        ];
      };
    };
  };
}
