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
    
    home.username = "zlritsu";
    home.homeDirectory = "/home/zlritsu";
    home.stateVersion = "25.05";
    
    # 通用配置 - 所有主机共享，zlritsu 使用轻量级配置
    myHome = {
      develop.enable = true;
      dotfiles.enable = true;
      profiles = {
        enable = true;
        stylix = {
          enable = true;
          polarity = "dark";
          wallpapers = {
            enable = true;
            preset = "forest";  # zlritsu 使用不同的预设壁纸
          };
          fonts = {
            enable = true;
            # 轻量级字体配置
            sizes = {
              applications = 10;  # 更小的字体
              terminal = 11;
            };
          };
          targets = {
            enable = true;
            terminals = {
              alacritty.enable = false;
              kitty.enable = false;  # zlritsu 不使用高级终端
            };
            editors = {
              vim.enable = true;
              neovim.enable = false;  # zlritsu 只用基础 vim
            };
            tools = {
              tmux.enable = false;  # zlritsu 不使用 tmux
              bat.enable = false;   # 轻量级配置
              fzf.enable = false;   # 轻量级配置
            };
            desktop = {
              gtk.enable = true;    # 基础 GTK 主题
            };
            browsers = {
              firefox.enable = true;
            };
          };
        };
      };
      pkgs = {
        enable = true;                # 启用用户包管理
        # 工具包配置 - 从系统配置迁移，zlritsu 使用轻量级配置
        toolkits = {
          enable = true;              # 启用工具包模块
          files.enable = true;        # 启用文件管理工具
          text.enable = true;         # 启用文本处理工具
          network.enable = false;     # zlritsu 轻量级配置 - 禁用网络工具
          monitor.enable = false;     # zlritsu 轻量级配置 - 禁用监控工具
          develop.enable = false;     # zlritsu 轻量级配置 - 禁用开发工具
        };
        # 应用程序配置 - 从系统配置迁移，zlritsu 使用轻量级配置
        apps = {
          enable = true;              # 启用应用程序模块
          shells.enable = true;       # 启用 shell 程序
          terminals.enable = true;    # 启用终端应用
          develop.enable = false;     # zlritsu 轻量级配置 - 禁用开发工具
          browsers.enable = true;     # 启用浏览器
          communication.enable = false;  # zlritsu 轻量级配置 - 禁用通讯软件
          media.enable = true;        # 启用媒体应用
          office.enable = false;      # zlritsu 轻量级配置 - 禁用办公软件
          gaming.enable = false;      # zlritsu 轻量级配置 - 禁用游戏
          network.enable = false;     # zlritsu 轻量级配置 - 禁用网络工具
        };
      };
    };
    
    programs.home-manager.enable = true;
  };
}
