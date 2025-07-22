{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
  
  # 主题文件映射
  rosePineTheme = ./configs/themes/rose-pine.ron;
  rosePineDawnTheme = ./configs/themes/rose-pine-dawn.ron; 
  rosePineMoonTheme = ./configs/themes/rose-pine-moon.ron;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && 
                    config.myHome.dotfiles.rmpc.method == "external") {
    home.packages = with pkgs; [ rmpc ];
    
    # 外部配置文件引用 - 仅作为演示配置方式
    # 注意：此方式需要手动维护 configs/config.ron 文件
    home.file.".config/rmpc/config.ron" = {
      source = ./configs/config.ron;
      executable = false;
    };
    
    # 主题文件 - 根据选择复制对应主题
    home.file.".config/rmpc/themes/rose-pine.ron" = lib.mkIf (cfg.theme == "rose-pine") {
      source = rosePineTheme;
    };
    
    home.file.".config/rmpc/themes/rose-pine-dawn.ron" = lib.mkIf (cfg.theme == "rose-pine-dawn") {
      source = rosePineDawnTheme;
    };
    
    home.file.".config/rmpc/themes/rose-pine-moon.ron" = lib.mkIf (cfg.theme == "rose-pine-moon") {
      source = rosePineMoonTheme;
    };
  };
}
