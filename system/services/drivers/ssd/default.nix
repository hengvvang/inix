{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.ssd.enable {
    # SSD 优化
    services.fstrim.enable = true;
    
    # SSD 专用文件系统优化
    fileSystems = {
      "/" = {
        options = [ "noatime" "compress=zstd" "ssd" ];
      };
    };
    
    # 内核参数优化
    boot.kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
    };
    
    # SSD 工具
    environment.systemPackages = with pkgs; [
      smartmontools
      nvme-cli
      hdparm
    ];
  };
}
