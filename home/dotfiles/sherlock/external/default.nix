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

    home.file.".config/sherlock/icons" = {
      source = ./configs/icons;
      recursive = true;
    };

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
