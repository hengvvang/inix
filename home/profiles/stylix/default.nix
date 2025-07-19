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
        type = lib.types.enum [ "sea" "home" "maori" "pixabay" "blue-sky"];
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
         # 输入法
    inputMethods = {
      fcitx5.enable = lib.mkEnableOption "Fcitx5 主题";
    };
  };
  
  # 颜色自定义配置
  colors = {
    enable = lib.mkEnableOption "Stylix 自定义颜色配置";
    
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
        
        # 🌹 Rose Pine 系列
        "rose-pine"         # Rose Pine 标准版
        "rose-pine-moon"    # Rose Pine Moon 月夜版
        "rose-pine-dawn"    # Rose Pine Dawn 晨曦版
        
        # 😺 Catppuccin 系列
        "catppuccin-latte"  # Catppuccin 拿铁（浅色）
        "catppuccin-frappe" # Catppuccin 法芮（中度深色）
        "catppuccin-macchiato" # Catppuccin 玛奇朵（深色）
        "catppuccin-mocha"  # Catppuccin 摩卡（最深色）
        
        # 🔥 热门预设主题
        "gruvbox-light"     # Gruvbox 亮色
        "gruvbox-dark-hard" # Gruvbox 深色
        "gruvbox-dark-medium" # Gruvbox 中度深色
        "gruvbox-dark-soft" # Gruvbox 柔和深色
        "solarized-light"   # Solarized 亮色
        "solarized-dark"    # Solarized 深色
        "nord"              # Nord 北欧风
        "dracula"           # Dracula 吸血鬼
        "tokyo-night"       # 东京夜色
        "tokyo-night-light" # 东京夜色 浅色版
        "tokyo-night-storm" # 东京夜色 暴风版
        "one-light"         # Atom One 亮色
        "one-dark"          # Atom One 深色
        "monokai"           # Monokai 经典
        "github-light"      # GitHub 浅色
        "github-dark"       # GitHub 深色
        "material-darker"   # Material Darker
        "material-palenight" # Material Palenight
        "ayu-light"         # Ayu 浅色
        "ayu-mirage"        # Ayu 海市蜃楼
        "ayu-dark"          # Ayu 深色
      ];
      default = "rose-pine";  # 🌹 默认使用 Rose Pine
      description = "颜色方案选择";
    };
    
    # 自定义颜色覆盖
    override = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "自定义颜色覆盖 (base00-base0F)";
      example = {
        base00 = "ffffff";  # 背景
        base05 = "000000";  # 前景
      };
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
      image = lib.mkIf (!config.myHome.profiles.stylix.colors.enable || config.myHome.profiles.stylix.colors.scheme == "auto") (
        if config.myHome.profiles.stylix.wallpapers.custom != null
        then config.myHome.profiles.stylix.wallpapers.custom
        else ./wallpapers + "/${config.myHome.profiles.stylix.wallpapers.preset}.jpg"
      );
        
      polarity = config.myHome.profiles.stylix.polarity;
      
      # 颜色覆盖
      override = lib.mkIf (config.myHome.profiles.stylix.colors.override != {}) 
        config.myHome.profiles.stylix.colors.override;
    };
  };
}
