{ config, lib, pkgs, ... }:

{
  # 调试探针支持模块
  options.mySystem.services.drivers.debug = {
    enable = lib.mkEnableOption "调试探针支持";
    
    # 常用调试探针
    stlink = lib.mkEnableOption "ST-Link 调试器" // { default = true; };
    jlink = lib.mkEnableOption "J-Link 调试器" // { default = true; };
    daplink = lib.mkEnableOption "DAPLink 调试器" // { default = true; };
    blackmagic = lib.mkEnableOption "Black Magic Probe" // { default = true; };
  };

  imports = [
    ./debug.nix
  ];
}
