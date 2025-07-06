{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.touchpad.enable {
    # 触摸板支持 - 从 system/hardware/hardware.nix 迁移
    services.libinput.enable = true;
    
    # 触摸板高级配置
    services.libinput.touchpad = {
      tapping = true;              # 轻触即点击
      naturalScrolling = true;     # 自然滚动
      middleEmulation = true;      # 中键模拟
    };
  };
}
