{ config, pkgs, lib, ... }:

{
  options.myHome.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 主题系统";
    
    # 主题极性
    polarity = lib.mkOption {
      type = lib.types.enum [ "light" "dark" ];
      default = "dark";
      description = "主题极性（明亮/暗色）";
    };
    
    # 壁纸配置
    wallpapers = {
      enable = lib.mkEnableOption "Stylix 壁纸配置";
      
      # 预设壁纸选择
      preset = lib.mkOption {
        type = lib.types.enum [ "sea" "forest" "mountain" "city" "abstract" ];
        default = "sea";
        description = "预设壁纸选择";
      };
      
      # 自定义壁纸路径
      custom = lib.mkOption {
        type = lib.types.nullOr lib.types.path;
        default = null;
        description = "自定义壁纸路径，优先于预设壁纸";
      };
    };
    
    # 字体配置
    fonts = {
      enable = lib.mkEnableOption "Stylix 字体配置";
      
      # 字体包选择
      packages = {
        monospace = lib.mkOption {
          type = lib.types.package;
          default = pkgs.nerd-fonts.jetbrains-mono;
          description = "等宽字体包";
        };
        
        sansSerif = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts;
          description = "无衬线字体包";
        };
        
        serif = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts;
          description = "衬线字体包";
        };
        
        emoji = lib.mkOption {
          type = lib.types.package;
          default = pkgs.noto-fonts-emoji;
          description = "表情字体包";
        };
      };
      
      # 字体名称
      names = {
        monospace = lib.mkOption {
          type = lib.types.str;
          default = "JetBrainsMono Nerd Font Mono";
          description = "等宽字体名称";
        };
        
        sansSerif = lib.mkOption {
          type = lib.types.str;
          default = "Noto Sans";
          description = "无衬线字体名称";
        };
        
        serif = lib.mkOption {
          type = lib.types.str;
          default = "Noto Serif";
          description = "衬线字体名称";
        };
        
        emoji = lib.mkOption {
          type = lib.types.str;
          default = "Noto Color Emoji";
          description = "表情字体名称";
        };
      };
      
      # 字体大小
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
    
    # 目标应用配置
    targets = {
      enable = lib.mkEnableOption "Stylix 目标应用配置";
      
      # 终端应用
      terminals = {
        alacritty.enable = lib.mkEnableOption "Alacritty 主题";
        kitty.enable = lib.mkEnableOption "Kitty 主题";
      };
      
      # 编辑器
      editors = {
        vim.enable = lib.mkEnableOption "Vim 主题";
        neovim.enable = lib.mkEnableOption "Neovim 主题";
      };
      
      # 工具
      tools = {
        tmux.enable = lib.mkEnableOption "Tmux 主题";
        bat.enable = lib.mkEnableOption "Bat 主题";
        fzf.enable = lib.mkEnableOption "Fzf 主题";
      };
      
      # 桌面环境
      desktop = {
        gtk.enable = lib.mkEnableOption "GTK 主题";
      };
      
      # 浏览器
      browsers = {
        firefox.enable = lib.mkEnableOption "Firefox 主题";
      };
    };
  };

  imports = [
    ./wallpapers.nix
    ./fonts.nix
    ./targets.nix
    ./colors.nix
  ];

  # 核心 Stylix 配置直接在 default.nix 中处理
  config = lib.mkIf config.myHome.profiles.stylix.enable {
    stylix = {
      enable = true;
      autoEnable = false;  # 完全手动控制
      
      # 基础配置
      image = 
        if config.myHome.profiles.stylix.wallpapers.custom != null
        then config.myHome.profiles.stylix.wallpapers.custom
        else ./wallpapers + "/${config.myHome.profiles.stylix.wallpapers.preset}.jpg";
        
      polarity = config.myHome.profiles.stylix.polarity;
    };
  };
}
