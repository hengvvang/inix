{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "direct") {
    home.file.".config/starship.toml" = {
      text = ''
        # Starship 直接配置 - Direct Method
        # 这是使用 direct 方式的 Starship 配置示例

        # === 格式配置 ===
        format = """
        [╭─user@](bold blue) $hostname $directory $git_branch $git_status
        [╰─$character ](bold blue)"""

        right_format = "$cmd_duration $time"

        # === 字符配置 ===
        [character]
        success_symbol = "[❯](purple)"
        error_symbol = "[❯](red)"
        vimcmd_symbol = "[❮](green)"

        # === 目录配置 ===
        [directory]
        style = "blue"
        truncation_length = 4
        truncation_symbol = "…/"
        home_symbol = " ~"
        read_only_style = "197"
        read_only = "  "
        format = "at [$path]($style)[$read_only]($read_only_style) "

        # === Git 分支配置 ===
        [git_branch]
        symbol = " "
        format = "on [$symbol$branch]($style) "
        style = "bright-yellow"

        # === Git 状态配置 ===
        [git_status]
        format = '[\($all_status$ahead_behind\)]($style) '
        style = "cyan"
        conflicted = "🏳"
        up_to_date = " "
        untracked = " "
        ahead = "⇡''${count}"
        diverged = "⇕⇡''${ahead_count}⇣''${behind_count}"
        behind = "⇣''${count}"
        stashed = " "
        modified = " "
        staged = '[++\($count\)](green)'
        renamed = "襁"
        deleted = " "

        # === 主机名配置 ===
        [hostname]
        ssh_only = false
        format = "[$hostname](bold red) "
        disabled = false

        # === 时间配置 ===
        [time]
        disabled = false
        format = '🕙[\[ $time \]]($style) '
        time_format = "%T"
        utc_time_offset = "+8"
        style = "bright-white"

        # === 命令执行时间配置 ===
        [cmd_duration]
        min_time = 2_000
        format = "took [$duration](bold yellow)"
        disabled = false

        # === 编程语言配置 ===
        [nodejs]
        symbol = " "
        format = "via [$symbol($version )]($style)"

        [python]
        symbol = " "
        format = 'via [''${symbol}''${pyenv_prefix}(''${version} )(\($virtualenv\) )]($style)'

        [rust]
        symbol = " "
        format = "via [$symbol($version )]($style)"

        [golang]
        symbol = " "
        format = "via [$symbol($version )]($style)"

        [php]
        symbol = " "
        format = "via [$symbol($version )]($style)"

        [java]
        symbol = " "
        format = "via [$symbol($version )]($style)"

        [kotlin]
        symbol = "🅺 "
        format = "via [$symbol($version )]($style)"

        [haskell]
        symbol = " "
        format = "via [$symbol($version )]($style)"

        [swift]
        symbol = "ﯣ "
        format = "via [$symbol($version )]($style)"

        # === Docker 配置 ===
        [docker_context]
        symbol = " "
        format = "via [$symbol$context]($style) "

        # === Kubernetes 配置 ===
        [kubernetes]
        format = 'on [⛵ $context \($namespace\)](dimmed green) '
        disabled = false

        # === AWS 配置 ===
        [aws]
        format = 'on [$symbol($profile )(\($region\) )(\[$duration\])]($style)'
        symbol = "🅰 "

        # === 电池配置 ===
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

        # === 内存使用配置 ===
        [memory_usage]
        disabled = false
        threshold = -1
        symbol = " "
        style = "bold dimmed green"
        format = "via $symbol [''${ram}( | ''${swap})]($style) "

        # === Nix Shell 配置 ===
        [nix_shell]
        disabled = false
        impure_msg = '[impure shell](bold red)'
        pure_msg = '[pure shell](bold green)'
        format = 'via [☃️ $state( \($name\))]($style) '

        # === 包管理器配置 ===
        [package]
        symbol = " "
        format = "is [$symbol$version]($style) "

        # === Conda 配置 ===
        [conda]
        symbol = " "
        format = "via [$symbol$environment]($style) "

        # === 自定义命令 ===
        [custom.giturl]
        command = "timeout 1s git remote get-url origin 2>/dev/null || echo ''"
        when = "git rev-parse --is-inside-work-tree 2>/dev/null"
        style = "bright-yellow"
        format = "at [$output]($style) "

        # === 状态码配置 ===
        [status]
        style = "bg:blue"
        symbol = "🔴"
        format = '[\[$symbol $common_meaning$signal_name$maybe_int\]]($style) '
        map_symbol = true
        disabled = false

        # === Shell 配置 ===
        [shell]
        fish_indicator = ""
        bash_indicator = " "
        zsh_indicator = " "
        format = "$indicator"
        disabled = false
      '';
    };
  };
}
