{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.amd.enable {
    # AMD 显卡驱动配置
    services.xserver.videoDrivers = [ "amdgpu" ];
    
    # 硬件加速
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    
    # 环境变量
    environment.variables = {
      AMD_VULKAN_ICD = "RADV";
    };
  };
}
