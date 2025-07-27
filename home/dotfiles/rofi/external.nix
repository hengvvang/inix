{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "external") {

    # ===== 包依赖确保 =====
    # 确保必要的系统工具可用
    home.packages = with pkgs; [
      # 核心应用启动器
      rofi
      
      # 图标和字体支持
      papirus-icon-theme      # Papirus 图标主题
      nerd-fonts.fira-code    # Nerd Font 图标支持
    ];

    # ===== 配置文件链接 =====
    # 主配置文件
    home.file.".config/rofi/config.rasi".source = ./configs/config.rasi;
    
    # 主题配置
    home.file.".config/rofi/themes".source = ./configs/themes;

    # ===== 可执行脚本 =====
    # 主启动脚本
    home.file.".local/bin/rofi-launcher" = {
      source = ./configs/scripts/rofi-launcher.sh;
      executable = true;
    };
    
    # 电源菜单
    home.file.".local/bin/rofi-power" = {
      source = ./configs/scripts/rofi-power.sh;
      executable = true;
    };

    # ===== 环境变量设置 =====
    home.sessionVariables = {
      # Rofi 配置路径
      ROFI_CONFIG_DIR = "${config.home.homeDirectory}/.config/rofi";
      
      # 图标主题
      ROFI_ICON_THEME = "Papirus";
    };

    # ===== Shell 集成 =====
    # Bash 集成
    programs.bash.shellAliases = lib.mkIf config.programs.bash.enable {
      rofi = "rofi-launcher";
      rofi-power = "rofi-power";
    };

    # Fish 集成
    programs.fish.shellAliases = lib.mkIf config.programs.fish.enable {
      rofi = "rofi-launcher";
      rofi-power = "rofi-power";
    };

    # Zsh 集成
    programs.zsh.shellAliases = lib.mkIf config.programs.zsh.enable {
      rofi = "rofi-launcher";
      rofi-power = "rofi-power";
    };
  };
}
