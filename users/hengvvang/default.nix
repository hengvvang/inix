{ config, pkgs, lib, ... }:

{
  imports = [
    # 使用新的模块化配置
    ../../home
    # 导入不同主机配置
    ./laptop.nix
    ./daily.nix
    ./work.nix
  ];
  
  # 主机选项
  options.host = lib.mkOption {
    type = lib.types.enum [ "laptop" "daily" "work" ];
    default = "laptop";
    description = "Host type";
  };
  
  # 基础通用配置
  config = {
    # 允许非自由软件
    nixpkgs.config.allowUnfree = true;
    
    home.username = "hengvvang";
    home.homeDirectory = "/home/hengvvang";
    home.stateVersion = "25.05";
    
    # 通用配置 - 所有主机共享
    myHome = {
      develop.enable = true;
      dotfiles.enable = true;
      profiles = {
        enable = true;
        stylix = {
          enable = false;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "sea";
          };
          fonts = {
            enable = true;
            # 使用默认字体配置，也可以自定义
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;  # 避免与现有 alacritty 配置冲突
              kitty.enable = true;
            };
            editors = {
              vim.enable = true;
              neovim.enable = true;
            };
            tools = {
              tmux.enable = true;
              bat.enable = true;
              fzf.enable = true;
            };
            desktop = {
              gtk.enable = true;
            };
            browsers = {
              firefox.enable = true;
            };
          };
        };
      };
      pkgs = {
        enable = true;                # 启用用户包管理
        # 工具包配置 - 从系统配置迁移
        toolkits = {
          enable = true;              # 启用工具包模块
          files.enable = true;        # 启用文件管理工具 (ranger, nnn, etc.)
          text.enable = true;         # 启用文本处理工具 (grep, sed, awk, etc.)
          network.enable = true;      # 启用网络工具包 (curl, wget, etc.)
          monitor.enable = true;      # 启用系统监控工具 (htop, btop, etc.)
          develop.enable = true;      # 启用开发工具包 (git, make, etc.)
        };
        # 应用程序配置 - 从系统配置迁移，启用所有应用
        apps = {
          enable = true;              # 启用应用程序模块
          shells.enable = true;       # 启用 shell 程序 (zsh, fish, etc.)
          terminals.enable = true;    # 启用终端应用 (alacritty, kitty, etc.)
          develop.enable = true;      # 启用开发工具 (编辑器, IDE, etc.)
          browsers.enable = true;     # 启用浏览器 (firefox, chromium, etc.)
          communication.enable = true; # 启用通讯软件 (telegram, discord, etc.)
          media.enable = true;        # 启用媒体应用 (mpv, vlc, spotify, etc.)
          office.enable = true;       # 启用办公软件 (libreoffice, etc.)
          gaming.enable = true;       # 启用游戏相关 (steam, lutris, etc.)
          network.enable = true;      # 启用网络工具 (wireshark, nmap, etc.)
        };
      };
    };
    
    programs.home-manager.enable = true;
  };
}
