# Sherlock Launcher - XDirect Configuration Mode
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "xdirect") {
    
    # XDirect configuration - minimal setup with custom overrides
    home.file = {
      # Minimal main configuration with custom overrides
      ".config/sherlock/config.toml".text = ''
        # Sherlock Configuration - XDirect Mode (Minimal + Custom)
        [config]
        width = 800
        height = 600
        gsk_renderer = "cairo"
        opacity = 0.95
        
        [config.behavior]
        animate = true
        
        [config.binds]
        modifier = "super"
        
        [config.backdrop]
        enable = true
        opacity = 0.8
        
        [config.expand]
        enable = true
        margin = 40
        
        [config.runtime]
        center = true
        
        [config.default_apps]
        terminal = "ghostty"
        browser = "firefox"
      '';

      # Compact CSS theme for xdirect mode
      ".config/sherlock/style.css".text = ''
        /* Sherlock - XDirect Tahoe Theme (Compact) */
        
        .sherlock-window {
          background: rgba(255, 255, 255, 0.9);
          border-radius: 20px;
          box-shadow: 0 30px 60px rgba(0, 0, 0, 0.25);
          backdrop-filter: blur(40px);
        }
        
        @media (prefers-color-scheme: dark) {
          .sherlock-window {
            background: rgba(30, 30, 30, 0.9);
          }
        }
        
        .search-input {
          background: rgba(242, 242, 247, 0.7);
          border-radius: 12px;
          padding: 16px 20px;
          margin: 20px;
          font-size: 18px;
        }
        
        @media (prefers-color-scheme: dark) {
          .search-input {
            background: rgba(44, 44, 46, 0.7);
            color: rgba(255, 255, 255, 0.9);
          }
        }
        
        .result-item {
          border-radius: 10px;
          padding: 12px 16px;
          margin: 2px 10px;
          transition: all 0.2s ease;
        }
        
        .result-item:hover {
          background: rgba(0, 0, 0, 0.05);
        }
        
        @media (prefers-color-scheme: dark) {
          .result-item:hover {
            background: rgba(255, 255, 255, 0.05);
          }
        }
        
        .result-item.selected {
          background: rgba(0, 122, 255, 0.1);
          border: 1px solid rgba(0, 122, 255, 1);
        }
        
        @media (prefers-color-scheme: dark) {
          .result-item.selected {
            background: rgba(10, 132, 255, 0.2);
            border: 1px solid rgba(10, 132, 255, 1);
          }
        }
      '';

      # Essential aliases only
      ".config/sherlock/sherlock_alias.json".text = ''
        [
          {
            "name": "System Settings",
            "exec": "gnome-control-center",
            "icon": "preferences-system",
            "keywords": ["settings", "preferences", "control", "system"]
          },
          {
            "name": "Terminal",
            "exec": "ghostty",
            "icon": "utilities-terminal", 
            "keywords": ["terminal", "shell", "command", "cli"]
          },
          {
            "name": "File Manager",
            "exec": "nautilus",
            "icon": "system-file-manager",
            "keywords": ["files", "manager", "explorer", "nautilus"]
          },
          {
            "name": "Calculator",
            "exec": "gnome-calculator",
            "icon": "accessories-calculator",
            "keywords": ["calculator", "calc", "math"]
          },
          {
            "name": "Text Editor",
            "exec": "gnome-text-editor",
            "icon": "accessories-text-editor",
            "keywords": ["text", "editor", "notepad"]
          }
        ]
      '';

      # Minimal ignore list
      ".config/sherlock/sherlockignore".text = ''
        # XDirect mode - minimal ignore list
        avahi-discover
        bssh
        bvnc
        qv4l2
        qvidcap
        htop
        nvtop
      '';

      # Basic power menu only
      ".config/sherlock/fallback.json".text = ''
        [
          {
            "name": "Lock Screen",
            "exec": "loginctl lock-session",
            "icon": "system-lock-screen",
            "keywords": ["lock", "screen", "secure"]
          },
          {
            "name": "Log Out",
            "exec": "loginctl terminate-user $USER",
            "icon": "system-log-out",
            "keywords": ["logout", "exit", "quit"]
          },
          {
            "name": "Restart",
            "exec": "systemctl reboot",
            "icon": "system-restart",
            "keywords": ["restart", "reboot", "reset"]
          },
          {
            "name": "Shutdown",
            "exec": "systemctl poweroff",
            "icon": "system-shutdown",
            "keywords": ["shutdown", "poweroff", "turn off"]
          }
        ]
      '';

      # Empty actions
      ".config/sherlock/sherlock_actions.json".text = "[]";
    };

    # Sherlock package
    home.packages = with pkgs; [
      sherlock-launcher
    ];

    # Minimal environment
    home.sessionVariables = {
      LAUNCHER = "sherlock";
    };

    # Optional: Create a simple launcher script
    home.file.".local/bin/sherlock-launcher".text = ''
      #!/bin/sh
      exec ${pkgs.sherlock-launcher}/bin/sherlock "$@"
    '';
    
    home.file.".local/bin/sherlock-launcher".executable = true;
  };
}
