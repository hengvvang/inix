{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.wacom.enable {
    # Wacom 数位板支持
    services.xserver.wacom.enable = true;
    
    # 安装 Wacom 工具
    environment.systemPackages = with pkgs; [
      xf86_input_wacom
      wacomtablet
    ];
    
    # 硬件检测
    hardware.opentabletdriver.enable = true;
  };
}
