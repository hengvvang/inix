{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "zen") {

    fonts = {
      # 启用默认字体包
      enableDefaultPackages = true;

      # 启用 Ghostscript 字体支持（用于 PDF 和 PostScript）
      enableGhostscriptFonts = true;

      # 字体目录配置
      fontDir.enable = true;

      packages = with pkgs; [
        # 主要字体 - 禅意风格
        inter                # 现代简约设计
        source-sans-pro      # Adobe 清晰无衬线
        ubuntu_font_family   # Ubuntu 温和字体

        # 衬线字体 - 禅意优雅
        source-serif-pro     # Adobe 现代衬线
        crimson              # 优雅阅读字体

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
        nerd-fonts.monaspace

        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        source-han-sans
        source-han-serif
        source-han-mono

        monaspace            # GitHub 现代编程字体
        fira-code            # 连字编程字体
        jetbrains-mono       # 现代等宽字体
        iosevka              # 现代编程字体
        inconsolata          # 极简等宽字体

        # 中文字体 - 禅意简约
        lxgw-wenkai         # 霞鹜文楷，禅意优雅

        # 系统字体和图标支持
        liberation_ttf
        dejavu_fonts
        font-awesome        # Font Awesome 图标字体
        material-design-icons # Material Design 图标
        powerline-fonts     # Powerline 字体支持
      ];

      fontconfig = {
        enable = true;
        # 字体渲染优化配置
        antialias = true;              # 开启抗锯齿
        cache32Bit = true;             # 启用32位字体缓存
        hinting = {
          enable = true;               # 启用字体微调
          autohint = false;            # 禁用自动微调，使用内置微调
          style = "slight";            # 禅意风格使用轻微微调，保持自然
        };
        subpixel = {
          rgba = "rgb";                # 子像素渲染：rgb, bgr, vrgb, vbgr, none
          lcdfilter = "default";       # LCD滤镜：default, light, legacy, none
        };

        # 字体回退和替换配置
        includeUserConf = true;        # 包含用户字体配置
        allowBitmaps = true;           # 允许位图字体
        allowType1 = true;             # 允许 Type1 字体
        useEmbeddedBitmaps = true;     # 使用嵌入式位图

        defaultFonts = {
          serif = [ "Source Serif Pro" "Source Han Serif SC" "LXGW WenKai" ];
          sansSerif = [ "Inter" "Source Han Sans SC" "LXGW WenKai" ];
          monospace = [
            "Iosevka Nerd Font"
            "JetBrains Mono Nerd Font"
            "Inconsolata Go Nerd Font"
            "Source Code Pro Nerd Font"
            "Monaspace Xenon"
            "LXGW WenKai Mono"
          ];
          emoji = [ "Noto Color Emoji" ];
        };

        # localConf = ''
        # '';
      };
    };
  };
}
