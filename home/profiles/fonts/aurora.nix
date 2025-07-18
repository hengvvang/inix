# Aurora 极光主题 - 绚烂多彩的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "aurora") {
    home.packages = with pkgs; [
      
      (nerdfonts.override { 
        fonts = [ 
          "CascadiaCode" "FiraCode" "VictorMono" "Iosevka" "JetBrainsMono"
          "SourceCodePro" "RobotoMono" "Hack" "Ubuntu" "UbuntuMono"
          "DejaVuSansMono" "InconsolataGo" "SpaceMono" "DroidSansMono"
          "Meslo" "AnonymousPro" "LiberationMono" "ProFont" "ProggyClean"
          "GoMono" "Agave" "BigBlueTerminal" "Terminus"
        ]; 
      })
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
      
      # 图标和符号字体
      font-awesome
      material-design-icons
      powerline-fonts
      noto-fonts-emoji-blob-bin
      openmoji-color
      twemoji-color-font
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ 
          "Inter" "Roboto" "Sarasa Gothic SC"
          "Font Awesome 6 Free" "Material Design Icons"
        ];
        serif = [ 
          "Source Serif Pro" "Noto Serif CJK SC" "Sarasa Gothic SC"
        ];
        monospace = [ 
          "Cascadia Code Nerd Font" "Monaspace Krypton Var" "Victor Mono Nerd Font"
          "Fira Code Nerd Font" "JetBrains Mono Nerd Font" "Iosevka Nerd Font"
        ];
        emoji = [ 
          "Noto Color Emoji" "OpenMoji Color" "Twemoji" "Font Awesome 6 Free"
        ];
      };
    };
  };
}
