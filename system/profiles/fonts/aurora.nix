{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "aurora") {
    # 系统级字体包配置 - 极光风格
    fonts.packages = with pkgs; [

      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.roboto-mono
      nerd-fonts.hack
      nerd-fonts.caskaydia-mono      # Cascadia Code 的 nerd-fonts 版本
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

    # 系统级字体配置
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
