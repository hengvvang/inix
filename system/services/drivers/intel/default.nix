{ config, lib, pkgs, ... }:

{
  imports = [
    ./intel.nix
    ./power.nix       # 电源管理功能
  ];
  # Intel 显卡驱动配置选项
  options.mySystem.services.drivers.intel = {
    enable = lib.mkEnableOption "Intel 显卡驱动支持";

    # 驱动类型选择
    driver = lib.mkOption {
      type = lib.types.enum [ "modesetting" "intel" ];
      default = "modesetting";
      description = "Intel 驱动类型 (推荐使用 modesetting)";
    };

    # 图形功能选项
    graphics = {
      vulkan = lib.mkEnableOption "Vulkan API 支持" // { default = true; };
      compute = lib.mkEnableOption "Intel 计算支持 (OpenCL)" // { default = false; };
    };

    # 视频编解码选项
    codecs = {
      vaapi = lib.mkEnableOption "VA-API 视频加速" // { default = true; };
      quicksync = lib.mkEnableOption "Intel Quick Sync 视频编码" // { default = true; };
      hevc = lib.mkEnableOption "HEVC/H.265 支持" // { default = false; };
      av1 = lib.mkEnableOption "AV1 编解码支持" // { default = false; };
    };

    # 电源管理选项
    power = {
      enable = lib.mkEnableOption "Intel GPU 电源管理" // { default = true; };
      turbo = lib.mkEnableOption "Intel GPU Turbo Boost" // { default = false; };
    };
  };
}
