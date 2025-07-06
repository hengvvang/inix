{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.hardware.enable && config.mySystem.services.hardware.printing.enable) {
    # CUPS 打印服务配置
    services.printing = {
      enable = true;
      
      # 启用网络打印机发现
      browsing = true;
      browsedConf = ''
        BrowseDNSSDSubTypes _cups,_print
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All
        BrowseProtocols all
      '';
      
      # 启用自动打印机发现
      listenAddresses = [ "*:631" ];
      allowFrom = [ "all" ];
      defaultShared = true;
      
      # 打印机驱动
      drivers = with pkgs; [
        gutenprint
        gutenprintBin
        hplip
        epson-escpr
        epson-escpr2
        brlaser
        brgenml1lpr
        brgenml1cupswrapper
        cnijfilter2
      ];
    };

    # Avahi 服务（用于网络打印机发现）
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      
      publish = {
        enable = true;
        userServices = true;
      };
    };

    # 扫描仪支持
    hardware.sane = {
      enable = true;
      extraBackends = with pkgs; [
        hplipWithPlugin
        epkowa
        utsushi
      ];
    };

    # 用户组配置
    users.users.hengvvang.extraGroups = [ "lp" "scanner" ];

    # 防火墙配置
    networking.firewall = {
      allowedTCPPorts = [ 631 ];
      allowedUDPPorts = [ 631 5353 ];
    };
  };
}
