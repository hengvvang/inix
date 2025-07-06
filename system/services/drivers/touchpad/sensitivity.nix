{ config, lib, pkgs, ... }:

{
  # 触摸板敏感度配置实现
  config = lib.mkIf config.mySystem.services.drivers.touchpad.enable {
    services.libinput.touchpad = {
      # 指针速度配置
      accelSpeed = config.mySystem.services.drivers.touchpad.sensitivity.speed;
      
      # 加速配置
      accelProfile = config.mySystem.services.drivers.touchpad.sensitivity.acceleration;
      
      # 其他敏感度相关设置
      transformationMatrix = null;  # 使用默认变换矩阵
    };
    
    # 可选：创建用户级配置文件模板
    environment.etc."libinput/touchpad-sensitivity.conf" = {
      text = ''
        # 触摸板敏感度配置
        # 这个文件由 NixOS 自动生成，请勿手动编辑
        
        # 当前配置:
        # 速度: ${toString config.mySystem.services.drivers.touchpad.sensitivity.speed}
        # 加速: ${config.mySystem.services.drivers.touchpad.sensitivity.acceleration}
      '';
      mode = "0644";
    };
  };
}
