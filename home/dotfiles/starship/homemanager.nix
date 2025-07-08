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
        # 提示符格式 - 现代化一行式
        format = "$all$character";
        add_newline = true;
        
        # 字符设置 - 现代化箭头
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
          vicmd_symbol = "[❮](bold yellow)";
        };
        
        # 目录显示 - 简洁但信息丰富
        directory = {
          style = "cyan bold";
          truncation_length = 3;
          truncate_to_repo = true;
          home_symbol = "~";
        };
        
        # Git 状态 - 现代化图标
        git_branch = {
          symbol = " ";
          style = "purple bold";
          truncation_length = 10;
        };
        
        git_status = {
          style = "red bold";
          ahead = "⇡";
          behind = "⇣";
          diverged = "⇕";
          modified = "!";
          staged = "+";
          renamed = "»";
          deleted = "✘";
        };
        
        # 命令执行时间 - 性能提示
        cmd_duration = {
          min_time = 2000;
          format = "took [$duration]($style) ";
          style = "yellow bold";
        };
        
        # Nix Shell 指示器
        nix_shell = {
          format = "via [❄️ $state( \($name\))]($style) ";
          style = "bold blue";
        };
        
        # 编程语言版本显示 - 简洁模式
        nodejs = {
          format = "via [⬢ $version](bold green) ";
          version_format = "v\${raw}";
        };
        
        python = {
          format = "via [🐍 $version](bold yellow) ";
          version_format = "v\${raw}";
        };
        
        rust = {
          format = "via [🦀 $version](bold red) ";
          version_format = "v\${raw}";
        };
        
        # 右侧提示符 - 时间戳
        right_format = "$time";
        time = {
          disabled = false;
          format = "[$time]($style)";
          style = "bold yellow";
          time_format = "%R";
        };
      };
    };
  };
}
