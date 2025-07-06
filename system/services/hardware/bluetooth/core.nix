{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.hardware.bluetooth.enable {
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
      };
    };

    # BlueZ 工具
    environment.systemPackages = with pkgs; [
      bluez
      bluez-tools
      blueman  # 蓝牙管理器 GUI
    ];

    # 蓝牙音频支持
    services.blueman.enable = true;
    
    # 用户组配置
    users.users.hengvvang.extraGroups = [ "bluetooth" ];

    # 系统服务
    systemd.user.services.bluetooth-agent = {
      description = "Bluetooth agent";
      wantedBy = [ "default.target" ];
      after = [ "bluetooth.service" ];
      
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.bluez}/bin/bluetooth-agent";
        Restart = "on-failure";
      };
    };
  };
}
