{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wacom;
in
{
  config = lib.mkIf cfg.enable {
    # 压感支持配置
    environment.variables = lib.mkIf cfg.features.pressure {
      WACOM_PRESSURE_CURVE = "0 0 100 100";
    };
    
    # 倾斜角度支持
    services.xserver.wacom = lib.mkIf cfg.features.tilt {
      enable = true;
    };
    
    # 旋转支持
    environment.systemPackages = lib.optionals cfg.features.rotation (with pkgs; [
      iio-sensor-proxy  # 自动旋转传感器
    ]);
    
    # 触摸功能
    services.xserver.libinput = lib.mkIf cfg.features.touch {
      touchpad.tapping = true;
    };
    
    # 快捷按键支持
    environment.systemPackages = lib.optionals cfg.features.buttons (with pkgs; [
      xbindkeys
      xdotool
    ]);
    
    # 自定义 udev 规则用于功能配置
    services.udev.extraRules = lib.optionalString cfg.features.pressure ''
      # 压感配置
      SUBSYSTEM=="input", ATTRS{name}=="*Wacom*", ENV{WACOM_PRESSURE}="4096"
    '' + lib.optionalString cfg.features.buttons ''
      # 按键映射
      SUBSYSTEM=="input", ATTRS{name}=="*Wacom*", ENV{WACOM_BUTTONS}="enabled"
    '';
  };
}
