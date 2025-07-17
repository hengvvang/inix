{ config, pkgs, lib, ... }:

{
  options.mySystem.profiles.stylix = {
    enable = lib.mkEnableOption "系统级 Stylix 主题配置";
    
    # 主题极性 - 与 home/profiles/stylix 相同的选项结构
    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "系统默认主题极性（明亮/暗色）";
    };
    
    # 壁纸配置 - 与 home 版本保持一致的结构
    wallpapers = {
      enable = lib.mkEnableOption "系统级 Stylix 壁纸配置";
      
      # 系统默认壁纸选择
      preset = lib.mkOption {
        type = lib.types.enum [ "sea" "home" "maori" "pixabay" "blue-sky"];
        default = "sea";
        description = "系统默认壁纸选择";
      };
      
      # 系统自定义壁纸路径
      custom = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "系统自定义壁纸路径，优先于预设壁纸";
      };
    };
    
    # 字体配置 - 与 home 版本结构对称
    fonts = {
      enable = lib.mkEnableOption "系统级 Stylix 字体配置";
      
      # 系统字体包选择
      packages = {
        monospace = lib.mkOption {
          type = lib.types.package;
          default = pkgs.nerd-fonts.jetbrains-mono;
          description = "系统等宽字体包";
        };
        
        sansSerif = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts;
          description = "系统无衬线字体包";
        };
        
        serif = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts;
          description = "系统衬线字体包";
        };
        
        emoji = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts-emoji;
          description = "系统表情字体包";
        };
      };
      
      # 系统字体名称
      names = {
        monospace = lib.mkOption {
          type = lib.types.str;
          default = "JetBrainsMono Nerd Font Mono";
          description = "系统等宽字体名称";
        };
        
        sansSerif = lib.mkOption {
          type = lib.types.str;
          default = "Noto Sans";
          description = "系统无衬线字体名称";
        };
        
        serif = lib.mkOption {
          type = lib.types.str;
          default = "Noto Serif";
          description = "系统衬线字体名称";
        };
        
        emoji = lib.mkOption {
          type = lib.types.str;
          default = "Noto Color Emoji";
          description = "系统表情字体名称";
        };
      };
      
      # 系统字体大小 - 提供所有用户的默认值
      sizes = {
        applications = lib.mkOption {
          type = lib.types.int;
          default = 11;
          description = "系统应用程序字体大小";
        };
        
        terminal = lib.mkOption {
          type = lib.types.int;
          default = 12;
          description = "系统终端字体大小";
        };
        
        desktop = lib.mkOption {
          type = lib.types.int;
          default = 10;
          description = "系统桌面字体大小";
        };
        
        popups = lib.mkOption {
          type = lib.types.int;
          default = 10;
          description = "系统弹窗字体大小";
        };
      };
    };
    
    # 系统目标应用配置 - 主要是系统级组件
    targets = {
      enable = lib.mkEnableOption "系统级 Stylix 目标应用配置";
      
      # 系统启动和登录
      boot = {
        grub.enable = lib.mkEnableOption "GRUB 引导主题";
        plymouth.enable = lib.mkEnableOption "Plymouth 启动画面主题";
      };
      
      # 登录管理器
      display = {
        lightdm.enable = lib.mkEnableOption "LightDM 登录主题";
        gdm.enable = lib.mkEnableOption "GDM 登录主题";
        sddm.enable = lib.mkEnableOption "SDDM 登录主题";
      };
      
      # 系统级桌面环境
      desktop = {
        gtk.enable = lib.mkEnableOption "系统级 GTK 主题";
        qt.enable = lib.mkEnableOption "系统级 Qt 主题";
      };
      
      # 用户应用的系统默认值（用户可覆盖）
      userDefaults = {
        terminals = {
          alacritty.enable = lib.mkEnableOption "系统默认 Alacritty 主题";
          kitty.enable = lib.mkEnableOption "系统默认 Kitty 主题";
        };
        
        editors = {
          vim.enable = lib.mkEnableOption "系统默认 Vim 主题";
          neovim.enable = lib.mkEnableOption "系统默认 Neovim 主题";
        };
        
        browsers = {
          firefox.enable = lib.mkEnableOption "系统默认 Firefox 主题";
        };
      };
    };
  };

  imports = [
    ./wallpapers.nix
    ./fonts.nix
    ./targets.nix
    # ./colors.nix  # 可以复用 home 版本的逻辑
  ];

  # 系统级 Stylix 配置 - 为所有用户提供基础
  config = lib.mkIf config.mySystem.profiles.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;  # 完全手动控制，避免意外启用
      
      # 系统基础配置
      image = 
        if config.mySystem.profiles.stylix.wallpapers.custom != null
        then config.mySystem.profiles.stylix.wallpapers.custom
        else ./wallpapers + "/${config.mySystem.profiles.stylix.wallpapers.preset}.jpg";
        
      polarity = config.mySystem.profiles.stylix.polarity;
      
      # 系统级字体配置
      fonts = lib.mkIf config.mySystem.profiles.stylix.fonts.enable {
        monospace = {
          package = config.mySystem.profiles.stylix.fonts.packages.monospace;
          name = config.mySystem.profiles.stylix.fonts.names.monospace;
        };
        
        sansSerif = {
          package = config.mySystem.profiles.stylix.fonts.packages.sansSerif;
          name = config.mySystem.profiles.stylix.fonts.names.sansSerif;
        };
        
        serif = {
          package = config.mySystem.profiles.stylix.fonts.packages.serif;
          name = config.mySystem.profiles.stylix.fonts.names.serif;
        };
        
        emoji = {
          package = config.mySystem.profiles.stylix.fonts.packages.emoji;
          name = config.mySystem.profiles.stylix.fonts.names.emoji;
        };
        
        sizes = {
          applications = config.mySystem.profiles.stylix.fonts.sizes.applications;
          terminal = config.mySystem.profiles.stylix.fonts.sizes.terminal;
          desktop = config.mySystem.profiles.stylix.fonts.sizes.desktop;
          popups = config.mySystem.profiles.stylix.fonts.sizes.popups;
        };
      };
    };
  };
}
