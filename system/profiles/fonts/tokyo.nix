{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "tokyo") {
    # 系统级字体包配置 - 东京风格
    fonts.packages = with pkgs; [

      noto-fonts-cjk-sans  # Google 现代中日韩字体
      
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
      source-han-sans      # Adobe 思源黑体
      source-han-serif     # Adobe 思源宋体
      noto-fonts-cjk-serif # Google 传统中文
      sarasa-gothic       # 更纱黑体
      
      # 系统字体和图标支持
      noto-fonts
      noto-fonts-emoji
      noto-fonts-extra
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
