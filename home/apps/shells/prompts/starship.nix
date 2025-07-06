{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.shells.prompts.starship.enable {
  # Starship 提示符配置 - 现代化跨 Shell 提示符
    programs.starship = {
      enable = true;
      
      # Starship 配置
      settings = {
        # 提示符格式
        format = "$all$character";
        
        # 字符配置
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
        
        # Git 状态
        git_status = {
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
          modified = "📝";
          untracked = "🆕";
          staged = "✅";
          renamed = "📛";
          deleted = "🗑️";
        };
        
        # Git 分支
        git_branch = {
          symbol = "🌱 ";
          truncation_length = 10;
          truncation_symbol = "…";
        };
        
        # 目录显示
        directory = {
          truncation_length = 3;
          fish_style_pwd_dir_length = 1;
          home_symbol = "🏠";
        };
        
        # 语言版本显示
        rust = {
          symbol = "🦀 ";
          format = "[$symbol($version)]($style) ";
        };
        
        python = {
          symbol = "🐍 ";
          format = "[$symbol$pyenv_prefix($version)($virtualenv)]($style) ";
        };
        
        nodejs = {
          symbol = "⬢ ";
          format = "[$symbol($version)]($style) ";
        };
        
        c = {
          symbol = "C ";
          format = "[$symbol($version)]($style) ";
        };
        
        cpp = {
          symbol = "C++ ";
          format = "[$symbol($version)]($style) ";
        };
        
        go = {
          symbol = "🐹 ";
          format = "[$symbol($version)]($style) ";
        };
        
        java = {
          symbol = "☕ ";
          format = "[$symbol($version)]($style) ";
        };
        
        # Docker 上下文
        docker_context = {
          symbol = "🐳 ";
          format = "[$symbol$context]($style) ";
        };
        
        # Kubernetes 上下文
        kubernetes = {
          symbol = "⎈ ";
          format = "[$symbol$context( \\($namespace\\))]($style) ";
          disabled = false;
        };
        
        # 命令执行时间
        cmd_duration = {
          min_time = 2000;
          format = "took [$duration](bold yellow)";
        };
        
        # 时间显示
        time = {
          disabled = false;
          format = "🕐[$time]($style) ";
          time_format = "%H:%M";
        };
        
        # 包管理器
        package = {
          symbol = "📦 ";
          format = "[$symbol$version]($style) ";
        };
        
        # 内存使用
        memory_usage = {
          disabled = false;
          threshold = 70;
          symbol = "🐏 ";
        };
        
        # 电池状态
        battery = {
          full_symbol = "🔋";
          charging_symbol = "🔌";
          discharging_symbol = "⚡";
          unknown_symbol = "❓";
          empty_symbol = "❗";
        };
      };
    };
  };
}
