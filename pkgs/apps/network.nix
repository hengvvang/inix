{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.network.enable {
    environment.systemPackages = with pkgs; [
      wget            # 文件下载工具
      htop            # 系统监控
      yazi            # 文件管理器
      clash-verge-rev # 代理工具
    ];
  };
}
