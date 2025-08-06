# Sherlock Launcher - Home Manager Configuration Mode
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "homemanager") {
    
    # Sherlock configuration using Home Manager programs module
    programs.sherlock = {
      enable = true;
      package = pkgs.sherlock-launcher;
      
      settings = {
        # Main configuration
        config = {
          # Appearance - macOS Tahoe inspired
          appearance = {
            width = 800;
            height = 600;
            gsk_renderer = "cairo";
            icon_size = 24;
            use_base_css = true;
            opacity = 0.95;
          };

          # Behavior
          behavior = {
            animate = true;
            use_xdg_data_dir_icons = false;
          };

          # Key bindings
          binds = {
            modifier = "super";
            exec_inplace = "super+return";
            context = "super+i";
          };

          # Visual effects
          backdrop = {
            enable = true;
            opacity = 0.8;
            edge = "top";
          };

          expand = {
            enable = true;
            edge = "top";
            margin = 40;
          };

          # Performance
          caching = {
            enable = true;
          };

          status_bar = {
            enable = false;
          };

          # Runtime
          runtime = {
            center = true;
            daemonize = false;
          };

          # Default apps
          default_apps = {
            terminal = "ghostty";
            browser = "firefox";
          };

          # Units
          units = {
            lengths = "meter";
            weights = "kg";
            volumes = "l";
            temperatures = "C";
            currency = "eur";
          };
        };

        # Custom CSS - macOS Tahoe theme
        style = builtins.readFile ../external/configs/themes/tahoe-auto.css;

        # Aliases
        aliases = [
          {
            name = "System Settings";
            exec = "gnome-control-center";
            icon = "preferences-system";
            keywords = ["settings" "preferences" "control"];
          }
          {
            name = "Activity Monitor";
            exec = "gnome-system-monitor";
            icon = "utilities-system-monitor";
            keywords = ["activity" "processes" "performance"];
          }
          {
            name = "Terminal";
            exec = "ghostty";
            icon = "utilities-terminal";
            keywords = ["terminal" "shell" "command"];
          }
        ];

        # Ignore unwanted applications
        ignore = builtins.readFile ../external/configs/sherlockignore;

        # Fallback launchers
        launchers = builtins.fromJSON (builtins.readFile ../external/configs/fallback.json);
      };
    };

    # Environment variables
    home.sessionVariables = {
      LAUNCHER = "sherlock";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
