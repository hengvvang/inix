{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.printing.enable {
    # 打印支持 - 从 system/hardware/hardware.nix 迁移
    services.printing.enable = true;
    
    # 打印机发现服务
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # 常用打印机驱动
    services.printing.drivers = with pkgs; [
      gutenprint
      hplip
      canon-cups-ufr2
      cnijfilter2
    ];
  };
}
