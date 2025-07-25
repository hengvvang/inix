{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "direct") {
    
    home.packages = with pkgs; [ starship ];

    home.file.".config/starship.toml".text = ''
      # Starship 配置 - 直接文件写入方式
      
      # 全局设置
      format = """
      $os\
      $username\
      $hostname\
      $directory\
      $git_branch\
      $git_state\
      $git_status\
      $git_metrics\
      $fill\
      $nodejs\
      $python\
      $rust\
      $golang\
      $java\
      $kotlin\
      $haskell\
      $swift\
      $nix_shell\
      $memory_usage\
      $aws\
      $gcloud\
      $openstack\
      $azure\
      $env_var\
      $crystal\
      $custom\
      $sudo\
      $cmd_duration\
      $line_break\
      $jobs\
      $battery\
      $time\
      $status\
      $container\
      $shell\
      $character\
      """
      
      right_format = ""
      scan_timeout = 30
      command_timeout = 500
      add_newline = true
      
      # 字符设置
      [character]
      success_symbol = "[❯](bold green)"
      error_symbol = "[❯](bold red)"
      vimcmd_symbol = "[❮](bold green)"
      
      # 目录显示
      [directory]
      style = "cyan bold"
      truncation_length = 3
      truncate_to_repo = true
      fish_style_pwd_dir_length = 1
      use_logical_path = true
      format = "[$path]($style)[$read_only]($read_only_style) "
      read_only = " 󰌾"
      read_only_style = "red"
      truncation_symbol = "…/"
      home_symbol = "~"
      repo_root_style = "bold blue"
      repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) "
      
      # Git 配置
      [git_branch]
      symbol = " "
      style = "purple bold"
      format = "on [$symbol$branch(:$remote_branch)]($style) "
      truncation_length = 20
      truncation_symbol = "…"
      only_attached = false
      
      [git_status]
      style = "red bold"
      format = "([$all_status$ahead_behind]($style))"
      conflicted = "🏳"
      up_to_date = " "
      untracked = " "
      ahead = "⇡''${count}"
      diverged = "⇕⇡''${ahead_count}⇣''${behind_count}"
      behind = "⇣''${count}"
      stashed = " "
      modified = " "
      staged = "[++($count)](green)"
      renamed = "襁 "
      deleted = " "
      
      [git_state]
      format = '\([$state( $progress_current/$progress_total)]($style)\) '
      style = "bright-black"
      
      [git_metrics]
      added_style = "bold blue"
      deleted_style = "bold red"
      only_nonzero_diffs = true
      format = "([+$added]($added_style) )([-$deleted]($deleted_style) )"
      disabled = false
      
      # 命令持续时间
      [cmd_duration]
      min_time = 2000
      format = "took [$duration]($style) "
      style = "yellow bold"
      show_milliseconds = false
      disabled = false
      show_notifications = false
      min_time_to_notify = 45000
      
      # 时间显示
      [time]
      disabled = false
      format = "at [$time]($style) "
      style = "bright-white"
      use_12hr = false
      time_format = "%T"
      utc_time_offset = "local"
      time_range = "-"
      
      # 用户名
      [username]
      style_user = "green bold"
      style_root = "red bold"
      format = "[$user]($style) "
      disabled = false
      show_always = false
      
      # 主机名
      [hostname]
      ssh_only = true
      format = "on [$hostname]($style) "
      style = "green dimmed bold"
      disabled = false
      
      # 操作系统
      [os]
      format = "[$symbol]($style)"
      style = "bold white"
      disabled = false
      
      [os.symbols]
      Alpaquita = "🔔 "
      Alpine = "🏔️ "
      Amazon = "🙂 "
      Android = "🤖 "
      Arch = "🎗️ "
      Artix = "🎗️ "
      CentOS = "💠 "
      Debian = "🌀 "
      DragonFly = "🐉 "
      Emscripten = "🔗 "
      EndeavourOS = "🚀 "
      Fedora = "🎩 "
      FreeBSD = "😈 "
      Garuda = "🦅 "
      Gentoo = "🗜️ "
      HardenedBSD = "🛡️ "
      Illumos = "🐦 "
      Linux = "🐧 "
      Mabox = "📦 "
      Macos = "🍎 "
      Manjaro = "🥭 "
      Mariner = "🌊 "
      MidnightBSD = "🌘 "
      Mint = "🌿 "
      NetBSD = "🚩 "
      NixOS = "❄️ "
      OpenBSD = "🐡 "
      OpenCloudOS = "☁️ "
      openEuler = "🦉 "
      openSUSE = "🦎 "
      OracleLinux = "🦴 "
      Pop = "🍭 "
      Raspbian = "🍓 "
      Redhat = "🎩 "
      RedHatEnterprise = "🎩 "
      Redox = "🧪 "
      Solus = "⛵ "
      SUSE = "🦎 "
      Ubuntu = "🎯 "
      Unknown = "❓ "
      Windows = "🪟 "
      
      # 编程语言
      [nodejs]
      format = "via [⬢ $version](bold green) "
      detect_extensions = ["js", "mjs", "cjs", "ts", "mts", "cts"]
      detect_files = ["package.json", ".node-version", ".nvmrc"]
      detect_folders = ["node_modules"]
      style = "bold green"
      disabled = false
      not_capable_style = "bold red"
      
      [python]
      symbol = "🐍 "
      pyenv_version_name = false
      format = 'via [''${symbol}''${pyenv_prefix}(''${version} )(\($virtualenv\) )]($style)'
      style = "yellow bold"
      pyenv_prefix = "pyenv "
      python_binary = ["python", "python3", "python2"]
      detect_extensions = ["py"]
      detect_files = [
        "requirements.txt",
        ".python-version",
        "pyproject.toml",
        "Pipfile",
        "tox.ini",
        "setup.py",
        "__init__.py",
      ]
      detect_folders = []
      disabled = false
      
      [rust]
      format = "via [⚙️ $version](red bold) "
      version_format = "v''${raw}"
      symbol = "⚙️ "
      style = "bold red"
      disabled = false
      detect_extensions = ["rs"]
      detect_files = ["Cargo.toml"]
      detect_folders = []
      
      [golang]
      format = "via [🐹 $version](cyan bold) "
      version_format = "v''${raw}"
      symbol = "🐹 "
      style = "bold cyan"
      disabled = false
      detect_extensions = ["go"]
      detect_files = [
        "go.mod",
        "go.sum",
        "go.work",
        "glide.yaml",
        "Gopkg.yml",
        "Gopkg.lock",
        ".go-version",
      ]
      detect_folders = ["Godeps"]
      
      [java]
      symbol = "☕ "
      style = "red dimmed"
      format = "via [''${symbol}(''${version} )]($style)"
      version_format = "v''${raw}"
      disabled = false
      detect_extensions = ["java", "class", "jar", "gradle", "clj", "cljc"]
      detect_files = [
        "pom.xml",
        "build.gradle.kts",
        "build.sbt",
        ".java-version",
        "deps.edn",
        "project.clj",
        "build.boot",
        ".sdkmanrc",
      ]
      detect_folders = []
      
      # Nix Shell
      [nix_shell]
      format = "via [❄️ $state( \\($name\\))]($style) "
      style = "bold blue"
      impure_msg = "[impure shell](bold red)"
      pure_msg = "[pure shell](bold green)"
      unknown_msg = "[unknown shell](bold yellow)"
      disabled = false
      heuristic = false
      
      # 内存使用
      [memory_usage]
      disabled = false
      threshold = -1
      symbol = "🐏"
      style = "bold dimmed green"
      format = "via $symbol [''${ram}( | ''${swap})]($style) "
      
      # 状态
      [status]
      style = "red bold"
      symbol = "✖"
      success_symbol = ""
      not_executable_symbol = "🚫"
      not_found_symbol = "🔍"
      sigint_symbol = "🧱"
      signal_symbol = "⚡"
      format = "[$symbol$status]($style) "
      map_symbol = false
      disabled = false
      recognize_signal_code = true
      pipestatus = false
      pipestatus_separator = "|"
      pipestatus_format = '\[$pipestatus\] => [$symbol$common_meaning$signal_name$maybe_int]($style)'
      
      # Shell
      [shell]
      fish_indicator = "🐠"
      powershell_indicator = "🪟"
      unknown_indicator = "❓"
      style = "cyan bold"
      disabled = false
      format = "$indicator "
      
      # 任务
      [jobs]
      threshold = 1
      symbol_threshold = 1
      number_threshold = 2
      format = "[$symbol$number]($style) "
      symbol = "✦"
      style = "bold blue"
      disabled = false
      
      # 电池
      [battery]
      full_symbol = "🔋 "
      charging_symbol = "⚡️ "
      discharging_symbol = "💀 "
      unknown_symbol = "❓ "
      empty_symbol = "❗ "
      format = "[$symbol$percentage]($style) "
      disabled = false
      
      [[battery.display]]
      threshold = 10
      style = "bold red"
      
      [[battery.display]]
      threshold = 30
      style = "bold yellow"
      
      # 填充符
      [fill]
      symbol = " "
      style = "bold black"
      disabled = false
      
      # sudo
      [sudo]
      style = "bold red"
      symbol = "🧙 "
      disabled = false
      format = "[as $symbol]($style)"
      
      # 容器
      [container]
      format = "[$symbol \\[$name\\]]($style) "
      symbol = "⬢"
      style = "red bold dimmed"
      disabled = false
    '';
  };
}
