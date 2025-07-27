{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "direct") {
    
    home.packages = with pkgs; [ rofi ];

    # 直接配置文件写入方式 - 简单象征性配置
    home.file.".config/rofi/config.rasi".text = ''
      /*
       * Rofi 应用启动器配置 - 直接文件写入方式
       * 简单象征性配置，保持基本功能
       */

      configuration {
        // 基础设置
        modi: "drun,run,window,ssh";
        font: "FiraCode Nerd Font 12";
        show-icons: true;
        icon-theme: "Papirus";
        
        // 显示配置  
        display-drun: " 应用";
        display-run: " 运行";
        display-window: " 窗口";
        display-ssh: " SSH";
        
        // 行为设置
        case-sensitive: false;
        cycle: true;
        sort: true;
        matching: "fuzzy";
        
        // 窗口设置
        location: 0;
        width: 600;
        lines: 8;
        columns: 1;
        
        // 键盘绑定
        kb-row-up: "Up,Control+k";
        kb-row-down: "Down,Control+j";
        kb-accept-entry: "Return";
        kb-remove-to-eol: "Control+k";
        kb-remove-word-back: "Control+w";
      }

      // 简单主题配置
      * {
        background-color: #1d2021;
        foreground-color: #d4be98;
        border-color: #a89984;
        text-color: #d4be98;
        
        font: "FiraCode Nerd Font 12";
        border-radius: 8px;
      }

      window {
        background-color: #1d2021e6;
        border: 2px solid;
        border-color: #a89984;
        border-radius: 12px;
        padding: 16px;
        width: 600px;
      }

      inputbar {
        background-color: #32302f;
        border: 1px solid #504945;
        border-radius: 6px;
        padding: 8px 12px;
        spacing: 8px;
        children: [ prompt, entry ];
      }

      prompt {
        text-color: #83a598;
      }

      entry {
        text-color: #d4be98;
        placeholder: "搜索...";
        placeholder-color: #928374;
      }

      listview {
        lines: 8;
        scrollbar: true;
        spacing: 4px;
        padding: 8px 0px;
      }

      element {
        padding: 8px 12px;
        border-radius: 4px;
        spacing: 8px;
      }

      element selected {
        background-color: #458588;
        text-color: #fbf1c7;
      }

      element-icon {
        size: 24px;
      }
    '';

    # Shell 别名
    home.file.".local/bin/rofi-launcher".text = ''
      #!/usr/bin/env bash
      # Rofi 启动器脚本
      
      case "$1" in
        apps|drun)
          rofi -show drun
          ;;
        run)
          rofi -show run
          ;;
        window)
          rofi -show window
          ;;
        ssh)
          rofi -show ssh
          ;;
        *)
          echo "用法: $0 {apps|run|window|ssh}"
          echo "  apps   - 应用程序启动器"
          echo "  run    - 运行命令"
          echo "  window - 窗口切换器"
          echo "  ssh    - SSH连接"
          exit 1
          ;;
      esac
    '';

    home.file.".local/bin/rofi-launcher" = {
      executable = true;
    };
  };
}
