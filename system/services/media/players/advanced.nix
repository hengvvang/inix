{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.media.players.enable {
    # 硬件加速支持
    hardware.opengl = lib.mkIf config.mySystem.services.media.players.advanced.hwAccel {
      enable = true;
      # driSupport 选项已被移除
      # driSupport = true;
      # driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };

    # HDR 视频支持
    environment.variables = lib.mkIf config.mySystem.services.media.players.advanced.hdr {
      # HDR 相关环境变量
      GST_VAAPI_ALL_DRIVERS = "1";
    };

    # 字幕支持增强
    environment.systemPackages = lib.optionals config.mySystem.services.media.players.advanced.subtitles (with pkgs; [
      subtitle-editor
      gaupol
      aegisub
    ]);

    # 字体支持 (用于字幕渲染)
    fonts.packages = lib.optionals config.mySystem.services.media.players.advanced.subtitles (with pkgs; [
      source-han-sans
      source-han-serif
      noto-fonts-cjk
    ]);
  };
}
