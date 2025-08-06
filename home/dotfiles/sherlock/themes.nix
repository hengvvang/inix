# Sherlock Tahoe Theme - Additional styling and configuration
{ config, lib, pkgs, ... }:

let
  # macOS Tahoe color palette
  tahoeColors = {
    light = {
      background = "0, 0%, 98%";
      backgroundSoft = "0, 0%, 95%";
      foreground = "0, 0%, 92%";
      text = "0, 0%, 15%";
      textActive = "0, 0%, 10%";
      textSecondary = "0, 0%, 45%";
      border = "0, 0%, 85%";
      accent = "211, 100%, 50%"; # macOS system blue
      success = "142, 76%, 36%";
      warning = "35, 100%, 50%";
      error = "0, 100%, 67%";
    };
    
    dark = {
      background = "0, 0%, 8%";
      backgroundSoft = "0, 0%, 12%";
      foreground = "0, 0%, 15%";
      text = "0, 0%, 90%";
      textActive = "0, 0%, 95%";
      textSecondary = "0, 0%, 65%";
      border = "0, 0%, 25%";
      accent = "211, 100%, 60%";
      success = "142, 76%, 46%";
      warning = "35, 100%, 60%";
      error = "0, 100%, 77%";
    };
  };

  # Generate CSS for a specific color scheme
  generateThemeCSS = colors: ''
    :root {
      /* macOS Tahoe color palette */
      --background: ${colors.background};
      --background-soft: ${colors.backgroundSoft};
      --foreground: ${colors.foreground};
      --text: ${colors.text};
      --text-active: ${colors.textActive};
      --text-secondary: ${colors.textSecondary};
      --border: ${colors.border};
      --accent: ${colors.accent};
      --success: ${colors.success};
      --warning: ${colors.warning};
      --error: ${colors.error};
      
      /* macOS-like design tokens */
      --radius-small: 8px;
      --radius-medium: 12px;
      --radius-large: 16px;
      --shadow-light: 0px 1px 3px rgba(0, 0, 0, 0.1);
      --shadow-medium: 0px 4px 12px rgba(0, 0, 0, 0.15);
      --shadow-heavy: 0px 8px 24px rgba(0, 0, 0, 0.2);
    }
  '';

  # Default theme CSS (auto-adapting)
  fullThemeCSS = ''
    /* macOS Tahoe-inspired Sherlock theme */
    /* Auto-adapting light/dark theme */
    
    ${generateThemeCSS tahoeColors.light}

    /* Main window with vibrancy effect */
    window {
      background: hsla(var(--background), 0.95);
      border-radius: var(--radius-large);
      box-shadow: var(--shadow-heavy);
      border: 1px solid hsla(var(--border), 0.3);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
    }

    /* Search bar - Spotlight-inspired */
    #search-bar {
      background: hsla(var(--background), 0.8);
      border: 1px solid hsla(var(--border), 0.4);
      border-radius: var(--radius-medium);
      padding: 12px 16px;
      margin: 16px;
      box-shadow: var(--shadow-light);
      backdrop-filter: blur(10px);
      font-size: 16px;
      color: hsl(var(--text));
      transition: all 0.2s cubic-bezier(0.25, 0.1, 0.25, 1);
    }

    #search-bar:focus {
      border-color: hsl(var(--accent));
      box-shadow: 0px 0px 0px 3px hsla(var(--accent), 0.1);
      outline: none;
    }

    /* Tiles with modern styling */
    .tile {
      background: hsla(var(--foreground), 0.6);
      border: 1px solid hsla(var(--border), 0.3);
      border-radius: var(--radius-medium);
      margin: 4px 8px;
      padding: 12px 16px;
      transition: all 0.2s cubic-bezier(0.25, 0.1, 0.25, 1);
      backdrop-filter: blur(8px);
      box-shadow: var(--shadow-light);
    }

    .tile:hover {
      background: hsla(var(--foreground), 0.8);
      border-color: hsla(var(--accent), 0.3);
      box-shadow: var(--shadow-medium);
      transform: translateY(-1px);
    }

    .tile:selected {
      background: hsla(var(--accent), 0.1);
      border-color: hsl(var(--accent));
      box-shadow: 0px 0px 0px 2px hsla(var(--accent), 0.2);
    }

    /* Typography */
    #title {
      font-size: 15px;
      font-weight: 500;
      color: hsl(var(--text));
      margin-bottom: 2px;
    }

    .tile:selected #title {
      color: hsl(var(--text-active));
      font-weight: 600;
    }

    #description {
      font-size: 13px;
      color: hsl(var(--text-secondary));
      line-height: 1.3;
    }

    /* Dark mode adaptation */
    @media (prefers-color-scheme: dark) {
      ${generateThemeCSS tahoeColors.dark}
      
      #search-icon-holder image {
        -gtk-icon-filter: brightness(0) saturate(100%) invert(90%);
      }
    }

    /* Animations */
    @keyframes slideIn {
      from {
        opacity: 0;
        transform: translateY(10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .tile {
      animation: slideIn 0.2s cubic-bezier(0.25, 0.1, 0.25, 1);
    }

    window {
      animation: fadeIn 0.3s cubic-bezier(0.25, 0.1, 0.25, 1);
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }
  '';

in {
  # Create additional theme files
  xdg.configFile = {
    "sherlock/themes/tahoe-light.css".text = generateThemeCSS tahoeColors.light + ''
      /* Light theme specific overrides */
      #search-icon-holder image {
        -gtk-icon-filter: brightness(0) saturate(100%) invert(27%);
      }
    '';
    
    "sherlock/themes/tahoe-dark.css".text = generateThemeCSS tahoeColors.dark + ''
      /* Dark theme specific overrides */
      #search-icon-holder image {
        -gtk-icon-filter: brightness(0) saturate(100%) invert(90%);
      }
    '';
    
    "sherlock/themes/tahoe-auto.css".text = fullThemeCSS;
  };

  # Additional scripts for theme management
  home.packages = with pkgs; [
    (writeShellScriptBin "sherlock-theme" ''
      #!/usr/bin/env bash
      # Sherlock theme switcher
      
      THEMES_DIR="$HOME/.config/sherlock/themes"
      CONFIG_DIR="$HOME/.config/sherlock"
      
      case "$1" in
        light)
          ln -sf "$THEMES_DIR/tahoe-light.css" "$CONFIG_DIR/main.css"
          echo "Switched to Tahoe Light theme"
          ;;
        dark)
          ln -sf "$THEMES_DIR/tahoe-dark.css" "$CONFIG_DIR/main.css"
          echo "Switched to Tahoe Dark theme"
          ;;
        auto|*)
          ln -sf "$THEMES_DIR/tahoe-auto.css" "$CONFIG_DIR/main.css"
          echo "Switched to Tahoe Auto theme (adapts to system)"
          ;;
      esac
      
      # Restart sherlock daemon if running
      if pgrep -x "sherlock" > /dev/null; then
        echo "Restarting Sherlock to apply theme..."
        pkill sherlock
        sleep 0.5
        ${pkgs.sherlock-launcher}/bin/sherlock --daemonize &
      fi
    '')
    
    (writeShellScriptBin "sherlock-launcher" ''
      #!/usr/bin/env bash
      # Enhanced Sherlock launcher with error handling
      
      # Ensure config directory exists
      mkdir -p "$HOME/.config/sherlock"
      
      # Initialize config if it doesn't exist
      if [[ ! -f "$HOME/.config/sherlock/config.toml" ]]; then
        echo "Initializing Sherlock configuration..."
        ${pkgs.sherlock-launcher}/bin/sherlock init
      fi
      
      # Set default theme if no theme is set
      if [[ ! -f "$HOME/.config/sherlock/main.css" ]]; then
        echo "Setting up default Tahoe theme..."
        sherlock-theme auto
      fi
      
      # Launch sherlock with error handling
      exec ${pkgs.sherlock-launcher}/bin/sherlock "$@"
    '')
  ];
}
