{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "homemanager") {
    # 🌟 Starship - 极致炫酷的未来感终端提示符
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        # 🌌 超级赛博朋克矩阵风格 - 终极量子级炫酷布局
        format = ''
          [╭─](fg:#bd93f9 bold)[](bg:#bd93f9 fg:#ff006e)$os[](bg:#ff006e fg:#00f5ff)$username[](bg:#00f5ff fg:#39ff14)$hostname[](bg:#39ff14 fg:#ff073a)$directory[](bg:#ff073a fg:#ffff00)$git_branch$git_status[](bg:#ffff00 fg:#ff1493)$package$nix_shell[](fg:#ff1493)
          [├─](fg:#bd93f9 bold)$fill[◆](fg:#00f5ff)$nodejs[◆](fg:#39ff14)$python[◆](fg:#ff073a)$rust[◆](fg:#ffff00)$golang[◆](fg:#ff1493)$java[◆](fg:#00ffff)$docker_context[◆](fg:#ff6600)$cmd_duration[](fg:#bd93f9)
          [╰─](fg:#bd93f9 bold)$character'';
        
        # � 超炫右侧全息监控面板 - 彩虹矩阵风格
        right_format = ''
          [▓](fg:#ff006e)$battery[▓](fg:#00f5ff)$memory_usage[▓](fg:#39ff14)$time[▓](fg:#ff073a)'';
        
        add_newline = true;
        
        # ⚡ 超炫量子填充器 - 彩虹脉冲连接线
        fill = {
          symbol = "▬";
          style = "fg:#6272a4 bold";
        };
        
        # 🖥️ 操作系统 - 超级未来科技芯片
        os = {
          format = "[ $symbol ](fg:#000000 bg:#ff006e bold)";
          disabled = false;
          symbols = {
            NixOS = "󱄅";
            Ubuntu = "󰕈";
            Debian = "";
            Arch = "󰣇";
            Fedora = "󰣛";
            Manjaro = "";
            openSUSE = "";
            CentOS = "";
            RedHat = "󱄛";
            Linux = "󰌽";
            Macos = "";
            Windows = "󰍲";
          };
        };
        
        # 🌟 终极超炫提示符 - 五重量子箭头
        character = {
          success_symbol = "[❯❯❯❯❯](fg:#39ff14 bold)";
          error_symbol = "[❯❯❯❯❯](fg:#ff073a bold)";
          vicmd_symbol = "[❮❮❮❮❮](fg:#ffff00 bold)";
          vimcmd_symbol = "[❮❮❮❮❮](fg:#ffff00 bold)";
        };
        
        # 👤 用户名 - 超级赛博战士身份标识
        username = {
          style_user = "fg:#000000 bg:#00f5ff bold";
          style_root = "fg:#000000 bg:#ff073a bold";
          format = "[ 󰀄 $user ](bold $style)";
          disabled = false;
          show_always = true;
        };
        
        # 🌐 主机名 - 超级网络虚拟节点
        hostname = {
          ssh_only = false;
          ssh_symbol = " 󰒋 ";
          format = "[ 󰌘 $hostname$ssh_symbol ](fg:#000000 bg:#39ff14 bold)";
          trim_at = ".";
          disabled = false;
        };
        
        # 📁 目录 - 超级全息数据库路径
        directory = {
          style = "fg:#000000 bg:#ff073a bold";
          format = "[ 󰉋 $path ](bold $style)";
          truncation_length = 5;
          truncation_symbol = "…/";
          truncate_to_repo = true;
          home_symbol = "󰋜";
          read_only = " 󰌾";
          read_only_style = "fg:#ff073a";
          substitutions = {
            "Documents" = "󰈙 文档";
            "Downloads" = "󰇚 下载";
            "Music" = "󰝚 音乐";
            "Pictures" = "󰋩 图片";
            "Videos" = "󰕧 视频";
            "Desktop" = "󰇄 桌面";
            "Projects" = "󰲋 项目";
            ".config" = "󰒓 配置";
            ".ssh" = "󰢻 密钥";
            "dev" = "󰃣 开发";
            "src" = "󰴉 源码";
            ".git" = "󰊢 仓库";
            "node_modules" = "󰎙 依赖";
            "target" = "󱘗 构建";
            "build" = "󰏗 构建";
            "dist" = "󰝰 发布";
            "public" = "󰡶 公开";
          };
        };
        
        # 🌿 Git 分支 - 超级量子版本控制核心
        git_branch = {
          symbol = "󰘬";
          style = "fg:#000000 bg:#ffff00 bold";
          format = "[ $symbol $branch ](bold $style)";
          truncation_length = 20;
          truncation_symbol = "…";
          always_show_remote = false;
        };
        
        # 🎯 Git 状态 - 超级矩阵数据流状态
        git_status = {
          style = "fg:#000000 bg:#ffff00 bold";
          format = "[$all_status$ahead_behind ](bold $style)";
          conflicted = " 󰞇";
          ahead = " 󰜷$count";
          behind = " 󰜮$count";
          diverged = " 󰹺$ahead_count󰜮$behind_count";
          up_to_date = " 󰸞";
          untracked = " 󰋗$count";
          stashed = " 󰏗$count";
          modified = " 󰛿$count";
          staged = " 󰐕$count";
          renamed = " 󰑕$count";
          deleted = " 󰍴$count";
        };
        
        # 📦 包管理 - 超级数据块压缩显示
        package = {
          format = "[ 󰏗 v$version ](fg:#000000 bg:#ff1493 bold)";
          version_format = "$version";
          display_private = false;
          disabled = false;
        };
        
        # ⚡ 执行时间 - 超级量子时间计算器
        cmd_duration = {
          min_time = 200;
          format = "[ 󰔛 $duration ](fg:#000000 bg:#ff6600 bold)";
          show_milliseconds = true;
          disabled = false;
        };
        
        # ❄️ Nix Shell - 超级冰晶纯净环境
        nix_shell = {
          format = "[ 󱄅 $state ](fg:#000000 bg:#ff1493 bold)";
          pure_msg = "纯净✨";
          impure_msg = "混合🔥";
          unknown_msg = "环境⚡";
          disabled = false;
        };
        
        # 🟩 Node.js - 超级现代JavaScript运行时
        nodejs = {
          format = "[󰎙$version](fg:#00f5ff bold blink)";
          version_format = "$version";
          detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
          detect_files = ["package.json" ".node-version" ".nvmrc"];
          detect_folders = ["node_modules"];
        };
        
        # 🐍 Python - 超级智能脚本语言
        python = {
          format = "[󰌠$version](fg:#39ff14 bold blink)";
          version_format = "$version";
          pyenv_version_name = false;
          python_binary = ["python" "python3" "python2"];
        };
        
        # 🦀 Rust - 超级系统级安全编程
        rust = {
          format = "[󱘗$version](fg:#ff073a bold blink)";
          version_format = "$version";
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
        };
        
        # 🔷 Go - 超级高效并发语言
        golang = {
          format = "[󰟓$version](fg:#ffff00 bold blink)";
          version_format = "$version";
          detect_extensions = ["go"];
          detect_files = ["go.mod" "go.sum"];
        };
        
        # ☕ Java - 超级企业级开发平台
        java = {
          format = "[󰬷$version](fg:#ff1493 bold blink)";
          version_format = "$version";
          detect_extensions = ["java" "class" "jar"];
          detect_files = ["pom.xml" "build.gradle.kts"];
        };
        
        # 🐳 Docker - 超级容器化宇宙
        docker_context = {
          format = "[󰡨$context](fg:#00ffff bold blink)";
          only_with_files = true;
          detect_files = ["docker-compose.yml" "Dockerfile"];
        };
        
        # 🕐 时间 - 超级全息量子时钟
        time = {
          disabled = false;
          format = "[ 󰥔 $time ](fg:#000000 bg:#39ff14 bold)";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
        };
        
        # 🔋 电池 - 超级能量矩阵监控
        battery = {
          full_symbol = "󰁹";
          charging_symbol = "󰂄";
          discharging_symbol = "󰁿";
          unknown_symbol = "󰂑";
          empty_symbol = "󰂎";
          format = "[ $symbol $percentage ](fg:#000000 bg:#ff006e bold)";
          
          display = [
            {
              threshold = 15;
              style = "fg:#000000 bg:#ff073a bold blink";
            }
            {
              threshold = 50;
              style = "fg:#000000 bg:#ffff00 bold";
            }
            {
              threshold = 80;
              style = "fg:#000000 bg:#39ff14 bold";
            }
          ];
          
          disabled = false;
        };
        
        # 🧠 内存使用率 - 超级神经网络监控
        memory_usage = {
          disabled = false;
          threshold = 60;
          format = "[ 󰍛 $ram ](fg:#000000 bg:#00f5ff bold)";
          symbol = "󰍛";
          style = "bold";
        };
        
        # 🎵 音乐播放器 - 超级音频矩阵
        custom.music = {
          command = "playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo ''";
          when = "playerctl --player=spotify status 2>/dev/null | grep -q 'Playing'";
          format = "[ 󰝚 $output ](fg:#ff1493 bold)";
          symbol = "󰝚";
          disabled = false;
        };
        
        # 🌡️ CPU 温度 - 热力学监控
        custom.cpu_temp = {
          command = "sensors 2>/dev/null | grep 'Package id 0' | awk '{print $4}' | sed 's/+//;s/°C.*/°C/' || echo ''";
          when = "command -v sensors >/dev/null";
          format = "[ 󰔏 $output ](fg:#ff6600 bold)";
          symbol = "󰔏";
          disabled = false;
        };
        
        # 📡 网络状态 - 超级连接矩阵
        custom.network = {
          command = "nmcli -t -f NAME connection show --active 2>/dev/null | head -1 || echo 'Offline'";
          when = "command -v nmcli >/dev/null";
          format = "[ 󰖩 $output ](fg:#00ffff bold)";
          symbol = "󰖩";
          disabled = false;
        };
        
        # 💾 磁盘使用率 - 存储空间监控
        custom.disk_usage = {
          command = "df -h / | awk 'NR==2 {print $5}' | sed 's/%//' || echo ''";
          when = "true";
          format = "[ 󰋊 $output% ](fg:#f1fa8c bold)";
          symbol = "󰋊";
          disabled = false;
        };
      };
    };
  };
}
