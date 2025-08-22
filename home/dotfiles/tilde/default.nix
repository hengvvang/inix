{ config, lib, pkgs, ... }:

{
  imports = [
    ../options.nix  # 引用上级目录的统一选项定义
  ];

  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.bash.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.bash.packageSource == "nixpkgs" then (with pkgs; [ bash ]) else [];

      home.file.".bashrc".source = ./.bashrc;
      home.file.".bash_profile".source = ./.bash_profile;
      home.file.".bash_aliases".source = ./.bash_aliases;
      home.file.".bash_functions".source = ./.bash_functions;
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.zsh.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zsh.packageSource == "nixpkgs" then (with pkgs; [ zsh ]) else [];

      home.file.".zshrc".source = ./.zshrc;
      home.file.".zprofile".source = ./.zprofile;
      home.file.".zlogin".source = ./.zlogin;
      home.file.".zshenv".source = ./.zshenv;
      home.file.".zlogout".source = ./.zlogout;
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.vim.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vim.packageSource == "nixpkgs" then (with pkgs; [ vim ]) else [];

      home.file.".vimrc".source = ./.vimrc;
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.fish.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.fish.packageSource == "nixpkgs" then (with pkgs; [ fish ]) else [];

      home.file.".config/fish/config.fish".source = ./.config/fish/config.fish;
      home.file.".config/fish/completions".source = ./.config/fish/completions;
      home.file.".config/fish/conf.d".source = ./.config/fish/conf.d;
      home.file.".config/fish/functions".source = ./.config/fish/functions;
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.nushell.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.nushell.packageSource == "nixpkgs" then (with pkgs; [ nushell ]) else [];

      # Nushell 配置文件通常在 ~/.config/nushell/ 目录下
      home.file.".config/nushell/config.nu".source = ./.config/nushell/config.nu;
      home.file.".config/nushell/env.nu".source = ./.config/nushell/env.nu;
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.starship.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.starship.packageSource == "nixpkgs" then (with pkgs; [ starship ]) else [];

      home.file.".config/starship.toml".source = ./.config/starship.toml;
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && config.myHome.dotfiles.alacritty.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.alacritty.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.alacritty.packageSource == "nixpkgs" then (with pkgs; [ alacritty ]) else [];

      home.file.".config/alacritty/alacritty.toml".source = ./.config/alacritty/alacritty.toml;
      home.file.".config/alacritty/themes".source = ./.config/alacritty/themes;
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.ghostty.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.ghostty.packageSource == "nixpkgs" then (with pkgs; [ ghostty ]) else [];

      home.file.".config/ghostty/config".source = ./.config/ghostty/config;
      home.file.".config/ghostty/themes".source = ./.config/ghostty/themes;
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.rio.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rio.packageSource == "nixpkgs" then (with pkgs; [ rio ]) else [];

      home.file.".config/rio/config.toml".source = ./.config/rio/config.toml;
      home.file.".config/rio/themes".source = ./.config/rio/themes;
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.git.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.git.packageSource == "nixpkgs" then (with pkgs; [ git ]) else [];

      home.file.".config/git/config".source = ./.config/git/gitconfig;
      home.file.".config/git/ignore".source = ./.config/git/gitignore_global;
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.lazygit.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.lazygit.packageSource == "nixpkgs" then (with pkgs; [ lazygit ]) else [];

      home.file.".config/lazygit/config.yml".source = ./.config/lazygit/config.yml;
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.tmux.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.tmux.packageSource == "nixpkgs" then (with pkgs; [ tmux ]) else [];

      home.file.".config/tmux/tmux.conf".source = ./.config/tmux/tmux.conf;
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.zellij.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zellij.packageSource == "nixpkgs" then (with pkgs; [ zellij ]) else [];

      home.file.".config/zellij/config.kdl".source = ./.config/zellij/config.kdl;
      home.file.".config/zellij/layouts".source = ./.config/zellij/layouts;
      home.file.".config/zellij/themes".source = ./.config/zellij/themes;
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.rofi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rofi.packageSource == "nixpkgs" then (with pkgs; [ rofi ]) else [];

      home.file.".config/rofi/config.rasi".source = ./.config/rofi/config.rasi;
      home.file.".config/rofi/scripts".source = ./.config/rofi/scripts;
      home.file.".config/rofi/themes".source = ./.config/rofi/themes;
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.sherlock.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.sherlock.packageSource == "nixpkgs" then (with pkgs; [ sherlock ]) else [];

      home.file.".config/sherlock/config.toml".source = ./.config/sherlock/config.toml;
      home.file.".config/sherlock/fallback.json".source = ./.config/sherlock/fallback.json;
      home.file.".config/sherlock/icons".source = ./.config/sherlock/icons;
      home.file.".config/sherlock/scripts".source = ./.config/sherlock/scripts;
      home.file.".config/sherlock/sherlock_actions.json".source = ./.config/sherlock/sherlock_actions.json;
      home.file.".config/sherlock/sherlock_alias.json".source = ./.config/sherlock/sherlock_alias.json;
      home.file.".config/sherlock/sherlockignore".source = ./.config/sherlock/sherlockignore;
      home.file.".config/sherlock/themes".source = ./.config/sherlock/themes;
    })

    # RMPC 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.rmpc.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rmpc.packageSource == "nixpkgs" then (with pkgs; [ rmpc ]) else [];

      home.file.".config/rmpc/config.toml".source = ./.config/rmpc/config.toml;
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.yazi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.yazi.packageSource == "nixpkgs" then (with pkgs; [ yazi ]) else [];

      home.file.".config/yazi/yazi.toml".source = ./.config/yazi/yazi.toml;
      home.file.".config/yazi/keymap.toml".source = ./.config/yazi/keymap.toml;
      home.file.".config/yazi/theme.toml".source = ./.config/yazi/theme.toml;
    })

    # Qutebrowser 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.qutebrowser.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.qutebrowser.packageSource == "nixpkgs" then (with pkgs; [ qutebrowser ]) else [];

      home.file.".config/qutebrowser/config.py".source = ./.config/qutebrowser/config.py;
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.obs-studio.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.obs-studio.packageSource == "nixpkgs" then (with pkgs; [ obs-studio ]) else [];

      home.file.".config/obs-studio/README.md".source = ./.config/obs-studio/README.md;
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.vscode.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vscode.packageSource == "nixpkgs" then (with pkgs; [ vscode ]) else [];

      home.file.".config/Code/User/settings.json".source = ./.config/Code/User/settings.json;
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "copyLink") {
      home.packages =
        if config.myHome.dotfiles.zed.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zed.packageSource == "nixpkgs" then (with pkgs; [ zed-editor ]) else [];

      home.file.".config/zed/settings.json".source = ./.config/zed/settings.json;
    })
  ];
}
