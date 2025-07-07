{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # NVIDIA 设置面板
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.tools.settings) {
      # NVIDIA 设置工具通过驱动包提供
      hardware.nvidia.nvidiaSettings = true;
    })

    # NVIDIA 系统管理接口
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.tools.smi) {
      environment.systemPackages = with pkgs; [
        # nvtop 可能不可用，使用其他监控工具
        # nvidia-ml-py 可能不可用
      ];
    })

    # NVIDIA 持久化守护进程
    (lib.mkIf (config.mySystem.services.drivers.nvidia.enable && config.mySystem.services.drivers.nvidia.tools.persistenced) {
      systemd.services.nvidia-persistenced = {
        description = "NVIDIA Persistence Daemon";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "forking";
          ExecStart = "${config.hardware.nvidia.package}/bin/nvidia-persistenced --verbose";
          ExecStopPost = "${pkgs.coreutils}/bin/rm -rf /var/run/nvidia-persistenced";
        };
      };
    })
  ];
}
