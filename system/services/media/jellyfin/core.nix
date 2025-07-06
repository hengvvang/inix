{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.media.jellyfin.enable {
    # Jellyfin 媒体服务器配置
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      
      # 用户和组配置
      user = "jellyfin";
      group = "jellyfin";
    };

    # 添加用户到 video 组以访问硬件加速
    users.users.jellyfin.extraGroups = [ "video" "render" ];

    # 确保媒体目录存在
    systemd.tmpfiles.rules = [
      "d /var/lib/jellyfin 0755 jellyfin jellyfin -"
      "d /var/cache/jellyfin 0755 jellyfin jellyfin -"
      "d /var/log/jellyfin 0755 jellyfin jellyfin -"
    ];

    # 环境包（包含 FFmpeg 等工具）
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
