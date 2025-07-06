{ config, lib, pkgs, ... }:

{
  # SSD 存储驱动模块的完整选项定义
  options.mySystem.services.drivers.ssd = {
    enable = lib.mkEnableOption "SSD 存储优化支持";
    
    # === 性能优化选项 ===
    optimization = {
      trim = lib.mkEnableOption "TRIM 支持" // { default = true; };
      scheduler = lib.mkEnableOption "I/O 调度器优化" // { default = true; };
      swap = lib.mkEnableOption "交换分区优化" // { default = true; };
      filesystem = lib.mkEnableOption "文件系统优化" // { default = true; };
    };
    
    # === 监控选项 ===
    monitoring = {
      smart = lib.mkEnableOption "SMART 健康监控" // { default = true; };
      temperature = lib.mkEnableOption "温度监控";
      wear = lib.mkEnableOption "磨损监控";
      performance = lib.mkEnableOption "性能监控";
    };
    
    # === 工具选项 ===
    tools = {
      nvme = lib.mkEnableOption "NVMe 管理工具" // { default = true; };
      analysis = lib.mkEnableOption "分析工具";
      benchmark = lib.mkEnableOption "基准测试工具";
      maintenance = lib.mkEnableOption "维护工具";
    };
    
    # === 高级功能选项 ===
    advanced = {
      powermanagement = lib.mkEnableOption "电源管理";
      encryption = lib.mkEnableOption "加密支持";
      raid = lib.mkEnableOption "RAID 支持";
      cache = lib.mkEnableOption "缓存优化";
    };
  };

  imports = [
    ./core.nix         # 核心优化
    ./monitoring.nix   # 监控功能
    ./tools.nix        # 管理工具
    ./advanced.nix     # 高级功能
  ];
}
