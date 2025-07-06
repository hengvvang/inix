{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.hardware.enable && config.mySystem.services.hardware.bluetooth.enable) {
    # 蓝牙服务配置
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      
      # 蓝牙配置
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          KernelExperimental = true;
        };
        
        Policy = {
          AutoEnable = true;
        };
        
        A2DP = {
          SBCQualityMode = "XQ";
          AACQualityMode = "5";
        };
      };
    };

    # BlueZ 工具
    environment.systemPackages = with pkgs; [
      bluez
      bluez-tools
      blueman  # 蓝牙管理器 GUI
      bluetuith # TUI 蓝牙管理器
    ];

    # 蓝牙音频支持
    services.blueman.enable = true;
  };
}
