{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.configStyle == "homeManager") {

    programs.rofi = {
      enable = true;
      package = pkgs.rofi;

      # 字体配置 - 使用 Nerd Font 获得图标支持
      font = "LXGW WenKai";

      # 窗口定位配置
      location = "center";           # 显示位置: "center", "north", "south", "east", "west", "northeast", "northwest", "southeast", "southwest"
      xoffset = 0;                   # X轴偏移量（像素）
      yoffset = 0;                   # Y轴偏移量（像素）

      # 行为配置
      cycle = true;                  # 是否循环浏览结果列表

      # 终端程序配置 - 用于运行控制台应用程序
      terminal = "${pkgs.rio}/bin/rio";

      # 启用的模式 - 定义可用的Rofi模式
      modes = [
        "window"      # 窗口切换器
        "drun"        # 应用程序启动器（桌面条目）
        "run"         # 运行命令
        "ssh"         # SSH连接
        "keys"        # 按键绑定帮助
        "filebrowser" # 文件浏览器
        "combi"       # 组合模式
      ];

      # 插件配置 - 扩展Rofi功能的插件
      plugins = with pkgs; [
        rofi-calc           # 计算器插件
        rofi-emoji          # emoji 选择器
        rofi-systemd        # systemd 服务管理
        rofi-pulse-select   # 音频设备选择
        rofi-bluetooth      # 蓝牙设备管理
        rofi-power-menu     # 电源管理菜单
      ];

      # 主题配置 - 使用属性集方式定义完整主题
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        # 全局样式
        "*" = {
          # 颜色定义
          background-color = mkLiteral "transparent";
          foreground-color = mkLiteral "#d4be98";
          text-color = mkLiteral "#d4be98";

          # 边框和圆角
          border-color = mkLiteral "#a89984";
          border-radius = mkLiteral "8px";

          # 字体和间距
          font = "LXGW WenKai";
          padding = mkLiteral "0px";
          margin = mkLiteral "0px";
        };

        # 主窗口
        "window" = {
          background-color = mkLiteral "#1d2021e6";  # 半透明背景
          border = mkLiteral "2px solid";
          border-color = mkLiteral "#a89984";
          border-radius = mkLiteral "12px";
          padding = mkLiteral "16px";
          width = mkLiteral "600px";
        };

        # 主容器
        "mainbox" = {
          background-color = mkLiteral "transparent";
          spacing = mkLiteral "8px";
          children = map mkLiteral [ "inputbar" "listview" "mode-switcher" ];
        };

        # 输入栏
        "inputbar" = {
          background-color = mkLiteral "#32302f";
          border = mkLiteral "1px solid";
          border-color = mkLiteral "#504945";
          border-radius = mkLiteral "6px";
          padding = mkLiteral "8px 12px";
          spacing = mkLiteral "8px";
          children = map mkLiteral [ "prompt" "entry" ];
        };

        # 提示符
        "prompt" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#83a598";
          font = "LXGW WenKai";
        };

        # 输入框
        "entry" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#d4be98";
          placeholder = "搜索...";
          placeholder-color = mkLiteral "#928374";
          cursor = mkLiteral "#fabd2f";
        };

        # 列表视图
        "listview" = {
          background-color = mkLiteral "transparent";
          lines = 8;                           # 显示行数
          columns = 1;                         # 列数
          cycle = true;                        # 循环浏览
          dynamic = true;                      # 动态调整大小
          scrollbar = true;                    # 显示滚动条
          scrollbar-width = mkLiteral "4px";
          spacing = mkLiteral "4px";
          padding = mkLiteral "8px 0px";
        };

        # 列表项
        "element" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "#d4be98";
          padding = mkLiteral "8px 12px";
          border-radius = mkLiteral "4px";
          spacing = mkLiteral "8px";
          children = map mkLiteral [ "element-icon" "element-text" ];
        };

        # 选中的列表项
        "element selected" = {
          background-color = mkLiteral "#458588";
          text-color = mkLiteral "#fbf1c7";
        };

        # 列表项图标
        "element-icon" = {
          background-color = mkLiteral "transparent";
          size = mkLiteral "24px";
        };

        # 列表项文本
        "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
        };

        # 模式切换器
        "mode-switcher" = {
          background-color = mkLiteral "transparent";
          spacing = mkLiteral "4px";
          padding = mkLiteral "8px 0px 0px 0px";
        };

        # 模式按钮
        "button" = {
          background-color = mkLiteral "#32302f";
          text-color = mkLiteral "#a89984";
          border = mkLiteral "1px solid";
          border-color = mkLiteral "#504945";
          border-radius = mkLiteral "4px";
          padding = mkLiteral "4px 8px";
          font = "FiraCode Nerd Font 10";
        };

        # 选中的模式按钮
        "button selected" = {
          background-color = mkLiteral "#689d6a";
          text-color = mkLiteral "#fbf1c7";
          border-color = mkLiteral "#689d6a";
        };

        # 滚动条
        "scrollbar" = {
          background-color = mkLiteral "#32302f";
          border-radius = mkLiteral "2px";
          handle-color = mkLiteral "#504945";
          handle-width = mkLiteral "4px";
        };

        # 消息框
        "message" = {
          background-color = mkLiteral "#32302f";
          border = mkLiteral "1px solid";
          border-color = mkLiteral "#504945";
          border-radius = mkLiteral "6px";
          padding = mkLiteral "8px";
        };

        # 错误消息
        "error-message" = {
          background-color = mkLiteral "#cc241d";
          text-color = mkLiteral "#fbf1c7";
          border-radius = mkLiteral "6px";
          padding = mkLiteral "8px";
        };
      };

      # 额外配置 - 键盘绑定和行为设置
      extraConfig = {
        # 键盘绑定配置
        # kb-row-up = "Up,Control+k,Control+p";
        # kb-row-down = "Down,Control+j,Control+n";
        # kb-row-left = "Left,Control+h";
        # kb-row-right = "Right,Control+l";
        # kb-accept-entry = "Return,KP_Enter";
        # kb-remove-to-eol = "Control+k";
        # kb-remove-to-sol = "Control+u";
        # kb-remove-word-back = "Control+w";
        # kb-remove-word-forward = "Control+Alt+d";
        # kb-mode-next = "Control+Tab";
        # kb-mode-previous = "Control+ISO_Left_Tab";
        # kb-toggle-case-sensitivity = "grave,dead_grave";
        # kb-delete-entry = "Delete";
        # kb-custom-1 = "Alt+1";
        # kb-custom-2 = "Alt+2";
        # kb-custom-3 = "Alt+3";
        # kb-custom-4 = "Alt+4";
        # kb-custom-5 = "Alt+5";
        # kb-select-1 = "Super+1";
        # kb-select-2 = "Super+2";
        # kb-select-3 = "Super+3";
        # kb-select-4 = "Super+4";
        # kb-select-5 = "Super+5";
        # kb-primary-paste = "Control+V,Shift+Insert";
        # kb-secondary-paste = "Control+v,Insert";

        # 显示配置
        show-icons = true;              # 显示图标
        icon-theme = "Papirus";         # 图标主题
        display-drun = " 应用";         # drun模式显示名称
        display-run = " 运行";          # run模式显示名称
        display-window = " 窗口";       # window模式显示名称
        display-ssh = " SSH";          # ssh模式显示名称
        display-keys = " 按键";         # keys模式显示名称
        display-filebrowser = " 文件"; # filebrowser模式显示名称
        display-combi = " 组合";        # combi模式显示名称

        # 行为配置
        modi = "drun,run,window,ssh,filebrowser";  # 可用模式
        combi-modi = "drun,run,window";            # 组合模式包含的模式
        case-sensitive = false;                     # 不区分大小写
        sort = true;                               # 排序结果
        sorting-method = "fzf";                    # 排序方法: "normal", "fzf", "levenshtein"
        matching = "fuzzy";                        # 匹配模式: "normal", "regex", "glob", "fuzzy"
        scroll-method = 0;                         # 滚动方式: 0=页面, 1=行
        normalize-match = true;                    # 标准化匹配

        # 性能配置
        lazy-grab = true;              # 延迟抓取键盘
        parse-hosts = true;           # 解析 hosts 文件用于 SSH
        parse-known-hosts = true;     # 解析 known_hosts 文件

        # 窗口配置
        fixed-num-lines = false;      # 动态行数
        hide-scrollbar = false;       # 显示滚动条
        sidebar-mode = false;         # 不启用侧边栏模式
        auto-select = false;          # 不自动选择唯一匹配

        # 文件浏览器配置
        filebrowser-show-hidden = false;    # 不显示隐藏文件
        filebrowser-command = "xdg-open";   # 文件打开命令
        filebrowser-directories-first = true; # 目录优先显示

        # 运行配置
        run-command = "{cmd}";               # 运行命令格式
        run-shell-command = "{terminal} -e {cmd}"; # shell命令格式

        # SSH配置
        ssh-command = "{terminal} -e {ssh-client} {host}"; # SSH命令格式
        ssh-client = "ssh";                              # SSH客户端
      };
    };

    # ===== 环境变量设置 =====
    home.sessionVariables = {
      # 确保 Rofi 可以找到应用程序
      ROFI_SEARCH = "${config.home.homeDirectory}/.local/share/applications:/usr/share/applications";
    };

    # ===== Shell 别名集成 =====
    programs.bash.shellAliases = lib.mkIf config.programs.bash.enable {
      rofi-apps = "rofi -show drun";
      rofi-run = "rofi -show run";
      rofi-window = "rofi -show window";
      rofi-calc = "rofi -show calc -modi calc -no-show-match -no-sort";
      rofi-emoji = "rofi -show emoji -modi emoji";
    };

    programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
      rofi-apps = "rofi -show drun";
      rofi-run = "rofi -show run";
      rofi-window = "rofi -show window";
      rofi-calc = "rofi -show calc -modi calc -no-show-match -no-sort";
      rofi-emoji = "rofi -show emoji -modi emoji";
    };

    programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
      rofi-apps = "rofi -show drun";
      rofi-run = "rofi -show run";
      rofi-window = "rofi -show window";
      rofi-calc = "rofi -show calc -modi calc -no-show-match -no-sort";
      rofi-emoji = "rofi -show emoji -modi emoji";
    };
  };
}
