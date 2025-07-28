{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.containers.appimage;
in
{
  config = lib.mkIf cfg.enable {
    # 启用 AppImage 支持
    programs.appimage = {
      enable = true;
      binfmt = true;  # 启用自动挂载
    };

    # 安装 AppImage 运行工具
    environment.systemPackages = with pkgs; [
      appimage-run
    ];
  };
}