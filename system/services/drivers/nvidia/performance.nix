{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.nvidia;
in
{
  # NVIDIA 性能调优和超频功能实现
  config = lib.mkIf (cfg.enable && !cfg.driver.openSource && cfg.tools.overclocking) {
    # === X11 超频配置 ===
    services.xserver.deviceSection = ''
      # 启用超频功能 (Coolbits)
      Option "Coolbits" "31"
      
      # 性能优化选项
      Option "TripleBuffer" "true"
      Option "UseEvents" "true" 
      Option "AllowIndirectGLXProtocol" "off"
      Option "backingstore" "true"
    '';
    
    # === 强制全合成管道 ===
    hardware.nvidia.forceFullCompositionPipeline = true;
    
    # === 超频和监控工具 ===
    environment.systemPackages = with pkgs; [
      # 性能监控
      nvtop                 # GPU 监控工具
      nvidia-ml-py         # NVIDIA ML Python 绑定
      
      # 超频工具
      gwe                  # Green With Envy (GUI 超频工具)
      
      # 性能测试
      gpu-burn             # GPU 压力测试
      glmark2              # OpenGL 基准测试
      vulkan-tools         # Vulkan 测试工具
    ];
    
    # === GPU 性能优化服务 ===
    systemd.services.nvidia-performance-setup = {
      description = "NVIDIA 性能优化设置";
      wantedBy = [ "multi-user.target" ];
      after = [ "nvidia-persistenced.service" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "nvidia-perf-setup" ''
          # 设置性能模式
          ${config.hardware.nvidia.package}/bin/nvidia-smi -pm 1
          
          # 设置应用时钟频率 (如果支持)
          ${config.hardware.nvidia.package}/bin/nvidia-smi -ac 2000,1000 || true
          
          # 启用持久化模式
          ${config.hardware.nvidia.package}/bin/nvidia-smi -pm 1 || true
        ''}";
        RemainAfterExit = true;
      };
    };
    
    # === 超频权限配置 ===
    services.udev.extraRules = ''
      # NVIDIA 超频设备权限
      SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", GROUP="video", MODE="0664"
      
      # NVIDIA GPU 功耗和频率控制
      KERNEL=="nvidia*", ATTR{power/control}="auto", GROUP="video", MODE="0664"
    '';
    
    # === 超频环境变量 ===
    environment.variables = {
      # 启用 GPU 超频功能
      __GL_ALLOW_UNOFFICIAL_PROTOCOL = "1";
      
      # 启用性能调优
      __GL_SYNC_TO_VBLANK = "0";
    };
    
    # 确保用户在 video 组以进行超频
    users.groups.video = {};
  };
}
