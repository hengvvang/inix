{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "external") {


    home.packages = with pkgs; [
      papirus-icon-theme
    ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };

    # rofi 配置文件
    home.file.".config/rofi/config.rasi".source = ./configs/config.rasi;
    home.file.".config/rofi/themes".source = ./configs/themes;
    
    fonts.fontconfig.enable = true;
    
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
