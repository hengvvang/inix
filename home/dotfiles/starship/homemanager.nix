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
        # 🤖 EVA-01 福音战士终极赛博朋克矩阵 - AT力场全开！
        format = ''
          [━━━╺](fg:#9966ff bold)[](bg:#9966ff fg:#6600cc)$os[](bg:#6600cc fg:#00ff41)$username[](bg:#00ff41 fg:#ff6600)$hostname[](bg:#ff6600 fg:#9966ff)$directory[](bg:#9966ff fg:#00ff41)$git_branch$git_status[](bg:#00ff41 fg:#ff6600)$package$nix_shell[](fg:#ff6600)
          [━━━┫](fg:#9966ff bold)$fill[◈](fg:#00ff41 bold)$nodejs[◈](fg:#ff6600 bold)$python[◈](fg:#9966ff bold)$rust[◈](fg:#00ff41 bold)$golang[◈](fg:#ff6600 bold)$java[◈](fg:#9966ff bold)$docker_context[◈](fg:#00ff41 bold)$cmd_duration[](fg:#9966ff)
          [━━━╸](fg:#9966ff bold)$character'';
        
        # 🌟 EVA-01 右侧 A.T.力场监控面板 - 同步率显示
        right_format = ''
          [▓▓](fg:#ff6600 bold)$battery[▓▓](fg:#9966ff bold)$memory_usage[▓▓](fg:#00ff41 bold)$time[▓▓](fg:#ff6600 bold)'';
        
        add_newline = true;
        
        # ⚡ EVA-01 量子连接线 - A.T.力场波动
        fill = {
          symbol = "═";
          style = "fg:#6600cc bold";
        };
        
        # 🤖 EVA-01 操作系统核心 - NERV总部认证
        os = {
          format = "[ $symbol ](fg:#ffffff bg:#6600cc bold)";
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
        
        # ⚡ EVA-01 终极指令提示符 - AT力场展开！
        character = {
          success_symbol = "[❯❯❯❯❯](fg:#00ff41 bold blink)";
          error_symbol = "[❯❯❯❯❯](fg:#ff3030 bold blink)";
          vicmd_symbol = "[❮❮❮❮❮](fg:#ff6600 bold blink)";
          vimcmd_symbol = "[❮❮❮❮❮](fg:#ff6600 bold blink)";
        };
        
        # 👤 EVA驾驶员身份 - 适格者认证系统
        username = {
          style_user = "fg:#ffffff bg:#00ff41 bold";
          style_root = "fg:#ffffff bg:#ff3030 bold";
          format = "[ 🤖 $user ](bold $style)";
          disabled = false;
          show_always = true;
        };
        
        # 🌐 NERV终端节点 - 第三新东京市网络
        hostname = {
          ssh_only = false;
          ssh_symbol = " 🔗 ";
          format = "[ 🏢 $hostname$ssh_symbol ](fg:#000000 bg:#ff6600 bold)";
          trim_at = ".";
          disabled = false;
        };
        
        # 📁 MAGI系统目录 - 超级计算机数据路径
        directory = {
          style = "fg:#ffffff bg:#9966ff bold";
          format = "[ 📂 $path ](bold $style)";
          truncation_length = 4;
          truncation_symbol = "…/";
          truncate_to_repo = true;
          home_symbol = "🏠";
          read_only = " 🔒";
          read_only_style = "fg:#ff3030";
          substitutions = {
            "Documents" = "📋 文档";
            "Downloads" = "⬇️ 下载";
            "Music" = "🎵 音乐";
            "Pictures" = "🖼️ 图片";
            "Videos" = "🎥 视频";
            "Desktop" = "🖥️ 桌面";
            "Projects" = "🚀 项目";
            ".config" = "⚙️ 配置";
            ".ssh" = "🔐 密钥";
            "dev" = "💻 开发";
            "src" = "📜 源码";
            ".git" = "🌿 仓库";
            "node_modules" = "📦 依赖";
            "target" = "🎯 构建";
            "build" = "🔨 构建";
            "dist" = "📤 发布";
            "public" = "🌐 公开";
          };
        };
        
        # 🌿 EVA版本控制核心 - 生命之树分支系统
        git_branch = {
          symbol = "🌳";
          style = "fg:#ffffff bg:#00ff41 bold";
          format = "[ $symbol $branch ](bold $style)";
          truncation_length = 18;
          truncation_symbol = "…";
          always_show_remote = false;
        };
        
        # 🎯 EVA同步状态 - AT力场波动监测
        git_status = {
          style = "fg:#000000 bg:#00ff41 bold";
          format = "[$all_status$ahead_behind ](bold $style)";
          conflicted = " ⚔️";
          ahead = " ⬆️$count";
          behind = " ⬇️$count";
          diverged = " 🔄$ahead_count⬇️$behind_count";
          up_to_date = " ✅";
          untracked = " ❓$count";
          stashed = " 📦$count";
          modified = " ✏️$count";
          staged = " ➕$count";
          renamed = " 🔄$count";
          deleted = " ❌$count";
        };
        
        # 📦 EVA装备包 - 武器系统版本
        package = {
          format = "[ 🛡️ v$version ](fg:#ffffff bg:#ff6600 bold)";
          version_format = "$version";
          display_private = false;
          disabled = false;
        };
        
        # ⚡ EVA激活时间 - 同步率计算器
        cmd_duration = {
          min_time = 200;
          format = "[ ⚡ $duration ](fg:#ffffff bg:#ff6600 bold)";
          show_milliseconds = true;
          disabled = false;
        };
        
        # ❄️ EVA-Nix环境 - 第三使徒冰晶系统
        nix_shell = {
          format = "[ ❄️ $state ](fg:#ffffff bg:#9966ff bold)";
          pure_msg = "纯净🔮";
          impure_msg = "混沌🌪️";
          unknown_msg = "未知🔥";
          disabled = false;
        };
        
        # � Node.js - 第四使徒运行时
        nodejs = {
          format = "[📗$version](fg:#00ff41 bold blink)";
          version_format = "$version";
          detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
          detect_files = ["package.json" ".node-version" ".nvmrc"];
          detect_folders = ["node_modules"];
        };
        
        # 🐍 Python - 第五使徒智能体
        python = {
          format = "[🐍$version](fg:#ff6600 bold blink)";
          version_format = "$version";
          pyenv_version_name = false;
          python_binary = ["python" "python3" "python2"];
        };
        
        # 🦀 Rust - 第六使徒系统核心
        rust = {
          format = "[🦀$version](fg:#9966ff bold blink)";
          version_format = "$version";
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
        };
        
        # 🔷 Go - 第七使徒并发引擎
        golang = {
          format = "[🔷$version](fg:#00ff41 bold blink)";
          version_format = "$version";
          detect_extensions = ["go"];
          detect_files = ["go.mod" "go.sum"];
        };
        
        # ☕ Java - 第八使徒企业战舰
        java = {
          format = "[☕$version](fg:#ff6600 bold blink)";
          version_format = "$version";
          detect_extensions = ["java" "class" "jar"];
          detect_files = ["pom.xml" "build.gradle.kts"];
        };
        
        # 🐳 Docker - 第九使徒容器矩阵
        docker_context = {
          format = "[🐳$context](fg:#9966ff bold blink)";
          only_with_files = true;
          detect_files = ["docker-compose.yml" "Dockerfile"];
        };
        
        # 🕐 EVA计时系统 - NERV标准时间
        time = {
          disabled = false;
          format = "[ 🕐 $time ](fg:#000000 bg:#00ff41 bold)";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
        };
        
        # 🔋 EVA能源核心 - S²机关监控
        battery = {
          full_symbol = "🔋";
          charging_symbol = "⚡";
          discharging_symbol = "🪫";
          unknown_symbol = "❓";
          empty_symbol = "💀";
          format = "[ $symbol $percentage ](fg:#ffffff bg:#ff6600 bold)";
          
          display = [
            {
              threshold = 15;
              style = "fg:#ffffff bg:#ff3030 bold blink";
            }
            {
              threshold = 50;
              style = "fg:#000000 bg:#ff6600 bold";
            }
            {
              threshold = 80;
              style = "fg:#000000 bg:#00ff41 bold";
            }
          ];
          
          disabled = false;
        };
        
        # 🧠 MAGI系统内存 - 三贤人监控
        memory_usage = {
          disabled = false;
          threshold = 60;
          format = "[ 🧠 $ram ](fg:#ffffff bg:#9966ff bold)";
          symbol = "🧠";
          style = "bold";
        };
        
        # 🎵 EVA音频矩阵 - 第十使徒音波攻击
        custom.music = {
          command = "playerctl --player=spotify metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || echo ''";
          when = "playerctl --player=spotify status 2>/dev/null | grep -q 'Playing'";
          format = "[ 🎵 $output ](fg:#ff6600 bold)";
          symbol = "🎵";
          disabled = false;
        };
        
        # 🌡️ EVA核心温度 - 暴走警告系统
        custom.cpu_temp = {
          command = "sensors 2>/dev/null | grep 'Package id 0' | awk '{print $4}' | sed 's/+//;s/°C.*/°C/' || echo ''";
          when = "command -v sensors >/dev/null";
          format = "[ 🌡️ $output ](fg:#ff3030 bold)";
          symbol = "🌡️";
          disabled = false;
        };
        
        # 📡 NERV通讯网络 - 第三新东京市连接
        custom.network = {
          command = "nmcli -t -f NAME connection show --active 2>/dev/null | head -1 || echo 'Offline'";
          when = "command -v nmcli >/dev/null";
          format = "[ 📡 $output ](fg:#00ff41 bold)";
          symbol = "📡";
          disabled = false;
        };
        
        # 💾 MAGI存储监控 - 数据湖容量检测
        custom.disk_usage = {
          command = "df -h / | awk 'NR==2 {print $5}' | sed 's/%//' || echo ''";
          when = "true";
          format = "[ 💾 $output% ](fg:#9966ff bold)";
          symbol = "💾";
          disabled = false;
        };
        
        # 🤖 EVA同步率显示 - 驾驶员状态监控
        custom.eva_sync = {
          command = "echo '$(shuf -i 90-100 -n 1)%'";
          when = "true";
          format = "[ 🤖 同步率$output ](fg:#00ff41 bold blink)";
          symbol = "🤖";
          disabled = false;
        };
        
        # ⚠️ AT力场状态 - 绝对恐怖领域
        custom.at_field = {
          command = "echo '$(shuf -i 80-100 -n 1)%'";
          when = "true";
          format = "[ ⚠️ AT力场$output ](fg:#ff6600 bold blink)";
          symbol = "⚠️";
          disabled = false;
        };
      };
    };
  };
}
