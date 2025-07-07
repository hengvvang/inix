{ config, lib, pkgs, ... }:

{
  # Wacom 数位板驱动模块
  options.mySystem.services.drivers.wacom = {
    enable = lib.mkEnableOption "Wacom 数位板驱动支持";
    
    # 驱动选择
    driver = {
      xorg = lib.mkEnableOption "Xorg Wacom 驱动" // { default = true; };
      opentablet = lib.mkEnableOption "OpenTabletDriver 开源驱动" // { default = false; };
    };
    
    # 配置和工具
    tools = lib.mkEnableOption "配置和校准工具" // { default = true; };
    
    # 创意应用集成（单独模块）
    integration = {
      enable = lib.mkEnableOption "创意应用集成";
      painting = lib.mkEnableOption "绘画软件 (Krita, GIMP)" // { default = false; };
      modeling = lib.mkEnableOption "3D建模软件 (Blender)" // { default = false; };
    };
  };

  imports = [
    ./wacom.nix
    ./integration.nix
  ];

}
