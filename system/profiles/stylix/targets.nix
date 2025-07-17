{ config, lib, ... }:

{
  # 系统级目标应用配置 - 主要处理系统级组件
  # 🚧 暂时简化配置，只启用确实存在的系统级目标
  config = lib.mkIf (config.mySystem.profiles.stylix.enable && config.mySystem.profiles.stylix.targets.enable) {
    stylix.targets = {
      # 基础系统组件 - 只启用肯定存在的选项
      grub.enable = lib.mkDefault true;
      # plymouth.enable = lib.mkDefault true;  # 可能不存在
      # lightdm.enable = lib.mkDefault false;  # 可能不存在
      # gdm.enable = lib.mkDefault false;      # 可能不存在
      
      # 桌面环境主题
      gtk.enable = lib.mkDefault true;
      
      # � 其他目标应该在 Home Manager 中配置
      # 这样可以避免系统级和用户级配置的冲突
    };
  };
}
