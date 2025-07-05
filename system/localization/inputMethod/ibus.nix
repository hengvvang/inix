{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.localization.inputMethod.ibus {
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
    environment.variables = {
      GTK_IM_MODULE = "ibus";
      QT_IM_MODULE = "ibus";
      XMODIFIERS = "@im=ibus";
      SDL_IM_MODULE = "ibus";
      GLFW_IM_MODULE = "ibus";
    };

    # 确保与其他输入法互斥
    assertions = [
      {
        assertion = !config.mySystem.localization.inputMethod.fcitx5;
        message = "只能选择一个输入法配置";
      }
    ];
  };
}
