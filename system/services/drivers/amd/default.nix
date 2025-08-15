{ config, lib, pkgs, ... }:

{
  imports = [
    ./amdgpu.nix      # AMD 显卡驱动
    ./amdcpu.nix      # AMD CPU 驱动
  ];

  # AMD 硬件驱动配置选项
  options.mySystem.services.drivers.amd = {
    enable = lib.mkEnableOption "AMD 硬件驱动支持";

    # GPU 显卡选项
    gpu = {
      enable = lib.mkEnableOption "AMD GPU (AMDGPU) 驱动" // { default = true; };

      # 图形功能选项
      graphics = {
        vulkan = lib.mkEnableOption "Vulkan API 支持" // { default = true; };
        opencl = lib.mkEnableOption "OpenCL 计算支持" // { default = false; };
        rocm = lib.mkEnableOption "ROCm 计算平台" // { default = false; };
      };

      # 视频编解码选项
      codecs = {
        vaapi = lib.mkEnableOption "VA-API 视频加速" // { default = true; };
        vdpau = lib.mkEnableOption "VDPAU 视频加速" // { default = false; };
        amf = lib.mkEnableOption "AMD AMF 硬件编码" // { default = false; };
      };

      # 高级功能选项
      advanced = {
        overclocking = lib.mkEnableOption "超频功能支持" // { default = false; };
        fanControl = lib.mkEnableOption "风扇控制支持" // { default = false; };
        powerManagement = lib.mkEnableOption "电源管理优化" // { default = true; };
      };
    };

    # CPU 处理器选项
    cpu = {
      enable = lib.mkEnableOption "AMD CPU 驱动和优化" // { default = true; };

      # 性能选项
      performance = {
        governor = lib.mkOption {
          type = lib.types.enum [ "performance" "powersave" "ondemand" "conservative" "schedutil" ];
          default = "schedutil";
          description = "CPU 频率调节器";
        };
        turbo = lib.mkEnableOption "AMD Turbo Boost" // { default = true; };
      };

      # 电源管理选项
      power = {
        enable = lib.mkEnableOption "AMD CPU 电源管理" // { default = true; };
        cStates = lib.mkEnableOption "C-States 深度睡眠" // { default = true; };
        pStates = lib.mkEnableOption "P-States 频率调节" // { default = true; };
      };

      # 微代码更新选项
      microcode = {
        enable = lib.mkEnableOption "AMD CPU 微代码更新" // { default = true; };
        early = lib.mkEnableOption "早期微代码加载" // { default = true; };
      };
    };
  };
}
