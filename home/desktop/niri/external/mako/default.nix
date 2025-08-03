{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # Mako 通知守护进程配置
    # macOS Tahoe 风格的通知系统
    services.mako = {
      enable = true;
      package = pkgs.mako;
    };

    # 使用外部配置文件
    # 主题选择（可选配置）：
    # - ./config (macOS Tahoe 深色主题，默认)
    # - ./config-light (macOS Tahoe 浅色主题)

    # 当前使用：深色主题
    xdg.configFile."mako/config".source = ./config;

    # 可选：直接使用浅色主题
    # xdg.configFile."mako/config".source = ./config-light;

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
            makoctl list | ${pkgs.jq}/bin/jq -r '.[] | "[\(.urgency)] \(.appName): \(.summary)"' 2>/dev/null || makoctl list
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
              ${pkgs.mako}/bin/mako &
              echo "Mako 已启动"
            fi
            ;;
          "test")
            ${pkgs.libnotify}/bin/notify-send "测试通知" "这是一个 macOS Tahoe 风格的测试通知" || \
            dbus-send --session --dest=org.freedesktop.Notifications --type=method_call \
              /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
              string:"Test" uint32:0 string:"" string:"测试通知" \
              string:"这是一个 macOS Tahoe 风格的测试通知" array:string:"" dict:string:string:"" int32:5000
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
        if command -v notify-send >/dev/null 2>&1; then
          ${pkgs.libnotify}/bin/notify-send -u "$urgency" -a "$app_name" "$summary" "$body"
        else
          # 使用 dbus-send 作为后备
          dbus-send --session --dest=org.freedesktop.Notifications --type=method_call \
            /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
            string:"$app_name" uint32:0 string:"" string:"$summary" string:"$body" \
            array:string:"" dict:string:string:"urgency,string:$urgency" int32:5000
        fi
      '';
      executable = true;
    };

    # 简单的 notify-send 替代脚本
    home.file.".local/bin/notify-test" = {
      text = ''
        #!/bin/bash
        # 简单的通知测试脚本

        summary="''${1:-测试通知}"
        body="''${2:-这是一个测试通知}"
        urgency="''${3:-normal}"
        app_name="''${4:-Test}"

        if command -v notify-send >/dev/null 2>&1; then
          ${pkgs.libnotify}/bin/notify-send -u "$urgency" -a "$app_name" "$summary" "$body"
        else
          dbus-send --session --dest=org.freedesktop.Notifications --type=method_call \
            /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
            string:"$app_name" uint32:0 string:"" string:"$summary" string:"$body" \
            array:string:"" dict:string:string:"urgency,string:$urgency" int32:5000
        fi
      '';
      executable = true;
    };

  };
}
