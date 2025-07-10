{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.network.enable {
    environment.systemPackages = with pkgs; [
      yazi            # 文件管理器
      clash-verge-rev # 代理工具
    ];
  };
}
