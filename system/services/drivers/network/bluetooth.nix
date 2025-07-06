{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.enable && config.mySystem.services.drivers.network.enable && config.mySystem.services.drivers.network.bluetooth.enable) {
    # 蓝牙硬件支持
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
    
    # 蓝牙服务
    services.blueman.enable = true;
    
    # 蓝牙工具
    environment.systemPackages = with pkgs; [
      bluez
      bluez-tools
      bluetuith
    ];
  };
}
