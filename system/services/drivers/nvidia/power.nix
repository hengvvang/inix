{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.power.enable) {
    # NVIDIA 电源管理配置
    hardware.nvidia.powerManagement = {
      enable = true;
      finegrained = config.mySystem.services.drivers.nvidia.power.finegrained;
    };

    # 挂起/唤醒支持 - 使用正确的选项名
    # 注意：enableRuntimePM 选项可能在较新的 NixOS 版本中不可用
    # 如果需要运行时电源管理，请使用其他方式配置

    # 电源管理服务 - 禁用，因为 nvidia-powerd 在当前驱动版本中不可用
    # systemd.services.nvidia-powerd = lib.mkIf config.mySystem.services.drivers.nvidia.power.enable {
    #   description = "NVIDIA Power Management Daemon";
    #   wantedBy = [ "multi-user.target" ];
    #   serviceConfig = {
    #     Type = "forking";
    #     ExecStart = "${config.hardware.nvidia.package}/bin/nvidia-powerd";
    #   };
    # };

    # 电源管理相关内核参数
    boot.kernelParams = lib.optionals config.mySystem.services.drivers.nvidia.power.enable [
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
  };
}
