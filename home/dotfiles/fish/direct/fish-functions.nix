{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {

    # 额外的 Fish 函数
    home.file.".config/fish/functions/weather.fish" = {
      text = ''
        function weather --description "Get weather information"
            if test (count $argv) -eq 0
                curl -s "wttr.in/?format=3"
            else
                curl -s "wttr.in/$argv[1]?format=3"
            end
        end
      '';
    };

    home.file.".config/fish/functions/ports.fish" = {
      text = ''
        function ports --description "Show open ports"
            if command -v netstat >/dev/null
                netstat -tuln
            else if command -v ss >/dev/null
                ss -tuln
            else
                echo "Neither netstat nor ss is available"
            end
        end
      '';
    };

    home.file.".config/fish/functions/myip.fish" = {
      text = ''
        function myip --description "Show IP addresses"
            echo "本地 IP:"
            ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1
            echo ""
            echo "公网 IP:"
            curl -s ifconfig.me 2>/dev/null || echo "无法获取公网 IP"
        end
      '';
    };

    home.file.".config/fish/functions/backup.fish" = {
      text = ''
        function backup --description "Create backup of a file or directory"
            if test (count $argv) -ne 1
                echo "Usage: backup <file_or_directory>"
                return 1
            end

            set item $argv[1]
            set timestamp (date +%Y%m%d_%H%M%S)
            set backup_name "$item.backup_$timestamp"

            if test -e "$item"
                cp -r "$item" "$backup_name"
                echo "已创建备份: $backup_name"
            else
                echo "错误: '$item' 不存在"
                return 1
            end
        end
      '';
    };

    home.file.".config/fish/functions/goto.fish" = {
      text = ''
        function goto --description "Quick directory navigation"
            switch $argv[1]
                case home
                    cd ~
                case config
                    cd ~/.config
                case docs
                    cd ~/Documents
                case down
                    cd ~/Downloads
                case desk
                    cd ~/Desktop
                case tmp
                    cd /tmp
                case "*"
                    echo "Available shortcuts: home, config, docs, down, desk, tmp"
                    return 1
            end
            pwd
        end
      '';
    };

    # Fish 补全配置
    home.file.".config/fish/completions/goto.fish" = {
      text = ''
        complete -c goto -x -a "home config docs down desk tmp" -d "Quick directory shortcuts"
      '';
    };
  };
}
