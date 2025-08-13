{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.mySystem.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 系统级主题配置";
    
    # 壁纸配置 - 简化为直接路径或预设
    image = lib.mkOption {
      type = lib.types.path;
      default = ./wallpapers/sea.jpg;
      description = "系统壁纸路径";
    };
    
    # 颜色方案配置
    colorScheme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "颜色方案文件路径，为空时从壁纸自动生成";
      example = "\${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    };
    
    # 主题极性
    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "主题极性";
    };
    
    # 字体配置
    fonts = {
      monospace = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.nerd-fonts.jetbrains-mono;
          description = "系统等宽字体包";
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = "JetBrainsMono Nerd Font Mono";
          description = "系统等宽字体名称";
        };
      };
      
      sansSerif = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts;
          description = "系统无衬线字体包";
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = "Noto Sans";
          description = "系统无衬线字体名称";
        };
      };
      
      serif = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts;
          description = "系统衬线字体包";
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = "Noto Serif";
          description = "系统衬线字体名称";
        };
      };
      
      emoji = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts-emoji;
          description = "系统表情字体包";
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = "Noto Color Emoji";
          description = "系统表情字体名称";
        };
      };
      
      sizes = {
        applications = lib.mkOption {
          type = lib.types.int;
          default = 11;
          description = "应用程序字体大小";
        };
        terminal = lib.mkOption {
          type = lib.types.int;
          default = 12;
          description = "终端字体大小";
        };
        desktop = lib.mkOption {
          type = lib.types.int;
          default = 10;
          description = "桌面字体大小";
        };
        popups = lib.mkOption {
          type = lib.types.int;
          default = 10;
          description = "弹窗字体大小";
        };
      };
    };
  };

  config = lib.mkIf config.mySystem.profiles.stylix.enable {
    # 直接使用 Stylix 官方配置结构
    stylix = {
      enable = true;
      
      # 壁纸设置
      image = config.mySystem.profiles.stylix.image;
      
      # 颜色方案 - 可选，不设置时从壁纸自动生成
      base16Scheme = lib.mkIf (config.mySystem.profiles.stylix.colorScheme != null)
        config.mySystem.profiles.stylix.colorScheme;
      
      # 主题极性
      polarity = config.mySystem.profiles.stylix.polarity;
      
      # 字体配置
      fonts = {
        monospace = {
          package = config.mySystem.profiles.stylix.fonts.monospace.package;
          name = config.mySystem.profiles.stylix.fonts.monospace.name;
        };
        sansSerif = {
          package = config.mySystem.profiles.stylix.fonts.sansSerif.package;
          name = config.mySystem.profiles.stylix.fonts.sansSerif.name;
        };
        serif = {
          package = config.mySystem.profiles.stylix.fonts.serif.package;
          name = config.mySystem.profiles.stylix.fonts.serif.name;
        };
        emoji = {
          package = config.mySystem.profiles.stylix.fonts.emoji.package;
          name = config.mySystem.profiles.stylix.fonts.emoji.name;
        };
        sizes = {
          applications = config.mySystem.profiles.stylix.fonts.sizes.applications;
          terminal = config.mySystem.profiles.stylix.fonts.sizes.terminal;
          desktop = config.mySystem.profiles.stylix.fonts.sizes.desktop;
          popups = config.mySystem.profiles.stylix.fonts.sizes.popups;
        };
      };
      
      # 系统级目标应用 - 只配置系统级组件
      targets = {
        # 引导程序主题
        grub.enable = true;
        
        # 控制台主题  
        console.enable = true;
        
        # 系统级 GTK 主题
        gtk.enable = true;
        
        # Plymouth 启动画面（如果使用）
        plymouth.enable = lib.mkDefault false;
      };
      
      # Home Manager 集成设置
      homeManagerIntegration = {
        # 自动为所有用户导入 Home Manager 模块
        autoImport = true;
        # 用户配置跟随系统配置
        followSystem = true;
      };
    };
  };
}
