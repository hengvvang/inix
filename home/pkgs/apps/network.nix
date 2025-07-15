{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.network.enable {
    home.packages = with pkgs; [
      yazi               # 文件管理器
      clash-verge-rev    # 代理工具（主要）
      clash-nyanpasu     # 代理工具（备用）
      clash-meta         # Clash 内核
    ];
  };
}
