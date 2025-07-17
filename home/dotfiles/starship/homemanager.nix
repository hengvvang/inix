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
        # 🤖 EVA-01 终极战斗终端 - Evangelion Unit-01 主题
        format = ''
          [╭─](fg:#8A2BE2 bold)[◤](fg:#32CD32 bold)[◢](fg:#FF4500 bold)[EVA-01](fg:#8A2BE2 bold)[◤](fg:#32CD32 bold)[◢](fg:#FF4500 bold)$os$username$hostname
          [├─](fg:#8A2BE2 bold)[◆](fg:#32CD32 bold)$directory[◆](fg:#FF4500 bold)$git_branch$git_status$nix_shell
          [├─](fg:#8A2BE2 bold)[◇](fg:#32CD32 bold)$nodejs$python$rust$golang$java$docker_context$cmd_duration[◇](fg:#FF4500 bold)
          [├─](fg:#8A2BE2 bold)[▲](fg:#32CD32 bold)$battery$memory_usage$custom.cpu_temp$custom.audio_status[▲](fg:#FF4500 bold)
          [╰─](fg:#8A2BE2 bold)[▶](fg:#32CD32 bold)$character'';
        
        right_format = ''[◀](fg:#8A2BE2 bold)[⏰](fg:#32CD32 bold)$time[◢](fg:#FF4500 bold)'';
        
        add_newline = true;
        
        # 🤖 EVA-01 操作系统标识 - 战斗界面风格
        os = {
          format = "[◤](fg:#8A2BE2 bold)[ $symbol ](fg:#32CD32 bold)[◢](fg:#FF4500 bold)";
          disabled = false;
          symbols = {
            NixOS = "❄️";
            Ubuntu = "🔶";
            Debian = "🌀";
            Arch = "⚡";
            Fedora = "🔷";
            Manjaro = "🟢";
            openSUSE = "🟩";
            CentOS = "🔴";
            Redhat = "🔺";
            Linux = "🐧";
            Macos = "🍎";
            Windows = "🪟";
          };
        };
        
        # ⚡ EVA-01 同步率指示器 - AT Field 激活状态
        character = {
          success_symbol = "[◢◤](fg:#32CD32 bold)[▶](fg:#32CD32 bold)[◤◢](fg:#32CD32 bold)";
          error_symbol = "[◢◤](fg:#FF0000 bold)[▶](fg:#FF0000 bold)[◤◢](fg:#FF0000 bold)";
          vicmd_symbol = "[◢◤](fg:#FF4500 bold)[◀](fg:#FF4500 bold)[◤◢](fg:#FF4500 bold)";
        };
        
        # 👤 驾驶员身份识别 - NERV 人员系统
        username = {
          style_user = "fg:#32CD32 bold";
          style_root = "fg:#FF0000 bold";
          format = "[◤](fg:#8A2BE2 bold)[ $user ](bold $style)[◢](fg:#FF4500 bold)";
          disabled = false;
          show_always = true;
        };
        
        # 🌐 MAGI 终端节点 - 三贤人系统连接
        hostname = {
          ssh_only = false;
          ssh_symbol = "⟷";
          format = "[◇](fg:#8A2BE2 bold)[ $hostname$ssh_symbol ](fg:#32CD32 bold)[◇](fg:#FF4500 bold)";
          trim_at = ".";
          disabled = false;
        };
        
        # 📁 东京-3 文件系统导航
        directory = {
          style = "fg:#8A2BE2 bold";
          format = "[◢](fg:#32CD32 bold)[ $path ](bold $style)[◤](fg:#FF4500 bold)";
          truncation_length = 4;
          truncation_symbol = "⟨…⟩/";
          truncate_to_repo = true;
          home_symbol = "🏠";
          read_only = "🔒";
          read_only_style = "fg:#FF0000";
        };
        
        # 🌿 LCL 版本控制系统 - 生命之树分支
        git_branch = {
          symbol = "🌿";
          style = "fg:#32CD32 bold";
          format = "[◤](fg:#8A2BE2 bold)[ $symbol$branch ](bold $style)[◢](fg:#FF4500 bold)";
          truncation_length = 15;
          truncation_symbol = "⟨…⟩";
        };
        
        # 🎯 AT Field 状态监控 - 同步率显示
        git_status = {
          style = "fg:#32CD32 bold";
          format = "[◇](fg:#8A2BE2 bold)[$all_status$ahead_behind ](bold $style)[◇](fg:#FF4500 bold)";
          conflicted = "⚠️$count";
          ahead = "⬆️$count";
          behind = "⬇️$count";
          diverged = "↕️$ahead_count⬇️$behind_count";
          up_to_date = "✅";
          untracked = "❓$count";
          stashed = "💾$count";
          modified = "📝$count";
          staged = "➕$count";
          renamed = "📛$count";
          deleted = "🗑️$count";
        };
        
        # ❄️ NERV Nix 环境模拟器
        nix_shell = {
          format = "[◢](fg:#8A2BE2 bold)[❄️nix:$state ](fg:#00BFFF bold)[◤](fg:#FF4500 bold)";
          pure_msg = "PURE";
          impure_msg = "IMPURE";
          unknown_msg = "UNKNOWN";
          disabled = false;
        };
        
        # 📟 开发环境监控系统 - MAGI 超级计算机
        nodejs = {
          format = "[⬢](fg:#32CD32 bold)[js:$version ](fg:#32CD32 bold)";
          version_format = "$version";
          detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
          detect_files = ["package.json" ".node-version" ".nvmrc"];
          detect_folders = ["node_modules"];
        };
        
        python = {
          format = "[🐍](fg:#FFD700 bold)[py:$version ](fg:#FFD700 bold)";
          version_format = "$version";
          pyenv_version_name = false;
          python_binary = ["python" "python3" "python2"];
        };
        
        rust = {
          format = "[⚙️](fg:#FF4500 bold)[rs:$version ](fg:#FF4500 bold)";
          version_format = "$version";
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
        };
        
        golang = {
          format = "[🐹](fg:#00ADD8 bold)[go:$version ](fg:#00ADD8 bold)";
          version_format = "$version";
          detect_extensions = ["go"];
          detect_files = ["go.mod" "go.sum"];
        };
        
        java = {
          format = "[☕](fg:#ED8B00 bold)[java:$version ](fg:#ED8B00 bold)";
          version_format = "$version";
          detect_extensions = ["java" "class" "jar"];
          detect_files = ["pom.xml" "build.gradle.kts"];
        };
        
        docker_context = {
          format = "[🐳](fg:#2496ED bold)[dock:$context ](fg:#2496ED bold)";
          only_with_files = true;
          detect_files = ["docker-compose.yml" "Dockerfile"];
        };
        
        # ⚡ 战斗执行时间分析
        cmd_duration = {
          min_time = 500;
          format = "[⚡](fg:#FFD700 bold)[took:$duration ](fg:#FF4500 bold)";
          show_milliseconds = false;
          disabled = false;
        };
        
        # 🕐 NERV 标准时间 - 使徒来袭警报系统
        time = {
          disabled = false;
          format = "[◤](fg:#8A2BE2 bold)[ $time ](fg:#32CD32 bold)[◢](fg:#FF4500 bold)";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
        };
        
        # 🔋 系统状态监控 - EVA-01 电源管理
        battery = {
          full_symbol = "🔋";
          charging_symbol = "⚡";
          discharging_symbol = "🪫";
          unknown_symbol = "❓";
          empty_symbol = "💀";
          format = "[◇](fg:#8A2BE2 bold)[$symbol$percentage ](fg:#32CD32 bold)[◇](fg:#FF4500 bold)";
          display = [
            {
              threshold = 10;
              style = "fg:#FF0000 bold";
            }
            {
              threshold = 30;
              style = "fg:#FF4500 bold";
            }
            {
              threshold = 50;
              style = "fg:#FFD700 bold";
            }
            {
              threshold = 100;
              style = "fg:#32CD32 bold";
            }
          ];
        };
        
        # 💾 内存使用监控 - LCL 液体容量显示
        memory_usage = {
          disabled = false;
          threshold = 70;
          symbol = "💾";
          style = "fg:#FF4500 bold";
          format = "[◢](fg:#8A2BE2 bold)[$symbol$ram($ram_pct) ](bold $style)[◤](fg:#32CD32 bold)";
        };
        
        # 🌡️ CPU 温度监控 - AT Field 发热警告
        custom.cpu_temp = {
          command = "if command -v sensors >/dev/null 2>&1; then sensors 2>/dev/null | grep -E 'Core 0|Package id 0' | head -1 | grep -o '+[0-9]*' | head -1 | sed 's/+//'; else echo 'N/A'; fi";
          when = "true";
          format = "[🌡️](fg:#FF4500 bold)[$output°C ](fg:#FFD700 bold)";
          disabled = false;
        };
        
        # 🎵 音频状态 - EVA-01 战斗音效系统  
        custom.audio_status = {
          command = "if command -v pactl >/dev/null 2>&1; then pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -o '[0-9]*%' | head -1 || echo 'N/A'; else echo 'N/A'; fi";
          when = "true";
          format = "[🎵](fg:#32CD32 bold)[$output ](fg:#8A2BE2 bold)";
          disabled = false;
        };
      };
    };
  };
}
