{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "bauhaus") {
    # 系统级字体包配置 - 包豪斯几何风格
    fonts.packages = with pkgs; [
      # 主要字体 - 包豪斯几何风格
      source-sans-pro      # Adobe 现代几何设计
      inter                # 现代几何无衬线字体
      roboto               # Google 几何设计
      ubuntu_font_family   # Ubuntu 几何风格
      
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
      

      monaspace            # GitHub 现代编程字体
      jetbrains-mono       # 现代几何等宽字体
      iosevka             # 现代几何编程字体
      ibm-plex            # IBM 几何字体族
      
      # 显示字体 - 构成主义风格
      source-serif-pro     # 现代衬线字体
      
      # 中文字体 - 几何现代
      lxgw-wenkai         # 霞鹜文楷，现代设计
      noto-fonts-cjk-sans  # Google 几何中文
      source-han-sans      # Adobe 思源黑体
      sarasa-gothic       # 更纱黑体，几何风格
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
      liberation_ttf
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
    ];

    # 系统级字体配置 - 优化几何美学
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Serif Pro" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Roboto" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [ 
          "JetBrains Mono Nerd Font" 
          "Iosevka Nerd Font" 
          "IBM Plex Mono Nerd Font" 
          "Ubuntu Mono Nerd Font"
          "Monaspace Neon" 
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
