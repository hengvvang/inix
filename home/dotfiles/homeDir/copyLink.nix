{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.bash.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.bash.copyLink.packageSource == "nixpkgs" then (with pkgs; [ bash ]) else [];

      home.file = {
        ".bashrc".source = ./.bashrc;
        ".bash_profile".source = ./.bash_profile;
        ".bash_aliases".source = ./.bash_aliases;
        ".bash_functions".source = ./.bash_functions;
      };
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.zsh.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zsh.copyLink.packageSource == "nixpkgs" then (with pkgs; [ zsh ]) else [];

      home.file = {
        ".zshrc".source = ./.zshrc;
        ".zprofile".source = ./.zprofile;
        ".zlogin".source = ./.zlogin;
        ".zshenv".source = ./.zshenv;
        ".zlogout".source = ./.zlogout;
      };
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.vim.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vim.copyLink.packageSource == "nixpkgs" then (with pkgs; [ vim ]) else [];

      home.file.".vimrc".source = ./.vimrc;
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.fish.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.fish.copyLink.packageSource == "nixpkgs" then (with pkgs; [ fish ]) else [];

      xdg.configFile = {
        "fish/config.fish".source = ./.config/fish/config.fish;
        "fish/completions".source = ./.config/fish/completions;
        "fish/conf.d".source = ./.config/fish/conf.d;
        "fish/functions".source = ./.config/fish/functions;
      };
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.nushell.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.nushell.copyLink.packageSource == "nixpkgs" then (with pkgs; [ nushell ]) else [];

      xdg.configFile = {
        "nushell/env.nu".source = ./.config/nushell/env.nu;
        "nushell/config.nu".source = ./.config/nushell/config.nu;
      };
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.starship.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.starship.copyLink.packageSource == "nixpkgs" then (with pkgs; [ starship ]) else [];
      xdg.configFile."starship.toml".source = ./.config/starship.toml;
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.alacritty.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.alacritty.copyLink.packageSource == "nixpkgs" then (with pkgs; [ alacritty ]) else [];

      xdg.configFile = {
        "alacritty/alacritty.toml".source = ./.config/alacritty/alacritty.toml;
        "alacritty/themes".source = ./.config/alacritty/themes;
      };
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.ghostty.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.ghostty.copyLink.packageSource == "nixpkgs" then (with pkgs; [ ghostty ]) else [];

      xdg.configFile = {
        "ghostty/config".source = ./.config/ghostty/config;
        "ghostty/themes".source = ./.config/ghostty/themes;
      };
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.rio.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rio.copyLink.packageSource == "nixpkgs" then (with pkgs; [ rio ]) else [];

      xdg.configFile = {
        "rio/config.toml".source = ./.config/rio/config.toml;
        "rio/themes".source = ./.config/rio/themes;
      };
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.git.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.git.copyLink.packageSource == "nixpkgs" then (with pkgs; [ git ]) else [];

      xdg.configFile = {
        "git/config".source = ./.config/git/gitconfig;
        "git/ignore".source = ./.config/git/gitignore_global;
      };
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.lazygit.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.lazygit.copyLink.packageSource == "nixpkgs" then (with pkgs; [ lazygit ]) else [];

      xdg.configFile."lazygit/config.yml".source = ./.config/lazygit/config.yml;
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.tmux.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.tmux.copyLink.packageSource == "nixpkgs" then (with pkgs; [ tmux ]) else [];

      xdg.configFile = {
        "tmux/tmux.conf".source = ./.config/tmux/tmux.conf;
        "tmux/plugins".source = ./.config/tmux/plugins;
      };
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.zellij.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zellij.copyLink.packageSource == "nixpkgs" then (with pkgs; [ zellij ]) else [];

      xdg.configFile = {
        "zellij/config.kdl".source = ./.config/zellij/config.kdl;
        "zellij/layouts".source = ./.config/zellij/layouts;
        "zellij/themes".source = ./.config/zellij/themes;
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.rofi.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rofi.copyLink.packageSource == "nixpkgs" then (with pkgs; [ rofi ]) else [];

      xdg.configFile = {
        "rofi/config.rasi".source = ./.config/rofi/config.rasi;
        "rofi/themes".source = ./.config/rofi/themes;
        "rofi/scripts".source = ./.config/rofi/scripts;
      };
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.sherlock.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.sherlock.copyLink.packageSource == "nixpkgs" then (with pkgs; [ sherlock ]) else [];

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
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.rmpc.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rmpc.copyLink.packageSource == "nixpkgs" then (with pkgs; [ rmpc ]) else [];

      xdg.configFile."rmpc/config.toml".source = ./.config/rmpc/config.toml;
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.yazi.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.yazi.copyLink.packageSource == "nixpkgs" then (with pkgs; [ yazi ]) else [];

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
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.qutebrowser.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.qutebrowser.copyLink.packageSource == "nixpkgs" then (with pkgs; [ qutebrowser ]) else [];

      xdg.configFile."qutebrowser/config.py".source = ./.config/qutebrowser/config.py;
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.obs-studio.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.obs-studio.copyLink.packageSource == "nixpkgs" then (with pkgs; [ obs-studio ]) else [];

      xdg.configFile."obs-studio/README.md".source = ./.config/obs-studio/README.md;
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.vscode.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vscode.copyLink.packageSource == "nixpkgs" then (with pkgs; [ vscode ]) else [];

      xdg.configFile."Code/User/settings.json".source = ./.config/Code/User/settings.json;
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.copyLink.enable) {
      home.packages =
        if config.myHome.dotfiles.zed.copyLink.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zed.copyLink.packageSource == "nixpkgs" then (with pkgs; [ zed-editor ]) else [];

      xdg.configFile."zed/settings.json".source = ./.config/zed/settings.json;
    })
  ];
}
