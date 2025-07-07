{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.nvidia;
in
{
  # NVIDIA 驱动基础实现
  config = lib.mkIf cfg.enable {
    # === 核心驱动配置 ===
    services.xserver.videoDrivers = if cfg.driver.openSource then [ "nouveau" ] else [ "nvidia" ];
    
    # NVIDIA 驱动配置 (非开源驱动)
    hardware.nvidia = lib.mkIf (!cfg.driver.openSource) {
      modesetting.enable = true;
      open = false;
      
      # 驱动包选择
      package = config.boot.kernelPackages.nvidiaPackages.${cfg.driver.package};
      
      # 电源管理
      powerManagement = {
        enable = cfg.power.enable;
        finegrained = cfg.power.finegrained;
      };
      
      # 工具集成
      nvidiaSettings = cfg.tools.settings;
      
      # 挂起/唤醒支持
      nvidiaPersistenced = cfg.power.suspend;
    };
    
    # === 内核模块配置 ===
    boot.kernelModules = if cfg.driver.openSource 
      then [ "nouveau" ]
      else [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      
    # === 图形硬件支持 ===
    hardware.graphics = {
      enable = true;
      
      # 图形驱动包
      extraPackages = with pkgs; if cfg.driver.openSource then [
        # Nouveau 开源驱动包
        mesa.drivers
        libGL
      ] else [
        # NVIDIA 专有驱动包
        nvidia-vaapi-driver
      ] ++ lib.optionals cfg.graphics.vulkan [
        # Vulkan 支持
        vulkan-loader
        vulkan-validation-layers
      ];
      
      # 32位驱动支持
      extraPackages32 = with pkgs.pkgsi686Linux; if (!cfg.driver.openSource) then [
        nvidia-vaapi-driver
      ] ++ lib.optionals cfg.graphics.vulkan [
        vulkan-loader
      ] else [];
    };
    
    # === CUDA 计算支持 ===
    nixpkgs.config.cudaSupport = cfg.graphics.cuda;
    
    # === 系统工具包 ===
    environment.systemPackages = with pkgs; []
      ++ lib.optionals cfg.graphics.cuda [
        # CUDA 开发工具
        cudatoolkit
        cudnn
      ]
      ++ lib.optionals (!cfg.driver.openSource && cfg.tools.monitoring) [
        # NVIDIA 监控工具 (检查包是否可用)
        # nvtop  # 可能不可用
        # nvidia-ml-py  # 可能不可用
      ]
      ++ lib.optionals (!cfg.driver.openSource) [
        # 基础工具 (随驱动提供)
        # nvidia-smi, nvidia-settings 等
      ]
      ++ lib.optionals cfg.graphics.vulkan [
        # Vulkan 工具
        vulkan-tools
        vulkan-caps-viewer
      ];
    
    # === 环境变量配置 ===
    environment.variables = if cfg.driver.openSource then {
      # Nouveau 驱动环境变量
      MESA_LOADER_DRIVER_OVERRIDE = "nouveau";
    } else {
      # NVIDIA 专有驱动环境变量
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";  # Wayland 兼容性
    } // lib.optionalAttrs cfg.graphics.cuda {
      CUDA_PATH = "${pkgs.cudatoolkit}";
    } // lib.optionalAttrs cfg.graphics.nvenc {
      NVIDIA_NVENC = "1";
    };
    
    # === 服务配置 ===
    systemd.services.nvidia-persistenced = lib.mkIf (!cfg.driver.openSource && cfg.power.suspend) {
      description = "NVIDIA Persistence Daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "forking";
        Restart = "always";
        PIDFile = "/var/run/nvidia-persistenced/nvidia-persistenced.pid";
        ExecStart = "${config.hardware.nvidia.package.persistenced}/bin/nvidia-persistenced --verbose";
        ExecStopPost = "${pkgs.coreutils}/bin/rm -rf /var/run/nvidia-persistenced";
      };
    };
    
    # === 设备权限配置 ===
    services.udev.extraRules = lib.mkIf (!cfg.driver.openSource) ''
      # NVIDIA 设备权限
      KERNEL=="nvidia", GROUP="video", MODE="0664"
      KERNEL=="nvidia*", GROUP="video", MODE="0664"
      KERNEL=="nvidiactl", GROUP="video", MODE="0664"
      KERNEL=="nvidia-modeset", GROUP="video", MODE="0664"
      KERNEL=="nvidia-uvm", GROUP="video", MODE="0664"
      KERNEL=="nvidia-uvm-tools", GROUP="video", MODE="0664"
    '';
    
    # 确保用户在 video 组中
    users.groups.video = {};
  };
}
