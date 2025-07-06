{ config, lib, pkgs, ... }:

{
  # AMD 编解码器实现
  config = lib.mkMerge [
    # VA-API 视频加速
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.codecs.vaapi) {
      hardware.opengl.extraPackages = with pkgs; [
        libva
        libva-utils
        mesa.drivers
      ];
      
      environment.systemPackages = with pkgs; [
        vainfo        # VA-API 信息工具
        libva-utils   # VA-API 实用工具
      ];
      
      environment.variables = {
        LIBVA_DRIVER_NAME = "radeonsi";
      };
    })
    
    # VDPAU 视频加速
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.codecs.vdpau) {
      hardware.opengl.extraPackages = with pkgs; [
        vdpauinfo
        libvdpau-va-gl
      ];
      
      environment.systemPackages = with pkgs; [
        vdpauinfo     # VDPAU 信息工具
      ];
      
      environment.variables = {
        VDPAU_DRIVER = "radeonsi";
      };
    })
    
    # AMD 媒体框架支持
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.codecs.amf) {
      environment.systemPackages = with pkgs; [
        amf-headers
      ];
      
      # AMF 需要专有驱动支持，这里提供头文件用于编译
      environment.variables = {
        AMF_PATH = "${pkgs.amf-headers}/include";
      };
    })
  ];
}
