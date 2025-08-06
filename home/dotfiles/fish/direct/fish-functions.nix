{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "direct") {
    # 自定义函数目录
    home.file.".config/fish/functions/fish_prompt.fish" = {
      text = ''
        # 自定义 Fish 提示符函数
        function fish_prompt
            set -l last_status $status
            
            # 显示用户@主机
            set_color cyan
            echo -n (whoami)
            set_color normal
            echo -n '@'
            set_color green
            echo -n (hostname -s)
            set_color normal
            echo -n ':'
            
            # 显示当前目录
            set_color blue
            echo -n (prompt_pwd)
            set_color normal
            
            # 显示 Git 状态（如果在 Git 仓库中）
            if git rev-parse --is-inside-work-tree >/dev/null 2>&1
                set -l git_branch (git branch --show-current 2>/dev/null)
                if test -n "$git_branch"
                    echo -n ' ('
                    set_color yellow
                    echo -n $git_branch
                    set_color normal
                    echo -n ')'
                end
            end
            
            # 显示上一个命令的退出状态
            if test $last_status -ne 0
                set_color red
                echo -n " [$last_status]"
                set_color normal
            end
            
            echo -n '$ '
        end
      '';
    };

    home.file.".config/fish/functions/fish_right_prompt.fish" = {
      text = ''
        # 右侧提示符函数
        function fish_right_prompt
            set_color 555
            echo -n (date '+%H:%M:%S')
            set_color normal
        end
      '';
    };

    home.file.".config/fish/functions/ll.fish" = {
      text = ''
        # 详细列表函数
        function ll
            ls -la $argv
        end
      '';
    };

    home.file.".config/fish/functions/la.fish" = {
      text = ''
        # 显示所有文件函数
        function la
            ls -A $argv
        end
      '';
    };
  };
}
