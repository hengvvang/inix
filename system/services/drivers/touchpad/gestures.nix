{ config, lib, pkgs, ... }:

{
  # 触摸板手势功能实现
  config = lib.mkIf (config.mySystem.services.drivers.touchpad.enable && config.mySystem.services.drivers.touchpad.gestures.multitouch) {
    # 安装手势相关软件包
    environment.systemPackages = with pkgs; [
      libinput-gestures  # libinput 手势支持
      touchegg           # 触摸手势引擎
    ];
    
    # 为手势添加用户组
    users.groups.input = {};
    
    # 用户需要在 input 组中才能使用手势
    users.users.hengvvang = {
      extraGroups = [ "input" ];
    };
    
    # 手势服务配置
    systemd.user.services.libinput-gestures = lib.mkIf config.mySystem.services.drivers.touchpad.gestures.swipeGestures {
      description = "Libinput Gestures";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
    
    # touchegg 服务配置
    systemd.user.services.touchegg = lib.mkIf config.mySystem.services.drivers.touchpad.gestures.pinchZoom {
      description = "Touchegg Daemon";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.touchegg}/bin/touchegg --daemon";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
    
    # 手势设备权限
    services.udev.extraRules = ''
      # 手势设备权限
      KERNEL=="event[0-9]*", ATTRS{name}=="*touchpad*", TAG+="uaccess"
      KERNEL=="event[0-9]*", ATTRS{name}=="*TrackPad*", TAG+="uaccess"
    '';
  };
}
