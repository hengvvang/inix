{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.printing;
in
{
  config = lib.mkIf cfg.enable {
    # 图形管理工具
    environment.systemPackages = lib.optionals cfg.tools.gui (with pkgs; [
      system-config-printer  # 打印机配置工具
      gnome.gnome-control-center  # GNOME 控制中心
    ]) ++ lib.optionals cfg.tools.cli (with pkgs; [
      cups             # 命令行工具
      ghostscript      # PostScript 处理
    ]) ++ lib.optionals cfg.tools.maintenance (with pkgs; [
      hplip           # HP 维护工具
      cups-filters    # 过滤器工具
    ]);
    
    # CUPS Web 界面配置
    services.printing = lib.mkIf cfg.tools.gui {
      webInterface = true;
    };
  };
}
