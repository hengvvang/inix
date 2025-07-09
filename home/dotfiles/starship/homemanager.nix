{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "homemanager") {
    # Starship - 现代化跨Shell提示符
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        # 提示符格式 - 美观的多行式布局
        format = ''
          $username$hostname$directory$git_branch$git_status$git_metrics$package$nix_shell
          $nodejs$python$rust$go$java$docker_context$kubernetes$terraform$cmd_duration$jobs$status
          $character'';
        add_newline = true;
        
        # 字符设置 - 精美的箭头符号
        character = {
          success_symbol = "[❯](bold bright-green)";
          error_symbol = "[❯](bold bright-red)";
          vicmd_symbol = "[❮](bold bright-yellow)";
        };
        
        # 用户名和主机名 - 带背景色
        username = {
          style_user = "white bold bg:blue";
          style_root = "white bold bg:red";
          format = "[ $user ]($style)";
          disabled = false;
          show_always = true;
        };
        
        hostname = {
          ssh_only = false;
          format = "[@$hostname](white bold bg:purple) ";
          trim_at = ".";
          disabled = false;
        };
        
        # 目录显示 - 带图标和渐变色
        directory = {
          style = "white bold bg:cyan";
          format = "[ 📁 $path ]($style)";
          truncation_length = 4;
          truncation_symbol = "…/";
          truncate_to_repo = true;
          home_symbol = "🏠";
          read_only = " 🔒";
          read_only_style = "red";
        };
        
        # Git 分支 - 美观的分支图标
        git_branch = {
          symbol = "🌿 ";
          style = "white bold bg:green";
          format = "[ $symbol$branch(:$remote_branch) ]($style)";
          truncation_length = 15;
          truncation_symbol = "…";
          always_show_remote = false;
        };
        
        # Git 状态 - 详细的状态指示器
        git_status = {
          style = "white bold bg:red";
          format = "[ $all_status$ahead_behind ]($style)";
          conflicted = "⚔️ ";
          ahead = "🏎️ 💨 ×$count ";
          behind = "🐌 ×$count ";
          diverged = "🔱 🏎️ 💨 ×$ahead_count 🐌 ×$behind_count ";
          up_to_date = "✅ ";
          untracked = "🛤️  ×$count ";
          stashed = "📦 ";
          modified = "📝 ×$count ";
          staged = "🗃️  ×$count ";
          renamed = "📛 ×$count ";
          deleted = "🗑️  ×$count ";
        };
        
        # Git 提交统计
        git_metrics = {
          added_style = "bold bright-green";
          deleted_style = "bold bright-red";
          only_nonzero_diffs = true;
          format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
          disabled = false;
        };
        
        # 包版本显示
        package = {
          format = "[ 📦 $version ](bright-blue bold)";
          version_format = "v$version";
          symbol = "📦 ";
          style = "bright-blue bold";
          display_private = false;
          disabled = false;
        };
        
        # 命令执行时间 - 性能监控
        cmd_duration = {
          min_time = 2000;
          format = "[ ⏱️  $duration ]($style)";
          style = "yellow bold";
          show_milliseconds = true;
          disabled = false;
        };
        
        # Nix Shell 指示器 - 雪花图标
        nix_shell = {
          format = "[ ❄️  $state( $name) ]($style)";
          style = "bright-blue bold";
          pure_msg = "pure";
          impure_msg = "impure";
          unknown_msg = "";
          disabled = false;
        };
        
        # 编程语言版本显示 - 带彩色图标
        nodejs = {
          format = "[ ⬢ $version ]($style)";
          version_format = "v$version";
          style = "bright-green bold";
          symbol = "⬢ ";
          detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
          detect_files = ["package.json" ".node-version" ".nvmrc"];
          detect_folders = ["node_modules"];
        };
        
        python = {
          format = "[ 🐍 $version ]($style)";
          version_format = "v$version";
          style = "bright-yellow bold";
          symbol = "🐍 ";
          pyenv_version_name = false;
          pyenv_prefix = "pyenv ";
          python_binary = ["python" "python3" "python2"];
        };
        
        rust = {
          format = "[ 🦀 $version ]($style)";
          version_format = "v$version";
          style = "bright-red bold";
          symbol = "🦀 ";
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
        };
        
        golang = {
          format = "[ � $version ]($style)";
          version_format = "v$version";
          style = "bright-cyan bold";
          symbol = "🐹 ";
          detect_extensions = ["go"];
          detect_files = ["go.mod" "go.sum" "glide.yaml" "Gopkg.yml" "Gopkg.lock" ".go-version"];
        };
        
        java = {
          format = "[ ☕ $version ]($style)";
          version_format = "v$version";
          style = "bright-red bold";
          symbol = "☕ ";
          detect_extensions = ["java" "class" "jar" "gradle" "clj" "cljc"];
          detect_files = ["pom.xml" "build.gradle.kts" "build.sbt" ".java-version" "deps.edn" "project.clj" "build.boot"];
        };
        
        # Docker 上下文
        docker_context = {
          format = "[ 🐳 $context ]($style)";
          style = "bright-blue bold";
          symbol = "🐳 ";
          only_with_files = true;
          detect_extensions = [];
          detect_files = ["docker-compose.yml" "docker-compose.yaml" "Dockerfile"];
          detect_folders = [];
        };
        
        # Kubernetes 上下文
        kubernetes = {
          format = "[ ⎈ $context( $namespace) ]($style)";
          style = "bright-blue bold";
          symbol = "⎈ ";
          disabled = false;
          detect_extensions = [];
          detect_files = ["k8s"];
          detect_folders = [];
        };
        
        # Terraform
        terraform = {
          format = "[ 🏗️  $version ]($style)";
          version_format = "v$version";
          style = "bright-purple bold";
          symbol = "🏗️  ";
          detect_extensions = ["tf" "tfplan" "tfstate"];
          detect_files = [];
          detect_folders = [".terraform"];
        };
        
        # 后台任务指示器
        jobs = {
          threshold = 1;
          symbol_threshold = 1;
          number_threshold = 2;
          format = "[ ⚙️  $symbol$number ]($style)";
          symbol = "⚙️ ";
          style = "bright-red bold";
        };
        
        # 状态指示器
        status = {
          style = "bright-red bold";
          symbol = "❌ ";
          success_symbol = "✅ ";
          not_executable_symbol = "🚫 ";
          not_found_symbol = "🔍 ";
          sigint_symbol = "🧱 ";
          signal_symbol = "⚡ ";
          format = "[$symbol$common_meaning$signal_name$maybe_int]($style)";
          map_symbol = true;
          disabled = false;
        };
        
        # 右侧提示符 - 时间和系统信息
        right_format = "$time $battery $memory_usage";
        
        time = {
          disabled = false;
          format = "[ 🕐 $time ]($style)";
          style = "bright-yellow bold";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
          time_range = "-";
        };
        
        battery = {
          full_symbol = "🔋 ";
          charging_symbol = "⚡ ";
          discharging_symbol = "💀 ";
          unknown_symbol = "❓ ";
          empty_symbol = "❗ ";
          format = "[$symbol$percentage]($style)";
          
          display = [
            {
              threshold = 10;
              style = "bold red";
            }
            {
              threshold = 30;
              style = "bold yellow";
            }
            {
              threshold = 50;
              style = "bold green";
            }
          ];
          
          disabled = false;
        };
        
        memory_usage = {
          disabled = false;
          threshold = 75;
          format = "[ 🧠 $ram( | $swap) ]($style)";
          style = "bright-white bold";
          symbol = "🧠 ";
        };
      };
    };
  };
}
