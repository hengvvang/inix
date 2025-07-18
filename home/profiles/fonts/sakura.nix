# Sakura 樱花主题 - 优雅的日式美学字体配置
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "sakura") {
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
