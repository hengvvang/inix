{ config, lib, pkgs, ... }:
let
  cfg = config.myHome.profiles.stylix;
in
{
  # Stylix 主题预设配置
  options.myHome.profiles.stylix.presets = {
    enable = lib.mkEnableOption "使用预设主题配置";

    profile = lib.mkOption {
      type = lib.types.enum [
        "catppuccin-minimal"    # Catppuccin 简约风格
        "tokyo-night-pro"       # Tokyo Night 专业风格
        "gruvbox-classic"       # Gruvbox 经典风格
        "nord-arctic"           # Nord 北极风格
        "dracula-vampire"       # Dracula 暗夜风格
        "solarized-academic"    # Solarized 学术风格
        "github-clean"          # GitHub 简洁风格
        "custom"                # 自定义配置
      ];
      default = "catppuccin-minimal";
      description = "选择预设主题配置档案";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.presets.enable) {
    myHome.profiles.stylix =
      if cfg.presets.profile == "catppuccin-minimal" then {
        # Catppuccin 简约风格 - 现代优雅
        theme = {
          colorScheme = {
            preset = "catppuccin-mocha";
            polarity = "dark";
          };
          wallpaper = {
            enable = true;
            scaling = "fill";
            generateFromImage = false;
          };
        };

        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Noto Serif CJK SC";
              package = pkgs.noto-fonts-cjk-serif;
            };
            sansSerif = {
              name = "Inter";
              package = pkgs.inter;
            };
            monospace = {
              name = "JetBrains Mono";
              package = pkgs.jetbrains-mono;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
          sizes = {
            applications = 11;
            desktop = 9;
            popups = 10;
            terminal = 12;
          };
        };

        cursor = {
          enable = true;
          theme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
            size = 24;
          };
        };

        opacity = {
          enable = true;
          terminal = 0.9;
          applications = 1.0;
          desktop = 1.0;
          popups = 0.95;
        };

        icons = {
          enable = true;
          package = pkgs.catppuccin-papirus-folders;
          light = "Papirus-Light";
          dark = "Papirus-Dark";
        };

        targets = {
          gtk = {
            enable = true;
            flatpak = true;
            extraCss = ''
              window.background {
                border-radius: 12px;
              }

              .titlebar {
                border-radius: 12px 12px 0 0;
              }
            '';
          };
          # 启用所有支持的目标
          alacritty.enable = true;
          kitty.enable = true;
          ghostty.enable = true;
          vim.enable = true;
          firefox.enable = true;
          git.enable = true;
          btop.enable = true;
          rofi.enable = true;
          yazi.enable = true;
          tmux.enable = true;
          zellij.enable = true;
        };
      }

      else if cfg.presets.profile == "tokyo-night-pro" then {
        # Tokyo Night 专业风格 - 开发者首选
        theme = {
          colorScheme = {
            preset = "tokyo-night-dark";
            polarity = "dark";
          };
          wallpaper = {
            enable = true;
            scaling = "fit";
          };
        };

        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Source Serif 4";
              package = pkgs.source-serif;
            };
            sansSerif = {
              name = "Source Sans 3";
              package = pkgs.source-sans;
            };
            monospace = {
              name = "Fira Code";
              package = pkgs.fira-code;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
          sizes = {
            applications = 12;
            desktop = 10;
            popups = 11;
            terminal = 14;
          };
        };

        cursor = {
          enable = true;
          theme = {
            name = "Vanilla-DMZ";
            package = pkgs.vanilla-dmz;
            size = 24;
          };
        };

        opacity = {
          enable = true;
          terminal = 0.88;
          applications = 0.98;
          desktop = 1.0;
          popups = 0.92;
        };
      }

      else if cfg.presets.profile == "gruvbox-classic" then {
        # Gruvbox 经典风格 - 复古温暖
        theme = {
          colorScheme = {
            preset = "gruvbox-dark-hard";
            polarity = "dark";
          };
          wallpaper = {
            enable = true;
            scaling = "fill";
          };
        };

        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Liberation Serif";
              package = pkgs.liberation_ttf;
            };
            sansSerif = {
              name = "Liberation Sans";
              package = pkgs.liberation_ttf;
            };
            monospace = {
              name = "Inconsolata";
              package = pkgs.inconsolata;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
          sizes = {
            applications = 11;
            desktop = 9;
            popups = 10;
            terminal = 13;
          };
        };
      }

      else if cfg.presets.profile == "nord-arctic" then {
        # Nord 北极风格 - 清冷简约
        theme = {
          colorScheme = {
            preset = "nord";
            polarity = "dark";
          };
          wallpaper = {
            enable = true;
            scaling = "center";
          };
        };

        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Crimson Text";
              package = pkgs.crimson;
            };
            sansSerif = {
              name = "IBM Plex Sans";
              package = pkgs.ibm-plex;
            };
            monospace = {
              name = "IBM Plex Mono";
              package = pkgs.ibm-plex;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
          sizes = {
            applications = 11;
            desktop = 9;
            popups = 10;
            terminal = 12;
          };
        };
      }

      else if cfg.presets.profile == "solarized-academic" then {
        # Solarized 学术风格 - 护眼经典
        theme = {
          colorScheme = {
            preset = "solarized-dark";
            polarity = "either";  # 支持明暗切换
          };
          wallpaper = {
            enable = true;
            scaling = "fit";
          };
        };

        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Libertinus Serif";
              package = pkgs.libertinus;
            };
            sansSerif = {
              name = "Libertinus Sans";
              package = pkgs.libertinus;
            };
            monospace = {
              name = "Iosevka Term";
              package = pkgs.iosevka;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
          sizes = {
            applications = 12;
            desktop = 10;
            popups = 11;
            terminal = 13;
          };
        };

        opacity = {
          enable = false;  # Solarized 不建议使用透明度
        };
      }

      else if cfg.presets.profile == "github-clean" then {
        # GitHub 简洁风格 - 清新明亮
        theme = {
          colorScheme = {
            preset = "github-light";
            polarity = "light";
          };
          wallpaper = {
            enable = true;
            scaling = "fill";
          };
        };

        fonts = {
          enable = true;
          families = {
            serif = {
              name = "Charter";
              package = pkgs.charter;
            };
            sansSerif = {
              name = "Inter";
              package = pkgs.inter;
            };
            monospace = {
              name = "SF Mono";
              package = pkgs.sf-mono-liga-bin or pkgs.jetbrains-mono;
            };
            emoji = {
              name = "Noto Color Emoji";
              package = pkgs.noto-fonts-color-emoji;
            };
          };
          sizes = {
            applications = 11;
            desktop = 9;
            popups = 10;
            terminal = 12;
          };
        };

        cursor = {
          enable = true;
          theme = {
            name = "Adwaita";
            package = pkgs.adwaita-icon-theme;
            size = 20;
          };
        };

        opacity = {
          enable = false;  # 明亮主题通常不需要透明度
        };
      }

      else {
        # 自定义配置 - 保持用户设置
        {};
      };
  };
}
