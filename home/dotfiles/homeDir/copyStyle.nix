{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.configStyle == "copyFiles") {
      home.packages = [ pkgs.bash ];
      home.file = {
        ".bashrc".source = ./.bashrc;
        ".bash_profile".source = ./.bash_profile;
        ".bash_aliases".source = ./.bash_aliases;
        ".bash_functions".source = ./.bash_functions;
      };
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.configStyle == "copyFiles") {
      home.packages = [ pkgs.zsh ];
      home.file = {
        ".zshrc".source = ./.zshrc;
        ".zprofile".source = ./.zprofile;
        ".zlogin".source = ./.zlogin;
        ".zshenv".source = ./.zshenv;
        ".zlogout".source = ./.zlogout;
      };
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.configStyle == "copyFiles") {
      home.packages = [ pkgs.vim ];
      home.file.".vimrc".source = ./.vimrc;
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.configStyle == "copyFiles") {
      home.packages = [ pkgs.fish ];
      xdg.configFile = {
        "fish/config.fish".source = ./.config/fish/config.fish;
        "fish/completions".source = ./.config/fish/completions;
        "fish/conf.d".source = ./.config/fish/conf.d;
        "fish/functions".source = ./.config/fish/functions;
      };
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.configStyle == "copyFiles") {
      home.packages = [ pkgs.nushell ];
      xdg.configFile = {
        "nushell/env.nu".source = ./.config/nushell/env.nu;
        "nushell/config.nu".source = ./.config/nushell/config.nu;
      };
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.configStyle == "copyFiles") {
      home.packages = [ pkgs.starship ];
      xdg.configFile."starship.toml".source = ./.config/starship.toml;
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && config.myHome.dotfiles.alacritty.configStyle == "copyFiles") {
      home.packages = [ pkgs.alacritty ];
      xdg.configFile = {
        "alacritty/alacritty.toml".source = ./.config/alacritty/alacritty.toml;
        "alacritty/themes".source = ./.config/alacritty/themes;
      };
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.configStyle == "copyFiles") {
      home.packages = [ pkgs.ghostty ];
      xdg.configFile = {
        "ghostty/config".source = ./.config/ghostty/config;
        "ghostty/themes".source = ./.config/ghostty/themes;
      };
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.configStyle == "copyFiles") {
      home.packages = [ pkgs.rio ];
      xdg.configFile = {
        "rio/config.toml".source = ./.config/rio/config.toml;
        "rio/themes".source = ./.config/rio/themes;
      };
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.configStyle == "copyFiles") {
      home.packages = [ pkgs.git ];
      xdg.configFile = {
        "git/config".source = ./.config/git/gitconfig;
        "git/ignore".source = ./.config/git/gitignore_global;
      };
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.configStyle == "copyFiles") {
      home.packages = [ pkgs.lazygit ];
      xdg.configFile."lazygit/config.yml".source = ./.config/lazygit/config.yml;
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.configStyle == "copyFiles") {
      home.packages = [ pkgs.tmux ];
      xdg.configFile = {
        "tmux/tmux.conf".source = ./.config/tmux/tmux.conf;
        "tmux/plugins".source = ./.config/tmux/plugins;
      };
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.configStyle == "copyFiles") {
      home.packages = [ pkgs.zellij ];
      xdg.configFile = {
        "zellij/config.kdl".source = ./.config/zellij/config.kdl;
        "zellij/layouts".source = ./.config/zellij/layouts;
        "zellij/themes".source = ./.config/zellij/themes;
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.configStyle == "copyFiles") {
      home.packages = [ pkgs.rofi ];
      xdg.configFile = {
        "rofi/config.rasi".source = ./.config/rofi/config.rasi;
        "rofi/themes".source = ./.config/rofi/themes;
        "rofi/scripts".source = ./.config/rofi/scripts;
      };
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.configStyle == "copyFiles") {
      home.packages = [ pkgs.sherlock ];
      xdg.configFile = {
        "sherlock/config.toml".source = ./.config/sherlock/config.toml;
        "sherlock/fallback.json".source = ./.config/sherlock/fallback.json;
        "sherlock/icons".source = ./.config/sherlock/icons;
        "sherlock/scripts".source = ./.config/sherlock/scripts;
        "sherlock/sherlock_actions.json".source = ./.config/sherlock/sherlock_actions.json;
        "sherlock/sherlock_alias.json".source = ./.config/sherlock/sherlock_alias.json;
        "sherlock/sherlockignore".source = ./.config/sherlock/sherlockignore;
        "sherlock/themes".source = ./.config/sherlock/themes;
      };
    })

    # RMPC 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.configStyle == "copyFiles") {
      home.packages = [ pkgs.rmpc ];
      xdg.configFile."rmpc/config.toml".source = ./.config/rmpc/config.toml;
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.configStyle == "copyFiles") {
      home.packages = [ pkgs.yazi ];
      xdg.configFile = {
        "yazi/yazi.toml".source = ./.config/yazi/yazi.toml;
        "yazi/keymap.toml".source = ./.config/yazi/keymap.toml;
        "yazi/theme.toml".source = ./.config/yazi/theme.toml;
        "yazi/init.lua".source = ./.config/yazi/init.lua;
        "yazi/plugins".source = ./.config/yazi/plugins;
        "yazi/flavors".source = ./.config/yazi/flavors;
      };
    })

    # Qutebrowser 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.configStyle == "copyFiles") {
      home.packages = [ pkgs.qutebrowser ];
      xdg.configFile."qutebrowser/config.py".source = ./.config/qutebrowser/config.py;
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.configStyle == "copyFiles") {
      home.packages = [ pkgs.obs-studio ];
      xdg.configFile."obs-studio/README.md".source = ./.config/obs-studio/README.md;
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.configStyle == "copyFiles") {
      home.packages = [ pkgs.vscode ];
      xdg.configFile."Code/User/settings.json".source = ./.config/Code/User/settings.json;
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.configStyle == "copyFiles") {
      home.packages = [ pkgs.zed-editor ];
      xdg.configFile."zed/settings.json".source = ./.config/zed/settings.json;
    })

    # Vicinae 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vicinae.enable && config.myHome.dotfiles.vicinae.configStyle == "copyFiles") {
      home.packages = with pkgs; [
        vicinae       # 现代化应用启动器
        lxgw-wenkai   # 霞鹜文楷字体,用于中文显示
      ];
      xdg.configFile."vicinae/settings.json".source = ./.config/vicinae/settings.json;
    })
  ];
}
