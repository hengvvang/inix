{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # Fcitx5 配置
    (lib.mkIf config.mySystem.locale.inputMethod.fcitx5.enable {
      # 基础本地化设置
      i18n.defaultLocale = "zh_CN.UTF-8";
      
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "zh_CN.UTF-8";
        LC_IDENTIFICATION = "zh_CN.UTF-8";
        LC_MEASUREMENT = "zh_CN.UTF-8";
        LC_MONETARY = "zh_CN.UTF-8";
        LC_NAME = "zh_CN.UTF-8";
        LC_NUMERIC = "zh_CN.UTF-8";
        LC_PAPER = "zh_CN.UTF-8";
        LC_TELEPHONE = "zh_CN.UTF-8";
        LC_TIME = "zh_CN.UTF-8";
      };

      # 字体支持
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        source-han-sans
        source-han-serif
        wqy_microhei
        wqy_zenhei
      ];

      # Fcitx5 输入法配置
      i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5.addons = with pkgs; [
          # 中文输入法
          fcitx5-chinese-addons    # 中文拼音、五笔等
          fcitx5-rime             # Rime 输入法引擎
          
          # 界面支持 (Wayland 优化)
          fcitx5-gtk              # GTK 应用支持 (包含 Wayland 支持)
          libsForQt5.fcitx5-qt    # Qt5 应用支持
          fcitx5-qt6              # Qt6 应用支持 (现代 Wayland 应用)
          
          # 主题和外观
          fcitx5-nord             # Nord 主题
          fcitx5-material-color   # Material 主题
          
          # 其他语言支持
          fcitx5-mozc             # 日语输入法
          fcitx5-hangul           # 韩语输入法
          fcitx5-table-extra      # 额外的表形输入法
          fcitx5-table-other      # 其他表形输入法
        ];
      };

      # Fcitx5 环境变量配置
      # 针对 Wayland 桌面环境优化：
      # - GTK_IM_MODULE: 在 Wayland 中使用原生输入法协议，注释掉避免冲突
      # - QT_IM_MODULE: Qt 应用仍需要此设置
      # - XMODIFIERS: X11 应用兼容性
      # - SDL_IM_MODULE: SDL 应用支持
      environment.variables = {
        # GTK_IM_MODULE = "fcitx";  # Wayland 原生支持，不需要此设置
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        SDL_IM_MODULE = "fcitx";
        GLFW_IM_MODULE = "fcitx";
      };
    })

    # IBus 配置
    (lib.mkIf config.mySystem.locale.inputMethod.ibus.enable {
      # 基础本地化设置
      i18n.defaultLocale = "zh_CN.UTF-8";
      
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "zh_CN.UTF-8";
        LC_IDENTIFICATION = "zh_CN.UTF-8";
        LC_MEASUREMENT = "zh_CN.UTF-8";
        LC_MONETARY = "zh_CN.UTF-8";
        LC_NAME = "zh_CN.UTF-8";
        LC_NUMERIC = "zh_CN.UTF-8";
        LC_PAPER = "zh_CN.UTF-8";
        LC_TELEPHONE = "zh_CN.UTF-8";
        LC_TIME = "zh_CN.UTF-8";
      };

      # 字体支持
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        source-han-sans
        source-han-serif
        wqy_microhei
        wqy_zenhei
      ];

      # IBus 输入法配置
      i18n.inputMethod = {
        type = "ibus";
        enable = true;
        ibus.engines = with pkgs.ibus-engines; [
          # 中文输入法
          ibus-libpinyin          # 拼音输入法
          ibus-rime               # Rime 输入法引擎
          ibus-table-chinese      # 中文表形输入法
          
          # 其他语言支持
          ibus-mozc               # 日语输入法
          ibus-hangul             # 韩语输入法
          ibus-anthy              # 日语假名汉字转换
        ];
      };

      # IBus 环境变量配置
      # 针对 Wayland 桌面环境优化：
      # - GTK_IM_MODULE: 在 Wayland 中使用原生输入法协议，注释掉避免冲突
      # - 其他环境变量保持 ibus 设置以确保兼容性
      environment.variables = {
        # GTK_IM_MODULE = "ibus";  # Wayland 原生支持，不需要此设置
        QT_IM_MODULE = "ibus";
        XMODIFIERS = "@im=ibus";
        SDL_IM_MODULE = "ibus";
        GLFW_IM_MODULE = "ibus";
      };
    })
  ];
}
