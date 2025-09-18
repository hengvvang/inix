{ config, lib, pkgs, ... }:
let
  # 使用环境变量或相对路径来避免绝对路径问题
  currentDir = "${config.home.homeDirectory}/config.d/home/dotfiles/homeDir";
in
{
  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.bash.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.bash.realTime.packageSource == "nixpkgs" then (with pkgs; [ bash ]) else [];

      home.file = {
        "bashrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bashrc";
        "bash_profile".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bash_profile";
        "bash_aliases".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bash_aliases";
        "bash_functions".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bash_functions";
      };
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.zsh.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zsh.realTime.packageSource == "nixpkgs" then (with pkgs; [ zsh ]) else [];

      home.file = {
        "zshrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zshrc";
        "zprofile".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zprofile";
        "zlogin".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zlogin";
        "zshenv".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zshenv";
        "zlogout".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zlogout";
      };
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.vim.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vim.realTime.packageSource == "nixpkgs" then (with pkgs; [ vim ]) else [];

      home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.vimrc";
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.fish.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.fish.realTime.packageSource == "nixpkgs" then (with pkgs; [ fish ]) else [];

      xdg.configFile = {
        "fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/config.fish";
        "fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/completions";
        "fish/conf.d".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/conf.d";
        "fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/functions";
      };
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.nushell.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.nushell.realTime.packageSource == "nixpkgs" then (with pkgs; [ nushell ]) else [];

      xdg.configFile = {
        "nushell/config.nu".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/nushell/config.nu";
        "nushell/env.nu".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/nushell/env.nu";
      };
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.starship.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.starship.realTime.packageSource == "nixpkgs" then (with pkgs; [ starship ]) else [];

      xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/starship.toml";
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.alacritty.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.alacritty.realTime.packageSource == "nixpkgs" then (with pkgs; [ alacritty ]) else [];

      xdg.configFile = {
        "alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/alacritty/alacritty.toml";
        "alacritty/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/alacritty/themes";
      };
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.ghostty.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.ghostty.realTime.packageSource == "nixpkgs" then (with pkgs; [ ghostty ]) else [];

      xdg.configFile = {
        "ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ghostty/config";
        "ghostty/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ghostty/themes";
      };
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.rio.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rio.realTime.packageSource == "nixpkgs" then (with pkgs; [ rio ]) else [];

      xdg.configFile = {
        "rio/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rio/config.toml";
        "rio/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rio/themes";
      };
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.git.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.git.realTime.packageSource == "nixpkgs" then (with pkgs; [ git ]) else [];

      xdg.configFile = {
        "git/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/git/gitconfig";
        "git/ignore".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/git/gitignore_global";
      };
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.lazygit.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.lazygit.realTime.packageSource == "nixpkgs" then (with pkgs; [ lazygit ]) else [];

      xdg.configFile."lazygit/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/lazygit/config.yml";
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.tmux.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.tmux.realTime.packageSource == "nixpkgs" then (with pkgs; [ tmux ]) else [];

      xdg.configFile."tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/tmux/tmux.conf";
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.zellij.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zellij.realTime.packageSource == "nixpkgs" then (with pkgs; [ zellij ]) else [];

      xdg.configFile = {
        "zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zellij/config.kdl";
        "zellij/layouts".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zellij/layouts";
        "zellij/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zellij/themes";
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.rofi.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rofi.realTime.packageSource == "nixpkgs" then (with pkgs; [ rofi ]) else [];

      xdg.configFile = {
        "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/config.rasi";
        "rofi/scripts".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/scripts";
        "rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/themes";
      };
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.sherlock.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.sherlock.realTime.packageSource == "nixpkgs" then (with pkgs; [ sherlock ]) else [];

      xdg.configFile = {
        "sherlock/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/config.toml";
        "sherlock/fallback.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/fallback.json";
        "sherlock/icons".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/icons";
        "sherlock/scripts".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/scripts";
        "sherlock/sherlock_actions.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/sherlock_actions.json";
        "sherlock/sherlock_alias.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/sherlock_alias.json";
        "sherlock/sherlockignore".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/sherlockignore";
        "sherlock/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/sherlock/themes";
      };
    })

    # RMPC 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.rmpc.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rmpc.realTime.packageSource == "nixpkgs" then (with pkgs; [ rmpc ]) else [];

      xdg.configFile."rmpc/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rmpc/config.toml";
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.yazi.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.yazi.realTime.packageSource == "nixpkgs" then (with pkgs; [ yazi ]) else [];

      xdg.configFile = {
        "yazi/yazi.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/yazi/yazi.toml";
        "yazi/keymap.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/yazi/keymap.toml";
        "yazi/theme.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/yazi/theme.toml";
      };
    })

    # Qutebrowser 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.qutebrowser.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.qutebrowser.realTime.packageSource == "nixpkgs" then (with pkgs; [ qutebrowser ]) else [];

      xdg.configFile."qutebrowser/config.py".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/qutebrowser/config.py";
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.obs-studio.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.obs-studio.realTime.packageSource == "nixpkgs" then (with pkgs; [ obs-studio ]) else [];

      xdg.configFile."obs-studio/README.md".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/obs-studio/README.md";
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.vscode.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vscode.realTime.packageSource == "nixpkgs" then (with pkgs; [ vscode ]) else [];

      xdg.configFile."Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/Code/User/settings.json";
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.realTime.enable) {
      home.packages =
        if config.myHome.dotfiles.zed.realTime.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zed.realTime.packageSource == "nixpkgs" then (with pkgs; [ zed-editor ]) else [];

      xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zed/settings.json";
    })
  ];
}
