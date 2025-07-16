{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "homemanager") {
    # Starship - 现代化跨Shell提示符
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        # 🌟 未来感炫酷布局 - 赛博朋克风格 (完整图标支持)
        format = ''
          [](fg:#ff006e)$os[](bg:#ff006e fg:#8338ec)[](bg:#8338ec fg:#3a86ff)[](bg:#3a86ff fg:#06ffa5)[](bg:#06ffa5 fg:#ffbe0b)[](bg:#ffbe0b fg:#fb5607)[](bg:#fb5607 fg:#ff006e)
          [](fg:#ff006e)$username[](bg:#ff006e fg:#8338ec)$hostname[](bg:#8338ec fg:#3a86ff)$directory[](bg:#3a86ff fg:#06ffa5)$git_branch[](bg:#06ffa5 fg:#ffbe0b)$git_status[](bg:#ffbe0b fg:#fb5607)$package$nix_shell[](bg:#fb5607 fg:#313244)
          [](fg:#cba6f7)$fill[󰞒](fg:#f38ba8)$nodejs[󰞒](fg:#a6e3a1)$python[󰞒](fg:#fab387)$rust[󰞒](fg:#89dceb)$golang[󰞒](fg:#f9e2af)$java[󰞒](fg:#89b4fa)$docker_context[󰞒](fg:#cdd6f4)$cmd_duration[](fg:#a6e3a1)$character'';
        add_newline = true;
        
        # 🔮 右侧炫光状态栏
        right_format = "[](fg:#cba6f7)$time[](fg:#f38ba8)$battery[](fg:#a6e3a1)$memory_usage[](fg:#89b4fa)";
      enableZshIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        # � 未来感炫酷布局 - 赛博朋克风格
        format = ''
          [](fg:#ff006e)$os[](bg:#ff006e fg:#8338ec)[](bg:#8338ec fg:#3a86ff)[](bg:#3a86ff fg:#06ffa5)[](bg:#06ffa5 fg:#ffbe0b)[](bg:#ffbe0b fg:#fb5607)[](bg:#fb5607 fg:#ff006e)
          [](fg:#ff006e)$username[](bg:#ff006e fg:#8338ec)$hostname[](bg:#8338ec fg:#3a86ff)$directory[](bg:#3a86ff fg:#06ffa5)$git_branch[](bg:#06ffa5 fg:#ffbe0b)$git_status[](bg:#ffbe0b fg:#fb5607)$package$nix_shell[](bg:#fb5607 fg:#313244)
          [](fg:#cba6f7)$fill[󰞒](fg:#f38ba8)$nodejs[󰞒](fg:#a6e3a1)$python[󰞒](fg:#fab387)$rust[󰞒](fg:#89dceb)$golang[󰞒](fg:#f9e2af)$java[󰞒](fg:#89b4fa)$docker_context[󰞒](fg:#cdd6f4)$cmd_duration[](fg:#a6e3a1)$character'';
        add_newline = true;
        
        # 🔮 右侧炫光状态栏
        right_format = "[](fg:#cba6f7)$time[](fg:#f38ba8)$battery[](fg:#a6e3a1)$memory_usage[](fg:#89b4fa)";
        
        # � 炫彩填充器 - 动态光效
        fill = {
          symbol = "━";
          style = "fg:#585b70";
        };
        
        # � 操作系统 - 未来科技标识
        os = {
          format = "[  $symbol  ](fg:#11111b bg:#ff006e bold)";
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
        
        # ⚡ 超级炫酷提示符
        character = {
          success_symbol = "[❯❯❯](fg:#a6e3a1 bold)";
          error_symbol = "[❯❯❯](fg:#f38ba8 bold)";
          vicmd_symbol = "[❮❮❮](fg:#f9e2af bold)";
          vimcmd_symbol = "[❮❮❮](fg:#f9e2af bold)";
        };
        
        # � 用户名 - 赛博朋克用户标识
        username = {
          style_user = "fg:#11111b bg:#ff006e bold";
          style_root = "fg:#11111b bg:#f38ba8 bold";
          format = "[  󰀄 $user  ]($style)";
          disabled = false;
          show_always = true;
        };
        
        # � 主机名 - 网络节点显示
        hostname = {
          ssh_only = false;
          ssh_symbol = " 󰒋 ";
          format = "[  󰌘 $hostname$ssh_symbol  ](fg:#11111b bg:#8338ec bold)";
          trim_at = ".";
          disabled = false;
        };
        
        # �️ 目录 - 全息路径显示
        directory = {
          style = "fg:#11111b bg:#3a86ff bold";
          format = "[  󰉋 $path  ]($style)";
          truncation_length = 3;
          truncation_symbol = "󰇘/";
          truncate_to_repo = true;
          home_symbol = "󰋜";
          read_only = " 󰌾";
          read_only_style = "fg:#f38ba8";
          substitutions = {
            "Documents" = "󰈙";
            "Downloads" = "󰇚";
            "Music" = "󰝚";
            "Pictures" = "󰋩";
            "Videos" = "󰕧";
            "Desktop" = "󰇄";
            "Projects" = "󰲋";
            ".config" = "󰒓";
            ".ssh" = "󰢻";
            "dev" = "󰃣";
            "src" = "󰴉";
            ".git" = "󰊢";
            "node_modules" = "󰎙";
            "target" = "󱘗";
          };
        };
        
        # � Git 分支 - 量子版本控制
        git_branch = {
          symbol = "󰘬";
          style = "fg:#11111b bg:#06ffa5 bold";
          format = "[  $symbol $branch  ]($style)";
          truncation_length = 12;
          truncation_symbol = "󰇘";
          always_show_remote = false;
        };
        
        # 🎯 Git 状态 - 矩阵状态显示
        git_status = {
          style = "fg:#11111b bg:#ffbe0b bold";
          format = "[  $all_status$ahead_behind  ]($style)";
          conflicted = "󰞇";
          ahead = "󰜷$count";
          behind = "󰜮$count";
          diverged = "󰹺$ahead_count󰜮$behind_count";
          up_to_date = "󰸞";
          untracked = "󰋗$count";
          stashed = "󰏗$count";
          modified = "󰛿$count";
          staged = "󰐕$count";
          renamed = "󰑕$count";
          deleted = "󰍴$count";
        };
        
        # 📦 包管理 - 数据块显示
        package = {
          format = "[  󰏗 v$version  ](fg:#11111b bg:#fb5607 bold)";
          version_format = "$version";
          display_private = false;
          disabled = false;
        };
        
        # ⚡ 执行时间 - 量子计时器
        cmd_duration = {
          min_time = 1000;
          format = "[  󰔛 $duration  ](fg:#11111b bg:#cdd6f4 bold)";
          show_milliseconds = false;
          disabled = false;
        };
        
        # ❄️ Nix Shell - 冰晶环境
        nix_shell = {
          format = "[  󱄅 $state  ](fg:#11111b bg:#fb5607 bold)";
          pure_msg = "pure";
          impure_msg = "impure";
          unknown_msg = "shell";
          disabled = false;
        };
        
        # � 编程语言 - 全息技术栈
        nodejs = {
          format = "[ 󰎙 $version ](fg:#11111b bg:#f38ba8 bold)";
          version_format = "v$version";
          detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
          detect_files = ["package.json" ".node-version" ".nvmrc"];
          detect_folders = ["node_modules"];
        };
        
        python = {
          format = "[ 󰌠 $version ](fg:#11111b bg:#a6e3a1 bold)";
          version_format = "v$version";
          pyenv_version_name = false;
          python_binary = ["python" "python3" "python2"];
        };
        
        rust = {
          format = "[ 󱘗 $version ](fg:#11111b bg:#fab387 bold)";
          version_format = "v$version";
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
        };
        
        golang = {
          format = "[ 󰟓 $version ](fg:#11111b bg:#89dceb bold)";
          version_format = "v$version";
          detect_extensions = ["go"];
          detect_files = ["go.mod" "go.sum"];
        };
        
        java = {
          format = "[ 󰬷 $version ](fg:#11111b bg:#f9e2af bold)";
          version_format = "v$version";
          detect_extensions = ["java" "class" "jar"];
          detect_files = ["pom.xml" "build.gradle.kts"];
        };
        
        # 🐳 Docker - 容器宇宙
        docker_context = {
          format = "[ 󰡨 $context ](fg:#11111b bg:#89b4fa bold)";
          only_with_files = true;
          detect_files = ["docker-compose.yml" "Dockerfile"];
        };
        
        # 🕐 时间 - 全息时钟
        time = {
          disabled = false;
          format = "[  󰥔 $time  ](fg:#11111b bg:#cba6f7 bold)";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
        };
        
        # 🔋 电池 - 能量核心
        battery = {
          full_symbol = "󰁹";
          charging_symbol = "󰂄";
          discharging_symbol = "󰁿";
          unknown_symbol = "󰂑";
          empty_symbol = "󰂎";
          format = "[  $symbol $percentage  ](fg:#11111b bg:#f38ba8 bold)";
          
          display = [
            {
              threshold = 20;
              style = "fg:#11111b bg:#f38ba8 bold";
            }
            {
              threshold = 50;
              style = "fg:#11111b bg:#f9e2af bold";
            }
            {
              threshold = 80;
              style = "fg:#11111b bg:#a6e3a1 bold";
            }
          ];
          
          disabled = false;
        };
        
        # 🧠 内存 - 神经网络监控
        memory_usage = {
          disabled = false;
          threshold = 70;
          format = "[  󰍛 $ram  ](fg:#11111b bg:#a6e3a1 bold)";
          symbol = "󰍛";
        };
      };
    };
  };
}
