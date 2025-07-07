{ config, lib, pkgs, ... }:

{
  # AMD 显卡驱动配置选项
  options.mySystem.services.drivers.amd = {
    enable = lib.mkEnableOption "AMD 显卡驱动支持";
    
    # 图形加速选项
    graphics = {
      vulkan = lib.mkEnableOption "Vulkan API 支持" // { default = true; };
      opencl = lib.mkEnableOption "OpenCL 计算支持";
    };
    
    # 媒体编解码器选项
    codecs = {
      vaapi = lib.mkEnableOption "VA-API 视频加速" // { default = true; };
      vdpau = lib.mkEnableOption "VDPAU 视频加速";
    };
    
    # 高级功能选项
    advanced = {
      rocm = lib.mkEnableOption "ROCm 计算平台支持";
      overclocking = lib.mkEnableOption "超频工具支持";
      fanControl = lib.mkEnableOption "风扇控制支持";
    };
  };

  imports = [
    ./amd.nix
    ./advanced.nix    # 高级功能：ROCm、超频、风扇控制
  ];

}
