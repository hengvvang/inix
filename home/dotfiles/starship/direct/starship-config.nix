{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "direct") {
    home.file.".config/starship.toml" = {
      text = ''
        # Starship 直接配置 - Direct Method
        # 简化版配置，避免 Nix 字符串转义问题

        # === 基础配置 ===
        add_newline = true
        command_timeout = 500
        scan_timeout = 30

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

        # === Git 分支配置 ===
        [git_branch]
        symbol = " "
        style = "bright-yellow"

        # === Git 状态配置 ===
        [git_status]
        style = "cyan"
        conflicted = "🏳"
        up_to_date = " "
        untracked = " "
        stashed = " "
        modified = " "
        renamed = "襁"
        deleted = " "

        # === 主机名配置 ===
        [hostname]
        ssh_only = false
        style = "bold red"
        disabled = false

        # === 时间配置 ===
        [time]
        disabled = false
        time_format = "%T"
        utc_time_offset = "+8"
        style = "bright-white"

        # === 命令执行时间配置 ===
        [cmd_duration]
        min_time = 2_000
        style = "bold yellow"
        disabled = false

        # === 编程语言配置 ===
        [nodejs]
        symbol = " "
        style = "green"

        [python]
        symbol = " "
        style = "yellow"

        [rust]
        symbol = " "
        style = "red"

        [golang]
        symbol = " "
        style = "cyan"

        [java]
        symbol = " "
        style = "red"

        # === Docker 配置 ===
        [docker_context]
        symbol = " "
        style = "blue"

        # === 包管理器配置 ===
        [package]
        symbol = " "
        style = "yellow"

        # === Nix Shell 配置 ===
        [nix_shell]
        disabled = false
        impure_msg = '[impure shell](bold red)'
        pure_msg = '[pure shell](bold green)'
        symbol = "❄️ "
        style = "blue"

        # === Shell 配置 ===
        [shell]
        fish_indicator = ""
        bash_indicator = " "
        zsh_indicator = " "
        disabled = false

        # === 状态码配置 ===
        [status]
        style = "bg:blue"
        symbol = "🔴"
        disabled = false
      '';
    };
  };
}
