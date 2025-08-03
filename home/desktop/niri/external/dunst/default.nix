{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # Dunst 通知守护进程配置
    # macOS Tahoe 风格的通知系统
    services.dunst = {
      enable = true;
      package = pkgs.dunst;
    };

    # 使用外部配置文件
    # 主题选择（可选配置）：
    # - ./config (macOS Tahoe 深色主题，默认)
    # - ./config-light (macOS Tahoe 浅色主题)

    # 当前使用：深色主题
    xdg.configFile."dunst/dunstrc".source = ./config;

    # 可选：直接使用浅色主题
    # xdg.configFile."dunst/dunstrc".source = ./config-light;

    # 确保安装必需的字体和图标
    # 注意：这些通常在系统级别配置，这里添加注释提醒
    # fonts.packages = with pkgs; [ lxgw-wenkai ];
    # environment.systemPackages = with pkgs; [ papirus-icon-theme ];

    # 主题切换脚本（使用外部脚本文件）
    home.file.".local/bin/dunst-theme-switcher" = {
      source = ./theme-switcher.sh;
      executable = true;
    };

    # Dunst 控制脚本
    home.file.".local/bin/dunst-control" = {
      text = ''
        #!/bin/bash
        # Dunst 控制脚本

        case "$1" in
          "show")
            ${pkgs.dunst}/bin/dunstctl history | ${pkgs.jq}/bin/jq -r '.data[][]? | "[\(.urgency.data)] \(.appname.data): \(.summary.data)"' 2>/dev/null || \
            ${pkgs.dunst}/bin/dunstctl history
            ;;
          "clear")
            ${pkgs.dunst}/bin/dunstctl close-all
            echo "所有通知已清除"
            ;;
          "pop")
            ${pkgs.dunst}/bin/dunstctl history-pop
            echo "弹出历史通知"
            ;;
          "close")
            ${pkgs.dunst}/bin/dunstctl close
            echo "关闭当前通知"
            ;;
          "toggle")
            if pgrep -x dunst > /dev/null; then
              pkill dunst
              echo "Dunst 已停止"
            else
              ${pkgs.dunst}/bin/dunst &
              echo "Dunst 已启动"
            fi
            ;;
          "reload")
            ${pkgs.dunst}/bin/dunstctl reload
            echo "Dunst 配置已重新加载"
            ;;
          "test")
            ${pkgs.libnotify}/bin/notify-send "测试通知" "这是一个 macOS Tahoe 风格的测试通知" || \
            dbus-send --session --dest=org.freedesktop.Notifications --type=method_call \
              /org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
              string:"Test" uint32:0 string:"" string:"测试通知" \
              string:"这是一个 macOS Tahoe 风格的测试通知" array:string:"" dict:string:string:"" int32:5000
            ;;
          "test-urgent")
            ${pkgs.libnotify}/bin/notify-send -u critical "紧急通知" "这是一个紧急测试通知"
            ;;
          "test-low")
            ${pkgs.libnotify}/bin/notify-send -u low "低优先级通知" "这是一个低优先级测试通知"
            ;;
          *)
            echo "用法: $0 {show|clear|pop|close|toggle|reload|test|test-urgent|test-low}"
            echo "  show       - 显示通知历史"
            echo "  clear      - 清除所有通知"
            echo "  pop        - 弹出历史通知"
            echo "  close      - 关闭当前通知"
            echo "  toggle     - 切换 dunst 运行状态"
            echo "  reload     - 重新加载配置"
            echo "  test       - 发送测试通知"
            echo "  test-urgent - 发送紧急测试通知"
            echo "  test-low   - 发送低优先级测试通知"
            ;;
        esac
      '';
      executable = true;
    };

    # 智能通知脚本 - 根据内容自动设置优先级
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
        elif [[ "$summary" =~ [Ww]arning ]]; then
          urgency="normal"
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

    # 音量/亮度通知脚本
    home.file.".local/bin/volume-notify" = {
      text = ''
        #!/bin/bash
        # 音量/亮度变化通知脚本

        case "$1" in
          "volume")
            volume=$(${pkgs.pamixer}/bin/pamixer --get-volume)
            muted=$(${pkgs.pamixer}/bin/pamixer --get-mute)

            if [ "$muted" = "true" ]; then
              icon="audio-volume-muted"
              text="音量已静音"
            else
              if [ "$volume" -ge 70 ]; then
                icon="audio-volume-high"
              elif [ "$volume" -ge 30 ]; then
                icon="audio-volume-medium"
              else
                icon="audio-volume-low"
              fi
              text="音量: $volume%"
            fi

            ${pkgs.libnotify}/bin/notify-send -i "$icon" -h int:value:"$volume" -h string:synchronous:volume "音量" "$text"
            ;;
          "brightness")
            brightness=$(${pkgs.brightnessctl}/bin/brightnessctl get)
            max_brightness=$(${pkgs.brightnessctl}/bin/brightnessctl max)
            percentage=$((brightness * 100 / max_brightness))

            ${pkgs.libnotify}/bin/notify-send -i "brightness" -h int:value:"$percentage" -h string:synchronous:brightness "亮度" "亮度: $percentage%"
            ;;
          *)
            echo "用法: $0 {volume|brightness}"
            ;;
        esac
      '';
      executable = true;
    };

    # 媒体播放通知脚本
    home.file.".local/bin/media-notify" = {
      text = ''
        #!/bin/bash
        # 媒体播放通知脚本

        # 获取当前播放状态
        status=$(${pkgs.playerctl}/bin/playerctl status 2>/dev/null || echo "No player")

        if [ "$status" != "No player" ]; then
          title=$(${pkgs.playerctl}/bin/playerctl metadata title 2>/dev/null || echo "未知标题")
          artist=$(${pkgs.playerctl}/bin/playerctl metadata artist 2>/dev/null || echo "未知艺术家")

          case "$status" in
            "Playing")
              icon="media-playback-start"
              action="正在播放"
              ;;
            "Paused")
              icon="media-playback-pause"
              action="已暂停"
              ;;
            "Stopped")
              icon="media-playback-stop"
              action="已停止"
              ;;
            *)
              icon="media-player"
              action="$status"
              ;;
          esac

          ${pkgs.libnotify}/bin/notify-send -i "$icon" -a "媒体播放器" "$action" "$title\n$artist" -h string:synchronous:media
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

    # 电池状态通知脚本
    home.file.".local/bin/battery-notify" = {
      text = ''
        #!/bin/bash
        # 电池状态通知脚本

        # 检查是否有电池
        if [ ! -d /sys/class/power_supply/BAT* ]; then
          exit 0
        fi

        for battery in /sys/class/power_supply/BAT*; do
          if [ -f "$battery/capacity" ] && [ -f "$battery/status" ]; then
            capacity=$(cat "$battery/capacity")
            status=$(cat "$battery/status")

            case "$status" in
              "Charging")
                if [ "$capacity" -ge 95 ]; then
                  icon="battery-full-charging"
                  ${pkgs.libnotify}/bin/notify-send -i "$icon" -u low "电池" "电池接近充满: $capacity%"
                fi
                ;;
              "Discharging")
                if [ "$capacity" -le 20 ]; then
                  icon="battery-caution"
                  urgency="critical"
                  ${pkgs.libnotify}/bin/notify-send -i "$icon" -u "$urgency" "电池警告" "电池电量低: $capacity%"
                elif [ "$capacity" -le 10 ]; then
                  icon="battery-empty"
                  urgency="critical"
                  ${pkgs.libnotify}/bin/notify-send -i "$icon" -u "$urgency" "电池严重不足" "电池电量极低: $capacity%\n请立即充电！"
                fi
                ;;
            esac
          fi
        done
      '';
      executable = true;
    };

    # 网络状态通知脚本
    home.file.".local/bin/network-notify" = {
      text = ''
        #!/bin/bash
        # 网络状态通知脚本

        # 检查网络连接状态
        if ${pkgs.iputils}/bin/ping -c 1 8.8.8.8 >/dev/null 2>&1; then
          # 获取连接信息
          interface=$(${pkgs.iproute2}/bin/ip route | grep default | awk '{print $5}' | head -n1)
          ip=$(${pkgs.iproute2}/bin/ip addr show "$interface" | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

          if [[ "$interface" == wl* ]]; then
            # WiFi 连接
            ssid=$(${pkgs.iw}/bin/iw dev "$interface" link | grep SSID | cut -d: -f2 | sed 's/^ *//')
            ${pkgs.libnotify}/bin/notify-send -i "network-wireless" "WiFi 已连接" "网络: $ssid\nIP: $ip"
          else
            # 有线连接
            ${pkgs.libnotify}/bin/notify-send -i "network-wired" "网络已连接" "接口: $interface\nIP: $ip"
          fi
        else
          ${pkgs.libnotify}/bin/notify-send -i "network-offline" -u critical "网络断开" "无法连接到互联网"
        fi
      '';
      executable = true;
    };

  };
}
