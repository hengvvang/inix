{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.profiles.enable && config.myHome.profiles.fonts.enable && config.myHome.profiles.fonts.preset == "cyberPunk") {
    home.packages = with pkgs; [

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
      nerd-fonts.monaspace

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      source-han-mono

      monaspace            # GitHub 现代编程字体族
      fira-code            # 连字编程字体，科技感十足
      jetbrains-mono       # 现代等宽字体
      cascadia-code        # 微软开发的现代编程字体
      victor-mono          # 手写风格编程字体

      # 显示字体 - 未来主义风格
      inter                # 现代几何无衬线字体
      source-sans-pro      # Adobe 现代无衬线
      roboto               # Google 材质设计字体
      ubuntu_font_family   # Ubuntu 现代字体族

      # 中文字体 - 简洁现代
      lxgw-wenkai         # 霞鹜文楷
      sarasa-gothic       # 更纱黑体，编程友好

      # 特色字体 - 赛博朋克元素
      hack-font            # 黑客风格等宽字体
      iosevka             # 现代编程字体

      # 系统字体和图标支持
      liberation_ttf
      font-awesome        # Font Awesome 图标字体
      material-design-icons # Material Design 图标
      powerline-fonts     # Powerline 字体支持
    ];

    # 字体配置 - 赛博朋克风格优化
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif SC" ];
        sansSerif = [ "Inter" "Roboto" "Source Han Sans SC" "LXGW WenKai" ];
        monospace = [
          "Fira Code Nerd Font"
          "Cascadia Code Nerd Font"
          "Victor Mono Nerd Font"
          "Hack Nerd Font"
          "JetBrains Mono Nerd Font"
          "Monaspace Krypton"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
