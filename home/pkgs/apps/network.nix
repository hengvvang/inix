{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.network.enable {
    home.packages = with pkgs; [
      yazi            # 文件管理器
      clash-verge-rev # 代理工具
    ];
  };
}
