{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # Mako 通知守护进程配置
    # macOS Tahoe 风格的通知系统
    services.mako = {
      enable = true;

      # 主题选择（可选配置）：
      # - ./config (macOS Tahoe 深色主题，默认)
      # - ./config-light (macOS Tahoe 浅色主题)

      # 当前使用：深色主题
      configFile = ./config;

      # 可选：直接使用浅色主题
      # configFile = ./config-light;
    };

    # 确保安装必需的字体和图标
    # 注意：这些通常在系统级别配置，这里添加注释提醒
    # fonts.packages = with pkgs; [ lxgw-wenkai ];
    # environment.systemPackages = with pkgs; [ papirus-icon-theme ];

    # 主题切换脚本（可选）
    home.file.".local/bin/mako-theme-switcher" = {
      source = ./theme-switcher.sh;
      executable = true;
    };

    # 实用的 mako 控制脚本
    home.file.".local/bin/mako-control" = {
      text = ''
        #!/bin/bash
        # Mako 控制脚本

        case "$1" in
          "show")
            makoctl list | jq -r '.[] | "[\(.urgency)] \(.appName): \(.summary)"'
            ;;
          "clear")
            makoctl dismiss -a
            echo "所有通知已清除"
            ;;
          "toggle")
            if pgrep -x mako > /dev/null; then
              pkill mako
              echo "Mako 已停止"
            else
              mako &
              echo "Mako 已启动"
            fi
            ;;
          "test")
            notify-send "测试通知" "这是一个 macOS Tahoe 风格的测试通知"
            ;;
          *)
            echo "用法: $0 {show|clear|toggle|test}"
            echo "  show  - 显示当前通知"
            echo "  clear - 清除所有通知"
            echo "  toggle - 切换 mako 运行状态"
            echo "  test  - 发送测试通知"
            ;;
        esac
      '';
      executable = true;
    };

    # 可选：为不同应用设置通知优先级的脚本
    home.file.".local/bin/smart-notify" = {
      text = ''
        #!/bin/bash
        # 智能通知脚本 - 根据内容自动设置优先级

        app_name="$1"
        summary="$2"
        body="$3"
        urgency="normal"

        # 根据关键词自动判断优先级
        if [[ "$summary" =~ [Ee]rror|[Ff]ailed|[Cc]ritical ]]; then
          urgency="critical"
        elif [[ "$summary" =~ [Ss]uccess|[Cc]omplete|[Dd]one ]]; then
          urgency="low"
        fi

        # 发送通知
        notify-send -u "$urgency" -a "$app_name" "$summary" "$body"
      '';
      executable = true;
    };

  };
}
