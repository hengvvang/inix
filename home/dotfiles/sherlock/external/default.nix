# Sherlock Launcher - External Configuration Mode
# macOS Tahoe-inspired design with external config files
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "external") {

    # Install Sherlock package
    home.packages = with pkgs; [
      sherlock-launcher
    ];

    # Main configuration file (TOML format)
    home.file.".config/sherlock/config.toml" = {
      source = ./configs/config.toml;
      # readonly = true;  # 可选，如果希望 Sherlock 可以修改配置则注释此行
    };

    # CSS styling file (macOS Tahoe theme)
    home.file.".config/sherlock/main.css" = {
      source = ./configs/themes/tahoe-auto.css;
    };

    # Fallback launchers (Power menu, quick actions, etc.)
    home.file.".config/sherlock/fallback.json" = {
      source = ./configs/fallback.json;
    };

    # Application aliases
    home.file.".config/sherlock/sherlock_alias.json" = {
      source = ./configs/sherlock_alias.json;
    };

    # Ignore file (hide unwanted applications)
    home.file.".config/sherlock/sherlockignore" = {
      source = ./configs/sherlockignore;
    };

    # Actions file (custom commands)
    home.file.".config/sherlock/sherlock_actions.json" = {
      source = ./configs/sherlock_actions.json;
    };

    # Theme variants directory
    home.file.".config/sherlock/themes" = {
      source = ./configs/themes;
      recursive = true;
    };

    # Utility scripts for theme management
    home.file.".config/sherlock/scripts" = {
      source = ./configs/scripts;
      recursive = true;
    };

    # Additional theme management tools
    home.packages = with pkgs; [
      (writeShellScriptBin "sherlock-theme" ''
        #!/usr/bin/env bash
        # Sherlock theme switcher for macOS Tahoe styles
        
        THEMES_DIR="$HOME/.config/sherlock/themes"
        CONFIG_DIR="$HOME/.config/sherlock"
        
        case "$1" in
          light)
            ln -sf "$THEMES_DIR/tahoe-light.css" "$CONFIG_DIR/main.css"
            echo "🌞 Switched to Tahoe Light theme"
            ;;
          dark)
            ln -sf "$THEMES_DIR/tahoe-dark.css" "$CONFIG_DIR/main.css"
            echo "🌙 Switched to Tahoe Dark theme"
            ;;
          auto|*)
            ln -sf "$THEMES_DIR/tahoe-auto.css" "$CONFIG_DIR/main.css"
            echo "🎨 Switched to Tahoe Auto theme (adapts to system)"
            ;;
        esac
        
        # Restart sherlock daemon if running
        if pgrep -x "sherlock" > /dev/null; then
          echo "🔄 Restarting Sherlock to apply theme..."
          pkill sherlock
          sleep 0.5
          ${pkgs.sherlock-launcher}/bin/sherlock --daemonize &
        fi
      '')
      
      (writeShellScriptBin "sherlock-launcher" ''
        #!/usr/bin/env bash
        # Enhanced Sherlock launcher with automatic setup
        
        # Ensure config directory exists
        mkdir -p "$HOME/.config/sherlock"
        
        # Initialize config if it doesn't exist
        if [[ ! -f "$HOME/.config/sherlock/config.toml" ]]; then
          echo "🚀 Initializing Sherlock configuration..."
          ${pkgs.sherlock-launcher}/bin/sherlock init
        fi
        
        # Set default theme if no theme is set
        if [[ ! -f "$HOME/.config/sherlock/main.css" ]]; then
          echo "🎨 Setting up macOS Tahoe theme..."
          sherlock-theme auto
        fi
        
        # Launch sherlock with error handling
        exec ${pkgs.sherlock-launcher}/bin/sherlock "$@"
      '')
    ];

    # Environment variables for optimal experience
    home.sessionVariables = {
      # Make Sherlock the default launcher
      LAUNCHER = "sherlock";
      
      # Wayland optimizations for blur effects
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      
      # Enable hardware acceleration for smooth animations
      WEBKIT_DISABLE_COMPOSITING_MODE = "0";
    };

    # Optional: Integrate with desktop environment
    # xdg.desktopEntries.sherlock = {
    #   name = "Sherlock Launcher";
    #   comment = "Modern application launcher with macOS Tahoe styling";
    #   exec = "sherlock-launcher";
    #   icon = "application-x-executable";
    #   terminal = false;
    #   categories = [ "Utility" "System" ];
    # };
  };
}
