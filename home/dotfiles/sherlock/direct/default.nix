# Sherlock Launcher - Direct Configuration Mode
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "direct") {
    
    # Direct configuration files generation
    home.file = {
      # Main configuration
      ".config/sherlock/config.toml".text = ''
        # Sherlock Configuration - macOS Tahoe Style
        [config]
        width = 800
        height = 600
        gsk_renderer = "cairo"
        icon_size = 24
        use_base_css = true
        opacity = 0.95

        [config.behavior]
        animate = true
        use_xdg_data_dir_icons = false

        [config.binds]
        modifier = "super"
        exec_inplace = "super+return"
        context = "super+i"

        [config.backdrop]
        enable = true
        opacity = 0.8
        edge = "top"

        [config.expand]
        enable = true
        edge = "top"
        margin = 40

        [config.caching]
        enable = true

        [config.status_bar]
        enable = false

        [config.runtime]
        center = true
        daemonize = false

        [config.default_apps]
        terminal = "ghostty"
        browser = "firefox"

        [config.units]
        lengths = "meter"
        weights = "kg"
        volumes = "l"
        temperatures = "C"
        currency = "eur"
      '';

      # Tahoe CSS theme - directly embedded
      ".config/sherlock/style.css".text = ''
        /* Sherlock Launcher - macOS Tahoe Theme */
        /* Auto-adapts to system dark/light mode */

        :root {
          /* Light mode colors */
          --window-bg: rgba(255, 255, 255, 0.9);
          --window-border: rgba(255, 255, 255, 0.2);
          --search-bg: rgba(242, 242, 247, 0.7);
          --search-border: rgba(0, 0, 0, 0.1);
          --text-primary: rgba(0, 0, 0, 0.9);
          --text-secondary: rgba(0, 0, 0, 0.6);
          --item-hover: rgba(0, 0, 0, 0.05);
          --item-selected: rgba(0, 122, 255, 0.1);
          --accent: rgba(0, 122, 255, 1);
          --backdrop: rgba(0, 0, 0, 0.3);
        }

        @media (prefers-color-scheme: dark) {
          :root {
            /* Dark mode colors */
            --window-bg: rgba(30, 30, 30, 0.9);
            --window-border: rgba(255, 255, 255, 0.15);
            --search-bg: rgba(44, 44, 46, 0.7);
            --search-border: rgba(255, 255, 255, 0.1);
            --text-primary: rgba(255, 255, 255, 0.9);
            --text-secondary: rgba(255, 255, 255, 0.6);
            --item-hover: rgba(255, 255, 255, 0.05);
            --item-selected: rgba(10, 132, 255, 0.2);
            --accent: rgba(10, 132, 255, 1);
            --backdrop: rgba(0, 0, 0, 0.6);
          }
        }

        /* Main window */
        .sherlock-window {
          background: var(--window-bg);
          border: 1px solid var(--window-border);
          border-radius: 20px;
          box-shadow: 
            0 30px 60px rgba(0, 0, 0, 0.25),
            0 0 0 1px rgba(255, 255, 255, 0.05);
          backdrop-filter: blur(40px);
          -webkit-backdrop-filter: blur(40px);
        }

        /* Search input */
        .search-input {
          background: var(--search-bg);
          border: 1px solid var(--search-border);
          border-radius: 12px;
          color: var(--text-primary);
          font-size: 18px;
          padding: 16px 20px;
          margin: 20px;
        }

        /* Results list */
        .results-list {
          padding: 0 10px 20px 10px;
        }

        /* Individual result items */
        .result-item {
          border-radius: 10px;
          padding: 12px 16px;
          margin: 2px 0;
          transition: all 0.2s ease;
        }

        .result-item:hover {
          background: var(--item-hover);
        }

        .result-item.selected {
          background: var(--item-selected);
          border: 1px solid var(--accent);
        }

        /* Text styling */
        .result-title {
          color: var(--text-primary);
          font-weight: 500;
          font-size: 16px;
        }

        .result-description {
          color: var(--text-secondary);
          font-size: 14px;
          margin-top: 2px;
        }

        /* Icons */
        .result-icon {
          margin-right: 12px;
          border-radius: 8px;
        }

        /* Backdrop */
        .sherlock-backdrop {
          background: var(--backdrop);
          backdrop-filter: blur(20px);
          -webkit-backdrop-filter: blur(20px);
        }
      '';

      # Application aliases
      ".config/sherlock/sherlock_alias.json".source = ../external/configs/sherlock_alias.json;

      # Ignore list
      ".config/sherlock/sherlockignore".source = ../external/configs/sherlockignore;

      # Fallback launchers
      ".config/sherlock/fallback.json".source = ../external/configs/fallback.json;

      # Empty actions file
      ".config/sherlock/sherlock_actions.json".source = ../external/configs/sherlock_actions.json;
    };

    # Sherlock package
    home.packages = with pkgs; [
      sherlock-launcher
    ];

    # Environment variables
    home.sessionVariables = {
      LAUNCHER = "sherlock";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
