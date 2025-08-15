{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.amd;
in
{
  # AMD GPU 驱动基础实现
  config = lib.mkIf (cfg.enable && cfg.gpu.enable) {
    # === 核心驱动配置 ===
    services.xserver.videoDrivers = [ "amdgpu" ];

    # 内核模块配置
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "amdgpu" ];

    # 内核参数优化
    boot.kernelParams = [
      # 启用 GPU 调度器
      "amdgpu.gpu_recovery=1"
      "amdgpu.deep_color=1"
      # 禁用 GPU 重试机制 (提升稳定性)
      "amdgpu.noretry=1"
    ] ++ lib.optionals cfg.gpu.advanced.overclocking [
      # 超频支持 (完整功能掩码)
      "amdgpu.ppfeaturemask=0xffffffff"
    ];

    # === 图形硬件支持 ===
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      # GPU 驱动包
      extraPackages = with pkgs; [
        # 基础 Mesa 驱动
        mesa.drivers
        libGL
        libdrm

        # AMD 专用驱动
        amdvlk        # AMD Vulkan 驱动
      ] ++ lib.optionals cfg.gpu.graphics.vulkan [
        # Vulkan 支持包
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
      ] ++ lib.optionals cfg.gpu.graphics.opencl [
        # OpenCL 计算支持
        rocm-opencl-icd
        rocm-opencl-runtime
        clinfo
      ] ++ lib.optionals cfg.gpu.graphics.rocm [
        # ROCm 计算平台
        rocm-runtime
        rocm-device-libs
        rocm-cmake
        rocminfo
        radeontop
      ] ++ lib.optionals cfg.gpu.codecs.vaapi [
        # VA-API 视频编解码
        libva
        libva-utils
        vainfo
      ] ++ lib.optionals cfg.gpu.codecs.vdpau [
        # VDPAU 视频编解码
        vdpauinfo
        libvdpau-va-gl
      ];

      # 32位驱动支持
      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa.drivers
        libGL
        libdrm
      ] ++ lib.optionals cfg.gpu.graphics.vulkan [
        amdvlk
        vulkan-loader
      ] ++ lib.optionals cfg.gpu.codecs.vaapi [
        libva
      ];
    };

    # === 系统工具包 ===
    environment.systemPackages = with pkgs; [
      # GPU 监控工具
      amdgpu_top          # AMD GPU 实时监控
      radeontop           # Radeon GPU 监控

      # 图形信息工具
      glxinfo             # OpenGL 信息
      lshw                # 硬件信息
    ] ++ lib.optionals cfg.gpu.graphics.vulkan [
      vulkan-tools        # Vulkan 工具集
      vulkan-caps-viewer  # Vulkan 能力查看器
    ] ++ lib.optionals cfg.gpu.graphics.opencl [
      clinfo              # OpenCL 信息
    ] ++ lib.optionals cfg.gpu.graphics.rocm [
      rocminfo            # ROCm 系统信息
      rocm-smi            # ROCm 系统管理
    ] ++ lib.optionals cfg.gpu.codecs.vaapi [
      vainfo              # VA-API 信息
      libva-utils         # VA-API 工具
    ] ++ lib.optionals cfg.gpu.advanced.overclocking [
      corectrl            # AMD GPU 控制面板
    ];

    # === 环境变量配置 ===
    environment.variables = {
      # AMD GPU 环境变量
      AMD_VULKAN_ICD = "RADV";
      # 禁用 AMDVLK 作为默认 Vulkan 驱动
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    } // lib.optionalAttrs cfg.gpu.codecs.vaapi {
      # VA-API 驱动配置
      LIBVA_DRIVER_NAME = "radeonsi";
    } // lib.optionalAttrs cfg.gpu.codecs.vdpau {
      # VDPAU 驱动配置
      VDPAU_DRIVER = "radeonsi";
    } // lib.optionalAttrs cfg.gpu.graphics.rocm {
      # ROCm 环境配置
      ROCM_PATH = "${pkgs.rocm-runtime}";
      HIP_PATH = "${pkgs.rocm-runtime}";
    };

    # === 设备权限配置 ===
    services.udev.extraRules = ''
      # AMD GPU 基础设备权限
      SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{vendor}=="0x1002", GROUP="video", MODE="0664"
      SUBSYSTEM=="drm", KERNEL=="renderD*", ATTRS{vendor}=="0x1002", GROUP="video", MODE="0664"

      # AMD GPU 媒体设备权限
      SUBSYSTEM=="drm", KERNEL=="card*", ATTR{vendor}=="0x1002", GROUP="video", MODE="0664"
    '' + lib.optionalString cfg.gpu.advanced.fanControl ''
      # AMD GPU 风扇控制权限
      SUBSYSTEM=="hwmon", KERNEL=="hwmon*", ATTR{name}=="amdgpu", GROUP="video", MODE="0664"
      KERNEL=="card*", SUBSYSTEM=="drm", ATTRS{vendor}=="0x1002", TAG+="uaccess"
    '' + lib.optionalString cfg.gpu.advanced.overclocking ''
      # AMD GPU 超频权限
      SUBSYSTEM=="hwmon", KERNEL=="hwmon*", GROUP="video", MODE="0664"
      SUBSYSTEM=="drm", KERNEL=="card*", GROUP="video", MODE="0664"
    '';

    # === GPU 电源管理服务 ===
    systemd.services.amd-gpu-power-management = lib.mkIf cfg.gpu.advanced.powerManagement {
      description = "AMD GPU 电源管理优化";
      wantedBy = [ "multi-user.target" ];
      after = [ "graphical.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '''
          # 启用 GPU 运行时电源管理
          echo auto > /sys/class/drm/card*/device/power/control || true

          # 设置合理的功耗限制 (如果支持)
          echo 1 > /sys/class/drm/card*/device/power_dpm_force_performance_level || true
        '''";
        RemainAfterExit = true;
      };
    };

    # === ROCm 计算平台服务 ===
    systemd.services.rocm-setup = lib.mkIf cfg.gpu.graphics.rocm {
      description = "ROCm 计算平台设置";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/module/amdgpu/parameters/noretry || true'";
        RemainAfterExit = true;
      };
    };

    # 确保用户在 video 组中 (GPU 访问权限)
    users.groups.video = {};
  };
}
