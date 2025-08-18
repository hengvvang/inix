{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "tokyo") {
    # 字体包配置 - 东京风格
    home.packages = with pkgs; [

      noto-fonts-cjk-sans
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

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      source-han-mono

      monaspace            # GitHub 现代编程字体
      source-code-pro      # 简洁专业
      jetbrains-mono       # 现代等宽字体
      fira-code           # Mozilla 连字编程字体
      cascadia-code       # Microsoft 现代编程字体

      # 西文字体 - 简约现代
      inter                # 现代几何设计
      source-sans-pro      # Adobe 系统字体风格
      roboto              # Google 材质设计字体
      ubuntu_font_family   # Ubuntu 现代字体

      # 中文字体 - 东亚现代美学
      lxgw-wenkai         # 霞鹜文楷，优雅中文
      sarasa-gothic       # 更纱黑体

      liberation_ttf
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Source Han Serif SC" "Noto Serif CJK SC" "LXGW WenKai" ];
        sansSerif = [ "Inter" "Source Han Sans SC" "Noto Sans CJK SC" "Roboto" ];
        monospace = [
          "JetBrains Mono Nerd Font"
          "Fira Code Nerd Font"
          "Cascadia Code Nerd Font"
          "Source Code Pro Nerd Font"
          "Monaspace Neon"
          "Sarasa Gothic SC"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
