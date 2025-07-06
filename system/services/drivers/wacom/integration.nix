{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wacom;
in
{
  config = lib.mkIf cfg.enable {
    # Krita 绘画软件集成
    environment.systemPackages = lib.optionals cfg.integration.krita (with pkgs; [
      krita
    ]);
    
    # GIMP 图像编辑集成
    environment.systemPackages = lib.optionals cfg.integration.gimp (with pkgs; [
      gimp
      gimpPlugins.gmic
    ]);
    
    # Blender 3D 建模集成
    environment.systemPackages = lib.optionals cfg.integration.blender (with pkgs; [
      blender
    ]);
    
    # Inkscape 矢量图形集成
    environment.systemPackages = lib.optionals cfg.integration.inkscape (with pkgs; [
      inkscape
    ]);
    
    # 应用程序配置
    environment.etc = lib.mkMerge [
      (lib.mkIf cfg.integration.krita {
        "krita-wacom.conf" = {
          text = ''
            # Krita Wacom 配置
            [Wacom]
            PressureCurve=0,0,100,100
            TabletMode=Absolute
          '';
          mode = "0644";
        };
      })
      
      (lib.mkIf cfg.integration.gimp {
        "gimp-wacom.conf" = {
          text = ''
            # GIMP Wacom 配置
            (tool-options "GimpPaintbrushTool"
              (pressure-size 0.5)
              (pressure-opacity 0.8))
          '';
          mode = "0644";
        };
      })
    ];
    
    # 环境变量设置
    environment.variables = lib.mkMerge [
      (lib.mkIf cfg.integration.krita {
        KRITA_WACOM_ENABLED = "1";
      })
      
      (lib.mkIf cfg.integration.blender {
        BLENDER_WACOM_SUPPORT = "1";
      })
    ];
  };
}
