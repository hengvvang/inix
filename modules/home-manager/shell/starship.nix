{ config, lib, pkgs, ... }:

{
  # Starship 提示符 - 现代化的跨 Shell 提示符
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    
    # Starship 配置
    settings = {
      # 格式配置
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$git_metrics"
        "$fill"
        "$nodejs"
        "$rust"
        "$python"
        "$golang"
        "$java"
        "$docker_context"
        "$kubernetes"
        "$time"
        "$line_break"
        "$character"
      ];
      
      # 右侧提示符格式
      right_format = "$cmd_duration";
      
      # 用户名模块
      username = {
        style_user = "bold blue";
        style_root = "bold red";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      
      # 主机名模块
      hostname = {
        ssh_only = false;
        format = "@[$hostname](bold green) ";
        disabled = false;
      };
      
      # 目录模块
      directory = {
        style = "bold cyan";
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        read_only = "🔒";
        read_only_style = "red";
        
        # 目录替换
        substitutions = {
          "Documents" = "📄";
          "Downloads" = "⬇️";
          "Music" = "🎵";
          "Pictures" = "📷";
          "Videos" = "🎬";
          "Projects" = "💻";
          "Code" = "💻";
          "work" = "💼";
          "flake" = "❄️";
        };
      };
      
      # Git 分支模块
      git_branch = {
        symbol = "🌱 ";
        format = "[$symbol$branch]($style) ";
        style = "bold purple";
        truncation_length = 20;
        truncation_symbol = "…";
      };
      
      # Git 状态模块
      git_status = {
        format = "([$all_status$ahead_behind]($style))";
        style = "bold red";
        conflicted = "⚡";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?";
        stashed = "📦";
        modified = "📝";
        staged = "✅";
        renamed = "👅";
        deleted = "🗑";
      };
      
      # Git 状态详情
      git_state = {
        format = "([$state( $progress_current/$progress_total)]($style)) ";
        style = "bright-black";
      };
      
      # Git 指标
      git_metrics = {
        added_style = "bold green";
        deleted_style = "bold red";
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
        disabled = false;
      };
      
      # 填充符
      fill = {
        symbol = " ";
      };
      
      # 编程语言模块
      nodejs = {
        symbol = "⬢ ";
        format = "[$symbol($version )]($style)";
        style = "bold green";
        detect_extensions = ["js" "mjs" "cjs" "ts"];
        detect_files = ["package.json" ".node-version"];
        detect_folders = ["node_modules"];
      };
      
      rust = {
        symbol = "🦀 ";
        format = "[$symbol($version )]($style)";
        style = "bold red";
        detect_extensions = ["rs"];
        detect_files = ["Cargo.toml"];
      };
      
      python = {
        symbol = "🐍 ";
        format = "[$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
        style = "bold yellow";
        detect_extensions = ["py"];
        detect_files = [".python-version" "Pipfile" "requirements.txt" "pyproject.toml"];
      };
      
      golang = {
        symbol = "🐹 ";
        format = "[$symbol($version )]($style)";
        style = "bold cyan";
        detect_extensions = ["go"];
        detect_files = ["go.mod"];
      };
      
      java = {
        symbol = "☕ ";
        format = "[$symbol($version )]($style)";
        style = "bold orange";
        detect_extensions = ["java" "class" "gradle" "jar" "cljs" "cljc"];
        detect_files = ["pom.xml" "build.gradle.kts" "build.sbt" ".java-version"];
      };
      
      # 容器和云服务
      docker_context = {
        symbol = "🐳 ";
        format = "[$symbol$context]($style) ";
        style = "blue bold";
        only_with_files = true;
        detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
        detect_folders = [".devcontainer"];
      };
      
      kubernetes = {
        symbol = "⎈ ";
        format = "[$symbol$context( \($namespace\))]($style) ";
        style = "cyan bold";
        disabled = false;
        detect_files = ["k8s"];
        detect_folders = ["k8s"];
      };
      
      # 时间模块
      time = {
        disabled = false;
        format = "🕒[$time]($style) ";
        style = "bold white";
        time_format = "%T";
        utc_time_offset = "+8";
      };
      
      # 命令执行时间
      cmd_duration = {
        min_time = 2000;
        format = "⏱️ [$duration]($style)";
        style = "yellow bold";
        show_milliseconds = true;
      };
      
      # 字符提示符
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold yellow)";
      };
      
      # Nix Shell 检测
      nix_shell = {
        disabled = false;
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        format = "via [☃️ $state( \($name\))](bold blue) ";
      };
      
      # 电池模块 (笔记本电脑)
      battery = {
        full_symbol = "🔋";
        charging_symbol = "⚡";
        discharging_symbol = "💀";
        
        display = [
          {
            threshold = 10;
            style = "bold red";
          }
          {
            threshold = 30;
            style = "bold yellow";
          }
        ];
      };
      
      # 内存使用情况
      memory_usage = {
        disabled = false;
        threshold = 70;
        format = "via $symbol[\${ram}( | \${swap})]($style) ";
        style = "bold dimmed red";
        symbol = "🐏";
      };
      
      # 状态模块
      status = {
        style = "bg:blue";
        symbol = "🔴";
        format = "[\[$symbol $common_meaning$signal_name$maybe_int\]]($style) ";
        map_symbol = true;
        disabled = false;
      };
    };
  };
}
