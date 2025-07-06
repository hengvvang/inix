{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # OpenGL 支持
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.graphics.opengl) {
      hardware.opengl = {
        enable = true;
        # driSupport 选项已被移除
        # driSupport = true;
        # driSupport32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
        ];
      };
    })

    # Vulkan 支持
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.graphics.vulkan) {
      hardware.opengl.extraPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
      ];
      
      environment.variables = {
        VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      };
    })

    # CUDA 支持
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.graphics.cuda) {
      environment.systemPackages = with pkgs; [
        cudatoolkit
        nvidia-docker
      ];
      
      # CUDA 环境变量
      environment.variables = {
        CUDA_PATH = "${pkgs.cudatoolkit}";
        EXTRA_LDFLAGS = "-L/run/opengl-driver/lib";
        EXTRA_CCFLAGS = "-I/run/opengl-driver/include";
      };
      
      # 启用 NVIDIA Docker 支持
      virtualisation.docker.enableNvidia = true;
    })

    # NVENC 编码支持
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.graphics.nvenc) {
      environment.systemPackages = with pkgs; [
        ffmpeg-full
        obs-studio
      ];
      
      # NVENC 相关环境变量
      environment.variables = {
        FFMPEG_NVENC = "1";
      };
    })
  ];
}
