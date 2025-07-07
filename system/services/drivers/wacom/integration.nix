{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wacom;
in
{
  # Wacom 创意应用集成实现
  config = lib.mkIf (cfg.enable && cfg.integration.enable) {
    # 创意软件包
    environment.systemPackages = with pkgs; []
      ++ lib.optionals cfg.integration.painting [
        # 绘画软件
        krita           # 专业绘画软件
        gimp            # 图像编辑
        gimpPlugins.gmic  # GIMP 增强插件
        inkscape        # 矢量图形
        mypaint         # 自然绘画
      ]
      ++ lib.optionals cfg.integration.modeling [
        # 3D建模软件
        blender         # 3D建模渲染
      ];
    
    # 绘画软件优化配置
    environment.etc = lib.mkIf cfg.integration.painting {
      # Krita Wacom 预设配置
      "xdg/kritarc".text = ''
        [General]
        wacomPressureCurve=0,0,1,1
        wacomTabletSupport=true
      '';
    };
    
    # Blender Wacom 支持
    environment.sessionVariables = lib.mkIf cfg.integration.modeling {
      BLENDER_WACOM = "1";
    };
    
    # 输入设备优化
    services.xserver.libinput = lib.mkIf cfg.integration.enable {
      enable = true;
      touchpad.disableWhileTyping = true;
    };
  };
}
