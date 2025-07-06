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
    
    # 打印状态脚本
    environment.etc."cups-status.sh" = lib.mkIf cfg.tools.cli {
      text = ''
        #!/bin/sh
        # 打印机状态检查脚本
        lpstat -t
        echo "CUPS 服务状态:"
        systemctl status cups
      '';
      mode = "0755";
    };
    
    # 维护脚本
    environment.etc."printer-maintenance.sh" = lib.mkIf cfg.tools.maintenance {
      text = ''
        #!/bin/sh
        # 打印机维护脚本
        echo "清理打印队列..."
        cancel -a
        echo "重启 CUPS 服务..."
        systemctl restart cups
        echo "检查打印机状态..."
        lpstat -p
      '';
      mode = "0755";
    };
  };
}
