{ config, lib, pkgs, ... }:

{
  # 触摸板核心功能实现
  config = lib.mkIf config.mySystem.services.drivers.touchpad.enable {
    # 启用 libinput 触摸板支持
    services.libinput = {
      enable = true;
      
      touchpad = {
        # 基础功能
        tapping = config.mySystem.services.drivers.touchpad.basic.tapping;
        clickMethod = config.mySystem.services.drivers.touchpad.basic.clickMethod;
        
        # 滚动配置 - 使用正确的选项名
        naturalScrolling = config.mySystem.services.drivers.touchpad.scrolling.naturalScrolling;
        scrollMethod = "twofinger";  # 替代 twoFingerScroll
        horizontalScrolling = config.mySystem.services.drivers.touchpad.scrolling.horizontalScrolling;
        
        # 其他功能
        middleEmulation = true;
        disableWhileTyping = true;
      };
    };
    
    # 触摸板工具
    environment.systemPackages = with pkgs; [
      libinput          # libinput 工具
      xorg.xinput       # X11 输入设备配置
    ];
    
    # 设备权限
    services.udev.extraRules = ''
      # 触摸板设备权限
      KERNEL=="event[0-9]*", ATTRS{name}=="*touchpad*", GROUP="input", MODE="0664"
      KERNEL=="event[0-9]*", ATTRS{name}=="*TrackPad*", GROUP="input", MODE="0664"
    '';
  };
}
