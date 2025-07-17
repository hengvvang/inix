{ config, lib, ... }:

{
  # 系统级壁纸配置 - 与 home/profiles/stylix/wallpapers.nix 结构对称
  config = lib.mkIf (config.mySystem.profiles.stylix.enable && config.mySystem.profiles.stylix.wallpapers.enable) {
    # 系统壁纸目录应该与 home 版本共享或单独维护
    # 这里可以指向系统级壁纸资源
    
    # 可选：为系统级壁纸添加额外的验证逻辑
    assertions = [
      {
        assertion = 
          if config.mySystem.profiles.stylix.wallpapers.custom != null
          then builtins.pathExists config.mySystem.profiles.stylix.wallpapers.custom
          else true;
        message = "系统自定义壁纸路径不存在: ${toString config.mySystem.profiles.stylix.wallpapers.custom}";
      }
    ];
  };
}
