{ config, lib, pkgs, ... }:

{
  imports = [
    ./nvidia.nix    # NVIDIA 驱动核心配置
    ./performance.nix    # 性能调优和超频功能
  ];

  # NVIDIA 显卡驱动配置选项
  options.mySystem.services.drivers.nvidia = {
    enable = lib.mkEnableOption "NVIDIA 显卡驱动支持";

    # 驱动类型选项
    driver = {
      openSource = lib.mkEnableOption "使用开源驱动 (nouveau)" // { default = false; };
      package = lib.mkOption {
        type = lib.types.enum [ "stable" "beta" "production" ];
        default = "stable";
        description = "NVIDIA 驱动版本选择";
      };
    };

    # 图形功能选项
    graphics = {
      vulkan = lib.mkEnableOption "Vulkan API 支持" // { default = true; };
      cuda = lib.mkEnableOption "CUDA 计算支持" // { default = false; };
      nvenc = lib.mkEnableOption "NVENC 视频编码" // { default = false; };
    };

    # 电源管理选项
    power = {
      enable = lib.mkEnableOption "电源管理优化" // { default = true; };
      finegrained = lib.mkEnableOption "细粒度电源控制" // { default = false; };
      suspend = lib.mkEnableOption "挂起/唤醒支持" // { default = true; };
    };

    # 工具和管理选项
    tools = {
      settings = lib.mkEnableOption "NVIDIA 设置面板" // { default = true; };
      monitoring = lib.mkEnableOption "性能监控工具" // { default = false; };
      overclocking = lib.mkEnableOption "超频工具支持" // { default = false; };
    };
  };
}
