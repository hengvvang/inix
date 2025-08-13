{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.myHome.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix Home Manager 主题配置";
    
    # 用户级壁纸覆盖（可选）
    image = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "用户自定义壁纸，设置后不再跟随系统";
    };
    
    # 用户级颜色方案覆盖（可选）
    colorScheme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "用户颜色方案，设置后不再跟随系统";
      example = "\${pkgs.base16-schemes}/share/themes/nord.yaml";
    };
    
    # 用户级主题极性覆盖（可选）
    polarity = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "light" "dark" ]);
      default = null;
      description = "用户主题极性，设置后不再跟随系统";
    };
    
    # 字体大小覆盖
    fontSize = {
      applications = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "用户应用程序字体大小覆盖";
      };
      terminal = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "用户终端字体大小覆盖";
      };
      desktop = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "用户桌面字体大小覆盖";
      };
      popups = lib.mkOption {
        type = lib.types.nullOr lib.types.int;
        default = null;
        description = "用户弹窗字体大小覆盖";
      };
    };
    
    # 目标应用配置 - 基于实际安装的应用自动检测
    targets = {
      # 终端应用
      terminals = {
        alacritty.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.alacritty.enable or false;
          description = "Alacritty 主题，默认跟随程序启用状态";
        };
        kitty.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.kitty.enable or false;
          description = "Kitty 主题，默认跟随程序启用状态";
        };
        wezterm.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.wezterm.enable or false;
          description = "WezTerm 主题，默认跟随程序启用状态";
        };
      };
      
      # 编辑器
      editors = {
        vim.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.vim.enable or false;
          description = "Vim 主题，默认跟随程序启用状态";
        };
        neovim.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.neovim.enable or false;
          description = "Neovim 主题，默认跟随程序启用状态";
        };
        emacs.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.emacs.enable or false;
          description = "Emacs 主题，默认跟随程序启用状态";
        };
      };
      
      # 开发工具
      tools = {
        tmux.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.tmux.enable or false;
          description = "Tmux 主题，默认跟随程序启用状态";
        };
        bat.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.bat.enable or false;
          description = "Bat 主题，默认跟随程序启用状态";
        };
        fzf.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.fzf.enable or false;
          description = "Fzf 主题，默认跟随程序启用状态";
        };
        zellij.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.zellij.enable or false;
          description = "Zellij 主题，默认跟随程序启用状态";
        };
      };
      
      # 桌面环境
      desktop = {
        gtk.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "GTK 应用主题";
        };
        qt.enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Qt 应用主题";
        };
      };
      
      # 浏览器
      browsers = {
        firefox.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.firefox.enable or false;
          description = "Firefox 主题，默认跟随程序启用状态";
        };
        qutebrowser.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.qutebrowser.enable or false;
          description = "Qutebrowser 主题，默认跟随程序启用状态";
        };
      };
      
      # 其他工具
      others = {
        rofi.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.rofi.enable or false;
          description = "Rofi 主题，默认跟随程序启用状态";
        };
        mako.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.services.mako.enable or false;
          description = "Mako 主题，默认跟随程序启用状态";
        };
        dunst.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.services.dunst.enable or false;
          description = "Dunst 主题，默认跟随程序启用状态";
        };
        waybar.enable = lib.mkOption {
          type = lib.types.bool;
          default = config.programs.waybar.enable or false;
          description = "Waybar 主题，默认跟随程序启用状态";
        };
      };
    };
  };

  config = lib.mkIf config.myHome.profiles.stylix.enable {
    # 直接使用 Stylix 官方 Home Manager 配置
    stylix = {
      enable = true;
      
      # 用户覆盖配置（可选）
      image = lib.mkIf (config.myHome.profiles.stylix.image != null)
        config.myHome.profiles.stylix.image;
      
      base16Scheme = lib.mkIf (config.myHome.profiles.stylix.colorScheme != null)
        config.myHome.profiles.stylix.colorScheme;
      
      polarity = lib.mkIf (config.myHome.profiles.stylix.polarity != null)
        config.myHome.profiles.stylix.polarity;
      
      # 字体大小覆盖
      fonts.sizes = lib.filterAttrs (_: v: v != null) {
        applications = config.myHome.profiles.stylix.fontSize.applications;
        terminal = config.myHome.profiles.stylix.fontSize.terminal;
        desktop = config.myHome.profiles.stylix.fontSize.desktop;
        popups = config.myHome.profiles.stylix.fontSize.popups;
      };
      
      # 目标应用配置
      targets = {
        # 终端
        alacritty.enable = config.myHome.profiles.stylix.targets.terminals.alacritty.enable;
        kitty.enable = config.myHome.profiles.stylix.targets.terminals.kitty.enable;
        wezterm.enable = config.myHome.profiles.stylix.targets.terminals.wezterm.enable;
        
        # 编辑器
        vim.enable = config.myHome.profiles.stylix.targets.editors.vim.enable;
        neovim.enable = config.myHome.profiles.stylix.targets.editors.neovim.enable;
        emacs.enable = config.myHome.profiles.stylix.targets.editors.emacs.enable;
        
        # 工具
        tmux.enable = config.myHome.profiles.stylix.targets.tools.tmux.enable;
        bat.enable = config.myHome.profiles.stylix.targets.tools.bat.enable;
        fzf.enable = config.myHome.profiles.stylix.targets.tools.fzf.enable;
        zellij.enable = config.myHome.profiles.stylix.targets.tools.zellij.enable;
        
        # 桌面
        gtk.enable = config.myHome.profiles.stylix.targets.desktop.gtk.enable;
        qt.enable = config.myHome.profiles.stylix.targets.desktop.qt.enable;
        
        # 浏览器
        firefox.enable = config.myHome.profiles.stylix.targets.browsers.firefox.enable;
        qutebrowser.enable = config.myHome.profiles.stylix.targets.browsers.qutebrowser.enable;
        
        # 其他
        rofi.enable = config.myHome.profiles.stylix.targets.others.rofi.enable;
        mako.enable = config.myHome.profiles.stylix.targets.others.mako.enable;
        dunst.enable = config.myHome.profiles.stylix.targets.others.dunst.enable;
        waybar.enable = config.myHome.profiles.stylix.targets.others.waybar.enable;
      };
    };
  };
}
