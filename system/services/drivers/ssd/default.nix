{ config, lib, pkgs, ... }:

{
  # SSD 固态硬盘优化模块
  options.mySystem.services.drivers.ssd = {
    enable = lib.mkEnableOption "SSD 固态硬盘优化支持";
    
    # 基础优化（默认启用）
    trim = lib.mkEnableOption "TRIM 垃圾回收" // { default = true; };
    scheduler = lib.mkEnableOption "I/O 调度器优化" // { default = true; };
    
    # 监控工具
    monitoring = {
      smart = lib.mkEnableOption "SMART 健康监控" // { default = true; };
      tools = lib.mkEnableOption "监控和管理工具" // { default = true; };
    };
    
    # 高级功能（企业级，单独模块）
    advanced = {
      enable = lib.mkEnableOption "高级 SSD 功能";
      powermanagement = lib.mkEnableOption "电源管理优化" // { default = false; };
      encryption = lib.mkEnableOption "硬件加密支持" // { default = false; };
    };
  };

  imports = [
    ./ssd.nix
    ./advanced.nix
  ];

}
