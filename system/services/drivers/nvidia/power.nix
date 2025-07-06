{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.power.enable) {
    # NVIDIA 电源管理配置
    hardware.nvidia.powerManagement = {
      enable = true;
      finegrained = config.mySystem.services.drivers.nvidia.power.finegrained;
    };

    # 挂起/唤醒支持
    hardware.nvidia.powerManagement.enableRuntimePM = config.mySystem.services.drivers.nvidia.power.suspend;

    # 电源管理服务
    systemd.services.nvidia-powerd = lib.mkIf config.mySystem.services.drivers.nvidia.power.enable {
      description = "NVIDIA Power Management Daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "${config.hardware.nvidia.package}/bin/nvidia-powerd";
      };
    };

    # 电源管理相关内核参数
    boot.kernelParams = lib.optionals config.mySystem.services.drivers.nvidia.power.enable [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };
}
