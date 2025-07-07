{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wacom;
in
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
    ./integration.nix
  ];

  config = lib.mkIf cfg.enable {
    # Xorg Wacom 驱动
    services.xserver.wacom.enable = lib.mkIf cfg.driver.xorg true;
    
    # 输入设备支持
    boot.kernelModules = [ "wacom" ];
    
    # 基础 Wacom 包
    environment.systemPackages = with pkgs; [
      # 核心驱动和库
      xf86_input_wacom    # Xorg 驱动
      libwacom            # Wacom 设备库
    ]
    # OpenTabletDriver
    ++ lib.optionals cfg.driver.opentablet [
      opentabletdriver    # 开源驱动
    ]
    # 配置工具
    ++ lib.optionals cfg.tools [
      wacomtablet         # KDE Wacom 配置工具
      xsetwacom           # 命令行配置工具
    ];
    
    # 设备权限
    services.udev.extraRules = ''
      # Wacom 数位板权限
      ATTRS{idVendor}=="056a", GROUP="input", MODE="0664"
    '';
    
    # 用户组
    users.groups.input = {};
    
    # 自动配置常用 Wacom 设备
    services.udev.packages = [ pkgs.libwacom ];
  };
}
