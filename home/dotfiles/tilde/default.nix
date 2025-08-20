{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # Bash 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.bash.packageEnable (with pkgs; [ bash ]);

      home.file.".bashrc".source = ./.bashrc;
      home.file.".bash_profile".source = ./.bash_profile;
      home.file.".bash_aliases".source = ./.bash_aliases;
      home.file.".bash_functions".source = ./.bash_functions;
    })

    # Zsh 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.zsh.packageEnable (with pkgs; [ zsh ]);

      home.file.".zshrc".source = ./.zshrc;
      home.file.".zprofile".source = ./.zprofile;
      home.file.".zlogin".source = ./.zlogin;
      home.file.".zshenv".source = ./.zshenv;
      home.file.".zlogout".source = ./.zlogout;
    })

    # Vim 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vim.enable && config.myHome.dotfiles.vim.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.vim.packageEnable (with pkgs; [ vim ]);

      home.file.".vimrc".source = ./.vimrc;
    })

    # Fish 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.fish.packageEnable (with pkgs; [ fish ]);

      # Fish 配置文件通常在 ~/.config/fish/ 目录下
      home.file.".config/fish/config.fish".source = ./.config/fish/config.fish;
      home.file.".config/fish/fish_variables".source = ./.config/fish/fish_variables.template;

      # Fish 其他配置目录
      home.file.".config/fish/completions".source = ./.config/fish/completions;
      home.file.".config/fish/conf.d".source = ./.config/fish/conf.d;
      home.file.".config/fish/functions".source = ./.config/fish/functions;
      home.file.".config/fish/fish_plugins".source = ./.config/fish/fish_plugins;
    })

    # Nushell 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.nushell.packageEnable (with pkgs; [ nushell ]);

      # Nushell 配置文件通常在 ~/.config/nushell/ 目录下
      home.file.".config/nushell/config.nu".source = ./.config/nushell/config.nu;
      home.file.".config/nushell/env.nu".source = ./.config/nushell/env.nu;
    })

    # Starship 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.starship.packageEnable (with pkgs; [ starship ]);

      home.file.".config/starship.toml".source = ./.config/starship.toml;
    })

    # Alacritty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable && config.myHome.dotfiles.alacritty.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.alacritty.packageEnable (with pkgs; [ alacritty ]);

      home.file.".config/alacritty/alacritty.toml".source = ./.config/alacritty/alacritty.toml;
      home.file.".config/alacritty/themes".source = ./.config/alacritty/themes;
    })

    # Ghostty 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.ghostty.packageEnable (with pkgs; [ ghostty ]);

      home.file.".config/ghostty/config".source = ./.config/ghostty/config;
      home.file.".config/ghostty/themes".source = ./.config/ghostty/themes;
    })

    # Rio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.rio.packageEnable (with pkgs; [ rio ]);

      home.file.".config/rio/config.toml".source = ./.config/rio/config.toml;
      home.file.".config/rio/themes".source = ./.config/rio/themes;
    })

    # Git 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.git.packageEnable (with pkgs; [ git ]);

      home.file.".config/git/config".source = ./.config/git/gitconfig;
      home.file.".config/git/ignore".source = ./.config/git/gitignore_global;
    })

    # Lazygit 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.lazygit.packageEnable (with pkgs; [ lazygit ]);

      home.file.".config/lazygit/config.yml".source = ./.config/lazygit/config.yml;
    })

    # Tmux 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.tmux.enable && config.myHome.dotfiles.tmux.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.tmux.packageEnable (with pkgs; [ tmux ]);

      home.file.".config/tmux/tmux.conf".source = ./.config/tmux/tmux.conf;
    })

    # Zellij 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.zellij.packageEnable (with pkgs; [ zellij ]);

      home.file.".config/zellij/config.kdl".source = ./.config/zellij/config.kdl;
      home.file.".config/zellij/layouts".source = ./.config/zellij/layouts;
      home.file.".config/zellij/themes".source = ./.config/zellij/themes;
    })

    # Rofi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.rofi.packageEnable (with pkgs; [ rofi ]);

      home.file.".config/rofi/config.rasi".source = ./.config/rofi/config.rasi;
      home.file.".config/rofi/scripts".source = ./.config/rofi/scripts;
      home.file.".config/rofi/themes".source = ./.config/rofi/themes;
    })

    # Sherlock 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.sherlock.packageEnable (with pkgs; [ sherlock ]);

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
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.rmpc.packageEnable (with pkgs; [ rmpc ]);

      home.file.".config/rmpc/config.toml".source = ./.config/rmpc/config.toml;
    })

    # Yazi 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.yazi.packageEnable (with pkgs; [ yazi ]);

      home.file.".config/yazi/yazi.toml".source = ./.config/yazi/yazi.toml;
      home.file.".config/yazi/keymap.toml".source = ./.config/yazi/keymap.toml;
      home.file.".config/yazi/theme.toml".source = ./.config/yazi/theme.toml;
    })

    # Qutebrowser 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.qutebrowser.packageEnable (with pkgs; [ qutebrowser ]);

      home.file.".config/qutebrowser/config.py".source = ./.config/qutebrowser/config.py;
    })

    # OBS Studio 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.obs-studio.packageEnable (with pkgs; [ obs-studio ]);

      home.file.".config/obs-studio/README.md".source = ./.config/obs-studio/README.md;
    })

    # VSCode 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.vscode.packageEnable (with pkgs; [ vscode ]);

      home.file.".config/Code/User/settings.json".source = ./.config/Code/User/settings.json;
    })

    # Zed 配置
    (lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "copy") {
      home.packages = lib.optionals config.myHome.dotfiles.zed.packageEnable (with pkgs; [ zed-editor ]);

      home.file.".config/zed/settings.json".source = ./.config/zed/settings.json;
    })
  ];
}
