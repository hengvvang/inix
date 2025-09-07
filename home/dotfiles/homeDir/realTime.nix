{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.bash.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.bash.packageSource == "nixpkgs" then (with pkgs; [ bash ]) else [];

      home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.bashrc";
      home.file.".bash_profile".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.bash_profile";
      home.file.".bash_aliases".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.bash_aliases";
      home.file.".bash_functions".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.bash_functions";
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.zsh.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zsh.packageSource == "nixpkgs" then (with pkgs; [ zsh ]) else [];

      home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.zshrc";
      home.file.".zprofile".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.zprofile";
      home.file.".zlogin".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.zlogin";
      home.file.".zshenv".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.zshenv";
      home.file.".zlogout".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.zlogout";
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.vim.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vim.packageSource == "nixpkgs" then (with pkgs; [ vim ]) else [];

      home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.vimrc";
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.fish.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.fish.packageSource == "nixpkgs" then (with pkgs; [ fish ]) else [];

      home.file.".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/fish/config.fish";
      home.file.".config/fish/completions".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/fish/completions";
      home.file.".config/fish/conf.d".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/fish/conf.d";
      home.file.".config/fish/functions".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/fish/functions";
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.nushell.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.nushell.packageSource == "nixpkgs" then (with pkgs; [ nushell ]) else [];

      # Nushell 配置文件通常在 ~/.config/nushell/ 目录下
      home.file.".config/nushell/config.nu".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/nushell/config.nu";
      home.file.".config/nushell/env.nu".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/nushell/env.nu";
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.starship.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.starship.packageSource == "nixpkgs" then (with pkgs; [ starship ]) else [];

      home.file.".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/starship.toml";
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && config.myHome.dotfiles.alacritty.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.alacritty.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.alacritty.packageSource == "nixpkgs" then (with pkgs; [ alacritty ]) else [];

      home.file.".config/alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/alacritty/alacritty.toml";
      home.file.".config/alacritty/themes".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/alacritty/themes";
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.ghostty.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.ghostty.packageSource == "nixpkgs" then (with pkgs; [ ghostty ]) else [];

      home.file.".config/ghostty/config".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/ghostty/config";
      home.file.".config/ghostty/themes".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/ghostty/themes";
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.rio.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rio.packageSource == "nixpkgs" then (with pkgs; [ rio ]) else [];

      home.file.".config/rio/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/rio/config.toml";
      home.file.".config/rio/themes".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/rio/themes";
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.git.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.git.packageSource == "nixpkgs" then (with pkgs; [ git ]) else [];

      home.file.".config/git/config".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/git/gitconfig";
      home.file.".config/git/ignore".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/git/gitignore_global";
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.lazygit.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.lazygit.packageSource == "nixpkgs" then (with pkgs; [ lazygit ]) else [];

      home.file.".config/lazygit/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/lazygit/config.yml";
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.tmux.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.tmux.packageSource == "nixpkgs" then (with pkgs; [ tmux ]) else [];

      home.file.".config/tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/tmux/tmux.conf";
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.zellij.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zellij.packageSource == "nixpkgs" then (with pkgs; [ zellij ]) else [];

      home.file.".config/zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/zellij/config.kdl";
      home.file.".config/zellij/layouts".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/zellij/layouts";
      home.file.".config/zellij/themes".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/zellij/themes";
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.rofi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rofi.packageSource == "nixpkgs" then (with pkgs; [ rofi ]) else [];

      home.file.".config/rofi/config.rasi".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/rofi/config.rasi";
      home.file.".config/rofi/scripts".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/rofi/scripts";
      home.file.".config/rofi/themes".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/rofi/themes";
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.sherlock.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.sherlock.packageSource == "nixpkgs" then (with pkgs; [ sherlock ]) else [];

      home.file.".config/sherlock/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/config.toml";
      home.file.".config/sherlock/fallback.json".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/fallback.json";
      home.file.".config/sherlock/icons".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/icons";
      home.file.".config/sherlock/scripts".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/scripts";
      home.file.".config/sherlock/sherlock_actions.json".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/sherlock_actions.json";
      home.file.".config/sherlock/sherlock_alias.json".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/sherlock_alias.json";
      home.file.".config/sherlock/sherlockignore".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/sherlockignore";
      home.file.".config/sherlock/themes".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/sherlock/themes";
    })

    # RMPC 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.rmpc.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.rmpc.packageSource == "nixpkgs" then (with pkgs; [ rmpc ]) else [];

      home.file.".config/rmpc/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/rmpc/config.toml";
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.yazi.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.yazi.packageSource == "nixpkgs" then (with pkgs; [ yazi ]) else [];

      home.file.".config/yazi/yazi.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/yazi/yazi.toml";
      home.file.".config/yazi/keymap.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/yazi/keymap.toml";
      home.file.".config/yazi/theme.toml".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/yazi/theme.toml";
    })

    # Qutebrowser 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.qutebrowser.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.qutebrowser.packageSource == "nixpkgs" then (with pkgs; [ qutebrowser ]) else [];

      home.file.".config/qutebrowser/config.py".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/qutebrowser/config.py";
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.obs-studio.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.obs-studio.packageSource == "nixpkgs" then (with pkgs; [ obs-studio ]) else [];

      home.file.".config/obs-studio/README.md".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/obs-studio/README.md";
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.vscode.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.vscode.packageSource == "nixpkgs" then (with pkgs; [ vscode ]) else [];

      home.file.".config/Code/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/Code/User/settings.json";
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "realTime") {
      home.packages =
        if config.myHome.dotfiles.zed.packageSource == "flake" then [
          # 如果使用 flake 源，设置为空数组
        ] else if config.myHome.dotfiles.zed.packageSource == "nixpkgs" then (with pkgs; [ zed-editor ]) else [];

      home.file.".config/zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${toString ./.}/.config/zed/settings.json";
    })
  ];
}
