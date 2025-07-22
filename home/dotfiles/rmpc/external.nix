{ config, lib, pkgs, ... }:

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
  };
}
