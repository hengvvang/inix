{ config, lib, ... }:

{
  # 系统级目标应用配置 - 仅启用确定存在的系统级组件
  config = lib.mkIf (config.mySystem.profiles.stylix.enable && config.mySystem.profiles.stylix.targets.enable) {
    stylix.targets = {
      # 只启用确定存在的基础系统目标
      grub.enable = config.mySystem.profiles.stylix.targets.boot.grub.enable;
      gtk.enable = config.mySystem.profiles.stylix.targets.desktop.gtk.enable;
      console.enable = config.mySystem.profiles.stylix.targets.console.enable;
    };
    
    # 系统级透明度配置
    stylix.opacity = {
      applications = 0.9;
      terminal = 0.9;
      desktop = 1.0;
      popups = 0.8;
    };
  };
}
