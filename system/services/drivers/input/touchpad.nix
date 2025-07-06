{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.enable && config.mySystem.services.drivers.input.enable && config.mySystem.services.drivers.input.touchpad.enable) {
    # 触摸板支持
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        middleEmulation = true;
        disableWhileTyping = true;
      };
    };
    
    # X11 触摸板配置
    services.xserver.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        middleEmulation = true;
        disableWhileTyping = true;
      };
    };
  };
}
