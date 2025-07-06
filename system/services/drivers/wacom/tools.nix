{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.wacom;
in
{
  config = lib.mkIf cfg.enable {
    # 图形配置工具
    environment.systemPackages = lib.optionals cfg.tools.gui (with pkgs; [
      wacomtablet       # KDE Wacom 配置面板
      gnome.gnome-control-center  # GNOME 控制中心（包含 Wacom 设置）
    ]) ++ lib.optionals cfg.tools.calibration (with pkgs; [
      xinput            # 输入设备校准
      xorg.xinput       # X11 输入配置
    ]) ++ lib.optionals cfg.tools.mapping (with pkgs; [
      xsetwacom         # Wacom 设备映射工具
    ]) ++ lib.optionals cfg.tools.hotkeys (with pkgs; [
      xbindkeys         # 快捷键绑定
      xdotool           # X11 自动化工具
      wmctrl            # 窗口管理器控制
    ]);
    
    # 配置文件模板
    environment.etc = lib.mkIf cfg.tools.calibration {
      "wacom-calibration.conf" = {
        text = ''
          # Wacom 校准配置示例
          # 使用 xinput --list 查看设备
          # 使用 xsetwacom --set "device" Area x1 y1 x2 y2 进行区域映射
        '';
        mode = "0644";
      };
    };
    
    # 自动启动配置工具
    services.xserver.displayManager.sessionCommands = lib.optionalString cfg.tools.gui ''
      # 自动加载 Wacom 配置
      ${pkgs.xsetwacom}/bin/xsetwacom --set "Wacom" Rotate none
    '';
  };
}
