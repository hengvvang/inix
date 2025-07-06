{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.usb.enable {
    # USB 设备支持
    services.udisks2.enable = true;
    services.devmon.enable = true;
    services.gvfs.enable = true;
    
    # USB 自动挂载
    services.udev = {
      enable = true;
      extraRules = ''
        # USB 设备自动挂载规则
        SUBSYSTEM=="block", ENV{ID_FS_TYPE}!="", ENV{ID_FS_TYPE}!="swap", ENV{ID_FS_TYPE}!="LVM2_member", ENV{ID_FS_TYPE}!="crypto_LUKS", RUN+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /run/media/%i"
      '';
    };
    
    # USB 工具
    environment.systemPackages = with pkgs; [
      usbutils
      usb-modeswitch
      ntfs3g
      exfat
    ];
  };
}
