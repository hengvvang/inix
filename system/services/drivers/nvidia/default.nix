{ config, lib, pkgs, ... }:

{
  # NVIDIA 驱动模块的选项定义
  options.mySystem.services.drivers.nvidia = {
    enable = lib.mkEnableOption "NVIDIA 显卡驱动基础支持";
    
    # === 核心驱动选项 ===
    driver = {
      openSource = lib.mkEnableOption "使用开源 NVIDIA 驱动 (nouveau)";
      modesetting = lib.mkEnableOption "NVIDIA modesetting 支持" // { default = true; };
    };
    
    # === 电源管理选项 ===
    power = {
      enable = lib.mkEnableOption "NVIDIA 电源管理";
      finegrained = lib.mkEnableOption "NVIDIA 细粒度电源管理";
      suspend = lib.mkEnableOption "NVIDIA 挂起/唤醒支持";
    };
    
    # === 图形加速选项 ===
    graphics = {
      opengl = lib.mkEnableOption "OpenGL 硬件加速" // { default = true; };
      vulkan = lib.mkEnableOption "Vulkan API 支持";
      cuda = lib.mkEnableOption "CUDA 计算支持";
      nvenc = lib.mkEnableOption "NVENC 视频编码支持";
    };
    
    # === 工具和应用选项 ===
    tools = {
      settings = lib.mkEnableOption "NVIDIA 设置面板 (nvidia-settings)";
      smi = lib.mkEnableOption "NVIDIA 系统管理接口 (nvidia-smi)";
      persistenced = lib.mkEnableOption "NVIDIA 持久化守护进程";
    };
    
    # === 性能调优选项 ===
    performance = {
      coolbits = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "NVIDIA Coolbits 设置 (超频支持)";
      };
      powerLimit = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "NVIDIA 功耗限制 (瓦特)";
      };
    };
  };

  imports = [
    # === 模块化导入：每个功能独立文件 ===
    ./core.nix          # 核心驱动配置
    ./power.nix         # 电源管理
    ./graphics.nix      # 图形加速
    ./tools.nix         # 工具和应用
    ./performance.nix   # 性能调优
  ];
}
