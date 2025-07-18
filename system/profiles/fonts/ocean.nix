# Ocean 海洋主题 - 深邃宁静的字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "ocean") {
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

    # 系统级字体配置 - 海洋深邃风格
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
