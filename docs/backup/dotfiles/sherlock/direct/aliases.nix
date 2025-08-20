{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "direct") {
    home.file.".config/sherlock/sherlock_alias.json".text = ''
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

    home.file.".config/sherlock/sherlockignore".text = ''
      # Direct mode - minimal ignore list
      avahi-discover
      bssh
      bvnc
      qv4l2
      qvidcap
      htop
      nvtop
    '';

    home.file.".config/sherlock/fallback.json".text = ''
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

    home.file.".config/sherlock/sherlock_actions.json".text = "[]";

    home.sessionVariables = {
      LAUNCHER = "sherlock";
    };
  };
}
