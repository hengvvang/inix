{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.localization.inputMethod.fcitx5 {
    # Fcitx5 输入法配置
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        # 中文输入法
        fcitx5-chinese-addons    # 中文拼音、五笔等
        fcitx5-rime             # Rime 输入法引擎
        
        # 界面支持
        fcitx5-gtk              # GTK 应用支持
        libsForQt5.fcitx5-qt    # Qt5 应用支持
        
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
    environment.variables = {
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
    };

    # 确保与其他输入法互斥
    assertions = [
      {
        assertion = !config.mySystem.localization.inputMethod.ibus;
        message = "只能选择一个输入法配置";
      }
    ];
  };
}
