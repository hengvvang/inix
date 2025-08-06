{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "direct") {

    home.file.".config/starship.toml" = {
      text = ''
        # Starship 提示符配置
        # 配置方式: direct - 直接文件配置

        # 等待超时时间
        command_timeout = 1000

        # 格式配置
        format = """
        [╭─$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$python$nodejs$rust$golang$java$kotlin$haskell$swift$julia$memory_usage$battery$time
        [╰─$character](bold green)"""

        # 右侧格式
        right_format = """$all"""

        # 用户名
        [username]
        style_user = "green bold"
        style_root = "red bold"
        format = "[$user]($style) "
        disabled = false
        show_always = true

        # 主机名
        [hostname]
        ssh_only = false
        format = "on [$hostname](bold blue) "
        trim_at = ".companyname.com"
        disabled = false

        # 目录
        [directory]
        style = "purple"
        truncation_length = 0
        truncate_to_repo = true
        format = "in [$path]($style)[$read_only]($read_only_style) "

        # Git 分支
        [git_branch]
        symbol = " "
        format = "on [$symbol$branch]($style) "
        style = "bright-black"

        # Git 状态
        [git_status]
        format = '([\[$all_status$ahead_behind\]]($style) )'
        style = "cyan"

        # 命令执行时间
        [cmd_duration]
        format = "took [$duration]($style) "
        style = "yellow"

        # 字符提示符
        [character]
        success_symbol = "[➜](bold green)"
        error_symbol = "[➜](bold red)"

        # 内存使用
        [memory_usage]
        disabled = false
        threshold = 70
        style = "bold dimmed red"
        symbol = " "

        # 电池
        [battery]
        full_symbol = " "
        charging_symbol = " "
        discharging_symbol = " "
        unknown_symbol = " "
        empty_symbol = " "

        [[battery.display]]
        threshold = 15
        style = "bold red"

        [[battery.display]]
        threshold = 50
        style = "bold yellow"

        [[battery.display]]
        threshold = 80
        style = "bold green"

        # 时间
        [time]
        disabled = false
        format = '🕙[$time]($style) '
        time_format = "%R"
        style = "bright-white"
      '';
      target = ".config/starship.toml";
      force = true;
    };
  };
}
