{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.profiles.enable && config.mySystem.profiles.fonts.enable && config.mySystem.profiles.fonts.preset == "aurora") {

    fonts = {
      # 启用默认字体包
      enableDefaultPackages = true;

      # 启用 Ghostscript 字体支持（用于 PDF 和 PostScript）
      enableGhostscriptFonts = true;

      # 字体目录配置
      fontDir.enable = true;

      packages = with pkgs; [
        # 主要字体 - 极光风格
        inter                # 现代简洁设计
        work-sans            # 工作场景优化字体
        source-sans-pro      # Adobe 清晰易读

        # 衬线字体 - 极光优雅
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

        # 中文字体 - 极光清新
        lxgw-wenkai         # 霞鹜文楷，清新优雅
        sarasa-gothic       # 更纱黑体

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
          style = "slight";            # 极光风格使用轻微微调，保持清新感
        };
        subpixel = {
          rgba = "rgb";                # 子像素渲染：rgb, bgr, vrgb, vbgr, none
          lcdfilter = "light";         # 极光风格使用轻量LCD滤镜
        };

        # 字体回退和替换配置
        includeUserConf = true;        # 包含用户字体配置
        allowBitmaps = true;           # 允许位图字体
        allowType1 = true;             # 允许 Type1 字体
        useEmbeddedBitmaps = true;     # 使用嵌入式位图

        defaultFonts = {
          serif = [ "Source Serif Pro" "Crimson" "Source Han Serif SC" "LXGW WenKai" ];
          sansSerif = [ "Inter" "Work Sans" "Source Han Sans SC" "LXGW WenKai" ];
          monospace = [
            "Fira Code Nerd Font"
            "JetBrains Mono Nerd Font"
            "Iosevka Nerd Font"
            "Monaspace Neon"
            "Sarasa Gothic SC"
          ];
          emoji = [ "Noto Color Emoji" ];
        };

        # 极光主题字体优化
        localConf = ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
          <fontconfig>
            <!-- Aurora 主题优化字体渲染 -->
            
            <!-- 针对小字体的清新优化 -->
            <match target="font">
              <test name="size" qual="any" compare="less">
                <double>10</double>
              </test>
              <edit name="autohint" mode="assign">
                <bool>true</bool>
              </edit>
              <edit name="hintstyle" mode="assign">
                <const>hintslight</const>
              </edit>
            </match>
            
            <!-- Inter 字体清新优化 -->
            <match target="font">
              <test name="family" qual="any" compare="eq">
                <string>Inter</string>
              </test>
              <edit name="fontfeatures" mode="append">
                <string>cv02 on</string>
                <string>cv03 on</string>
                <string>cv04 on</string>
              </edit>
            </match>
            
            <!-- 编程字体连字支持 -->
            <match target="font">
              <test name="family" qual="any" compare="eq">
                <string>Fira Code</string>
              </test>
              <edit name="fontfeatures" mode="append">
                <string>liga on</string>
                <string>calt on</string>
              </edit>
            </match>
            
          </fontconfig>
        '';
      };
    };
  };
}
