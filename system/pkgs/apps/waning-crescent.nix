# 🌘 残月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.waningCrescent.enable {
    environment.systemPackages = with pkgs; [
      clash-verge-rev    # 代理工具（主要）
      mihomo             # Clash 内核


      # clash-nyanpasu     # 代理工具（备用）
      # webkitgtk_4_1
      # gtk3
      # glib

    ];
  };
}
