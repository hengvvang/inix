{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.network.enable {
    environment.systemPackages = with pkgs; [
      clash-verge-rev # 代理工具
    ];
  };
}
