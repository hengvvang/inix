{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "vintage") {

    fonts = {
      # 启用默认字体包
      enableDefaultPackages = true;
      # 启用 Ghostscript 字体支持（用于 PDF 和 PostScript）
      enableGhostscriptFonts = true;
      # 字体目录配置
      fontDir.enable = true;
      packages = with pkgs; [
        # 主要字体 - 复古风格
        liberation_ttf       # 包含 Times New Roman 风格字体
        dejavu_fonts         # 经典字体包
        source-serif-pro     # Adobe 现代衬线字体
        crimson              # 优雅的阅读字体
        # 无衬线字体 - 经典现代
        source-sans-pro      # Adobe 经典无衬线
        open-sans           # 经典人文主义字体

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
        noto-fonts-color-emoji
        source-han-sans
        source-han-serif
        source-han-mono

        # 等宽字体 - 复古经典
        monaspace            # GitHub 现代编程字体
        fira-code            # 连字编程字体
        inconsolata          # 现代复古等宽字体
        source-code-pro      # Adobe 经典编程字体

        # 中文字体 - 传统优雅
        lxgw-wenkai         # 霞鹜文楷，传统美感

        # 系统字体和图标支持
        noto-fonts-extra
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
          style = "medium";            # 复古风格使用中等微调，保持经典感
        };
        subpixel = {
          rgba = "rgb";                # 子像素渲染：rgb, bgr, vrgb, vbgr, none
          lcdfilter = "legacy";        # 复古风格使用传统LCD滤镜
        };

        # 字体回退和替换配置
        includeUserConf = true;        # 包含用户字体配置
        allowBitmaps = true;           # 允许位图字体
        allowType1 = true;             # 允许 Type1 字体
        useEmbeddedBitmaps = true;     # 使用嵌入式位图

        defaultFonts = {
          serif = [ "Source Serif Pro" "Crimson" "Liberation Serif" "Source Han Serif SC" "LXGW WenKai" ];
          sansSerif = [ "Open Sans" "Source Sans Pro" "Liberation Sans" "Source Han Sans SC" "LXGW WenKai" ];
          monospace = [
            "Source Code Pro Nerd Font"
            "Inconsolata Nerd Font"
            "Fira Code Nerd Font"
            "Liberation Mono"
            "DejaVu Sans Mono"
          ];
          emoji = [ "Noto Color Emoji" "Noto Emoji" ];
        };

      #   localConf = ''
      };
    };
  };
}
