{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "forest") {

    fonts.packages = with pkgs; [

      source-serif-pro     # 温暖的阅读字体
      merriweather         # 自然优雅的衬线
      crimson              # 优雅的阅读字体

      # 无衬线字体 - 温暖人文
      open-sans            # 人文主义无衬线
      lato                 # 温暖现代风格
      source-sans-pro      # 友好易读
      ubuntu_font_family   # Ubuntu 温暖字体

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

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      source-han-mono

      monaspace            # GitHub 现代编程字体
      fira-code            # 连字编程字体
      source-code-pro      # 人文主义等宽字体
      jetbrains-mono       # 现代等宽字体

      # 中文字体 - 温暖自然
      lxgw-wenkai         # 霞鹜文楷，温暖中文
      sarasa-gothic       # 更纱黑体

      # 系统字体和图标支持
      liberation_ttf
      dejavu_fonts
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
      powerline-fonts     # Powerline 字体支持
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Source Serif Pro" "Merriweather" "Source Han Serif SC" "LXGW WenKai"
          "Font Awesome 6 Free"
        ];
        sansSerif = [
          "Open Sans" "Lato" "Source Han Sans SC" "LXGW WenKai"
          "Font Awesome 6 Free" "Material Design Icons"
        ];
        monospace = [
          "Fira Code Nerd Font" "Monaspace Neon Var" "Sarasa Gothic SC"
          "JetBrains Mono Nerd Font" "Source Code Pro Nerd Font"
        ];
        emoji = [
          "Noto Color Emoji" "OpenMoji Color" "Twemoji" "Font Awesome 6 Free"
        ];
      };
    };
  };
}
