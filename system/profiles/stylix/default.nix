{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./wallpapers.nix
    ./fonts.nix
    ./targets.nix
    ./colors.nix
  ];

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
    
    # 系统目标应用配置 - 仅包含确定存在的系统级组件
    targets = {
      enable = lib.mkEnableOption "系统级 Stylix 目标应用配置";
      
      # 系统启动
      boot = {
        grub.enable = lib.mkEnableOption "GRUB 引导主题";
      };
      
      # 系统级桌面环境
      desktop = {
        gtk.enable = lib.mkEnableOption "系统级 GTK 主题";
      };
      
      # 系统控制台
      console.enable = lib.mkEnableOption "系统控制台主题";
    };
    
    # 颜色自定义配置 - 与 home 版本保持一致
    colors = {
      enable = lib.mkEnableOption "系统级 Stylix 自定义颜色配置";
      
      scheme = lib.mkOption {
        type = lib.types.enum [ 
          # 🎨 自定义主题
          "warm-white"        # 🤍 简约白色暖色调（推荐亮色主题）
          "cool-blue"         # 🩵 冷静蓝色主题
          "forest-green"      # 🌿 森林绿色主题 
          "sunset-orange"     # 🧡 日落橙色主题
          "lavender-purple"   # 💜 薰衣草紫色主题
          "dark-elegant"      # 🖤 优雅深色主题
          
          # 🔄 动态主题
          "auto"              # 从壁纸自动生成
          
          # 🔥 热门预设主题
          "gruvbox-light"     # Gruvbox 亮色
          "gruvbox-dark-hard" # Gruvbox 深色
          "solarized-light"   # Solarized 亮色
          "solarized-dark"    # Solarized 深色
          "nord"              # Nord 北欧风
          "dracula"           # Dracula 吸血鬼
          "tokyo-night"       # 东京夜色
          "catppuccin-latte"  # Catppuccin 亮色
          "catppuccin-mocha"  # Catppuccin 深色
          "one-light"         # Atom One 亮色
          "one-dark"          # Atom One 深色
        ];
        default = "warm-white";  # 🤍 默认使用简约白色暖色调
        description = "系统颜色方案选择";
      };
      
      # 自定义颜色覆盖
      override = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = "系统自定义颜色覆盖 (base00-base0F)";
        example = {
          base00 = "ffffff";  # 背景
          base05 = "000000";  # 前景
        };
      };
    };
  };


  # 系统级 Stylix 配置 - 为所有用户提供基础
  config = lib.mkIf config.mySystem.profiles.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;  # 完全手动控制，避免意外启用
      
      # 系统基础配置
      image = lib.mkIf (!config.mySystem.profiles.stylix.colors.enable || config.mySystem.profiles.stylix.colors.scheme == "auto") (
        if config.mySystem.profiles.stylix.wallpapers.custom != null
        then config.mySystem.profiles.stylix.wallpapers.custom
        else ./wallpapers + "/${config.mySystem.profiles.stylix.wallpapers.preset}.jpg"
      );
        
      polarity = config.mySystem.profiles.stylix.polarity;
      
      # 颜色覆盖
      override = lib.mkIf (config.mySystem.profiles.stylix.colors.override != {}) 
        config.mySystem.profiles.stylix.colors.override;
      
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
