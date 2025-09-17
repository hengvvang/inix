{ config, lib, pkgs, ... }:
let
  # 定义当前目录的绝对路径
  # currentDir = toString ./.;
  currentDir = builtins.getEnv "PWD";
in
{
  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.bash.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.bash.packageSource == "nixpkgs" then (with pkgs; [ bash ]) else [];

      home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bashrc";
      home.file.".bash_profile".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bash_profile";
      home.file.".bash_aliases".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bash_aliases";
      home.file.".bash_functions".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.bash_functions";
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.zsh.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zsh.packageSource == "nixpkgs" then (with pkgs; [ zsh ]) else [];

      home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zshrc";
      home.file.".zprofile".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zprofile";
      home.file.".zlogin".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zlogin";
      home.file.".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zshenv";
      home.file.".zlogout".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.zlogout";
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.vim.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vim.packageSource == "nixpkgs" then (with pkgs; [ vim ]) else [];

      home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.vimrc";
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.fish.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.fish.packageSource == "nixpkgs" then (with pkgs; [ fish ]) else [];

      xdg.configFile = {
        "fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/config.fish";
        "fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/completions";
        "fish/conf.d".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/conf.d";
        "fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/fish/functions";
      };
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.nushell.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.nushell.packageSource == "nixpkgs" then (with pkgs; [ nushell ]) else [];

      xdg.configFile = {
        "nushell/config.nu".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/nushell/config.nu";
        "nushell/env.nu".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/nushell/env.nu";
      };
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.starship.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.starship.packageSource == "nixpkgs" then (with pkgs; [ starship ]) else [];

      xdg.configFile."starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/starship.toml";
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && config.myHome.dotfiles.alacritty.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.alacritty.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.alacritty.packageSource == "nixpkgs" then (with pkgs; [ alacritty ]) else [];

      xdg.configFile = {
        "alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/alacritty/alacritty.toml";
        "alacritty/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/alacritty/themes";
      };
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.ghostty.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.ghostty.packageSource == "nixpkgs" then (with pkgs; [ ghostty ]) else [];

      xdg.configFile = {
        "ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ghostty/config";
        "ghostty/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/ghostty/themes";
      };
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.rio.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rio.packageSource == "nixpkgs" then (with pkgs; [ rio ]) else [];

      xdg.configFile = {
        "rio/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rio/config.toml";
        "rio/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rio/themes";
      };
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.git.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.git.packageSource == "nixpkgs" then (with pkgs; [ git ]) else [];

      xdg.configFile = {
        "git/config".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/git/gitconfig";
        "git/ignore".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/git/gitignore_global";
      };
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.lazygit.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.lazygit.packageSource == "nixpkgs" then (with pkgs; [ lazygit ]) else [];

      xdg.configFile."lazygit/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/lazygit/config.yml";
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.tmux.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.tmux.packageSource == "nixpkgs" then (with pkgs; [ tmux ]) else [];

      xdg.configFile."tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/tmux/tmux.conf";
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.zellij.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zellij.packageSource == "nixpkgs" then (with pkgs; [ zellij ]) else [];

      xdg.configFile = {
        "zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zellij/config.kdl";
        "zellij/layouts".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zellij/layouts";
        "zellij/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zellij/themes";
      };
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.rofi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rofi.packageSource == "nixpkgs" then (with pkgs; [ rofi ]) else [];

      xdg.configFile = {
        "rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/config.rasi";
        "rofi/scripts".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/scripts";
        "rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rofi/themes";
      };
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.sherlock.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.sherlock.packageSource == "nixpkgs" then (with pkgs; [ sherlock ]) else [];

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
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.rmpc.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rmpc.packageSource == "nixpkgs" then (with pkgs; [ rmpc ]) else [];

      xdg.configFile."rmpc/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/rmpc/config.toml";
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.yazi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.yazi.packageSource == "nixpkgs" then (with pkgs; [ yazi ]) else [];

      xdg.configFile = {
        "yazi/yazi.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/yazi/yazi.toml";
        "yazi/keymap.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/yazi/keymap.toml";
        "yazi/theme.toml".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/yazi/theme.toml";
      };
    })

    # Qutebrowser 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.qutebrowser.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.qutebrowser.packageSource == "nixpkgs" then (with pkgs; [ qutebrowser ]) else [];

      xdg.configFile."qutebrowser/config.py".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/qutebrowser/config.py";
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.obs-studio.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.obs-studio.packageSource == "nixpkgs" then (with pkgs; [ obs-studio ]) else [];

      xdg.configFile."obs-studio/README.md".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/obs-studio/README.md";
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.vscode.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vscode.packageSource == "nixpkgs" then (with pkgs; [ vscode ]) else [];

      xdg.configFile."Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/Code/User/settings.json";
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.zed.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zed.packageSource == "nixpkgs" then (with pkgs; [ zed-editor ]) else [];

      xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${currentDir}/.config/zed/settings.json";
    })
  ];
}
