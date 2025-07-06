{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.nvidia.enable {
    # Coolbits 设置 (超频支持)
    hardware.nvidia.forceFullCompositionPipeline = lib.mkIf (config.mySystem.services.drivers.nvidia.performance.coolbits != null) true;
    
    # X11 配置增强
    services.xserver.deviceSection = lib.mkIf (config.mySystem.services.drivers.nvidia.performance.coolbits != null) ''
      Option "Coolbits" "${toString config.mySystem.services.drivers.nvidia.performance.coolbits}"
    '';

    # 功耗限制脚本
    systemd.services.nvidia-power-limit = lib.mkIf (config.mySystem.services.drivers.nvidia.performance.powerLimit != null) {
      description = "Set NVIDIA Power Limit";
      wantedBy = [ "multi-user.target" ];
      after = [ "nvidia-persistenced.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeScript "nvidia-power-limit" ''
          #!${pkgs.bash}/bin/bash
          ${config.hardware.nvidia.package}/bin/nvidia-smi -pl ${toString config.mySystem.services.drivers.nvidia.performance.powerLimit}
        ''}";
      };
    };

    # 性能调优工具
    environment.systemPackages = lib.optionals (config.mySystem.services.drivers.nvidia.performance.coolbits != null || config.mySystem.services.drivers.nvidia.performance.powerLimit != null) (with pkgs; [
      nvtop
      gpu-burn  # GPU 压力测试
    ]);
  };
}
