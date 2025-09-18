{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.homeManager.enable) {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;

      package = pkgs.starship;

      settings = {

        format = ''
          [](fg:#32CD32 bold)$hostname$username$directory$git_branch$git_status
          [ ](fg:#32CD32 bold)[](fg:#32CD32 bold)$character'';


        right_format = ''$cmd_duration[](fg:#32CD32 bold)$time[](fg:#FF4500 bold)'';

        add_newline = true;

        os = {
          format = "[「](fg:#8A2BE2 bold)[ $symbol ](fg:#FF4500 bold)[」](#32CD32 bold)";
          disabled = false;
          symbols = {
            NixOS = "❄";
            Ubuntu = "";
            Debian = "";
            Arch = "";
            Fedora = "";
            Manjaro = "";
            openSUSE = "";
            CentOS = "";
            Redhat = "";
            Linux = "";
            Macos = "";
            Windows = "";
          };
        };

        character = {
          success_symbol = "[/](fg:#32CD32 bold)[/](fg:#8A2BE2 bold)[:](fg:#32CD32 bold)";
          error_symbol = "[/](fg:#32CD32 bold)[/](fg:#8A2BE2 bold)[:](fg:#FF4500 bold)";
          vicmd_symbol = "[/](fg:#32CD32 bold)[/](fg:#8A2BE2 bold)[:](fg:#8A2BE2 bold)";
        };

        hostname = {
          ssh_only = false;
          ssh_symbol = "∅";
          # format = "[「](fg:#8A2BE2 bold)[host/:](fg:#8A2BE2 bold)[ $hostname$ssh_symbol ](fg:#32CD32 bold)[」](fg:#8A2BE2 bold)";
          format = "[「](fg:#32CD32 bold)[host/:](fg:#32CD32 bold)[ $hostname$ssh_symbol ](fg:#8A2BE2 bold)[」](fg:#32CD32 bold)";
          trim_at = ".";
          disabled = false;
        };


        username = {
          style_user = "fg:#32CD32 bold";
          style_root = "fg:#FF0000 bold";
          # format = "[「](fg:#8A2BE2 bold)[host/:](fg:#8A2BE2 bold)[ $user ](fg:#32CD32 bold)[」](fg:#8A2BE2 bold)";
          format = "[「](fg:#32CD32 bold)[user/:](fg:#32CD32 bold)[ $user ](fg:#8A2BE2 bold)[」](fg:#32CD32 bold)";
          disabled = false;
          show_always = true;
        };

        directory = {
          style = "fg:#8A2BE2 bold";
          format = "[「](fg:#32CD32 bold)[ $path ]($style bold)[」](#32CD32 bold)";
          truncation_length = 4;
          truncation_symbol = "../";
          truncate_to_repo = true;
          home_symbol = "home";
          read_only = "read-only";
          read_only_style = "fg:#FF0000";
        };

        git_branch = {
          symbol = "[branch:](fg:#8A2BE2 bold)";
          style = "fg:#32CD32 bold";
          format = "[「](fg:#F05033 bold)[ $symbol$branch ](bold $style)[](fg:#FF4500 bold)";
          truncation_length = 15;
          truncation_symbol = "⟨…⟩";
        };

        git_status = {
          style = "fg:#32CD32 bold";
          format = "[](fg:#FF4500 bold)[$all_status$ahead_behind ](bold $style)[」](fg:#F05033 bold)";
          conflicted = "[  conficted:](fg:#8A2BE2 bold)$count";
          ahead = "[  ahead:](fg:#8A2BE2 bold)$count";
          behind = "[  behind:](fg:#8A2BE2 bold)$count";
          diverged = "[  ahead_count:](fg:#8A2BE2 bold)$ahead_count[  behind_count:](fg:#8A2BE2 bold)$behind_count";
          up_to_date = "  ⥮";
          untracked = "[  untracked:](fg:#8A2BE2 bold)$count";
          stashed = "[ stashed](fg:#8A2BE2 bold)$count";
          modified = "[ modified:](fg:#8A2BE2 bold)$count";
          staged = "[ staged:](fg:#8A2BE2 bold)$count";
          renamed = "[ renamed:](fg:#8A2BE2 bold)$count";
          deleted = "[ deleted:](fg:#8A2BE2 bold)$count";
        };


        docker_context = {
          format = "[🐳](fg:#2496ED bold)[dock:$context ](fg:#2496ED bold)";
          only_with_files = true;
          detect_files = ["docker-compose.yml" "Dockerfile"];
        };

        cmd_duration = {
          min_time = 500;
          # format = "[⚡](fg:#FFD700 bold)[took:$duration ](fg:#FF4500 bold)";
          format = "[took:](fg:#8A2BE2 bold)[$duration ](fg:#32CD32 bold)[](fg:#FF4500 bold)";
          show_milliseconds = false;
          disabled = false;
        };

        time = {
          disabled = false;
          format = "[Τ:](fg:#8A2BE2 bold)[$time ](fg:#32CD32 bold)[](fg:#FF4500 bold)";
          time_format = "%H:%M:%S";
          utc_time_offset = "local";
        };

        battery = {
          full_symbol = "🔋";
          charging_symbol = "⚡";
          discharging_symbol = "🪫";
          unknown_symbol = "❓";
          empty_symbol = "💀";
          format = "[](fg:#8A2BE2 bold)[$symbol$percentage ](fg:#32CD32 bold)[](fg:#FF4500 bold)";
          display = [
            {
              threshold = 10;
              style = "fg:#FF0000 bold";
            }
            {
              threshold = 30;
              style = "fg:#FF4500 bold";
            }
            {
              threshold = 50;
              style = "fg:#FFD700 bold";
            }
            {
              threshold = 100;
              style = "fg:#32CD32 bold";
            }
          ];
        };

        memory_usage = {
          disabled = false;
          threshold = 70;
          symbol = "💾";
          style = "fg:#FF4500 bold";
          format = "[◢](fg:#8A2BE2 bold)[$symbol$ram($ram_pct) ](bold $style)[◤](fg:#32CD32 bold)";
        };

      };
    };
  };
}
