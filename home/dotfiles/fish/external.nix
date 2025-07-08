{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "external") {
    home.packages = with pkgs; [ fish ];
    
    # 外部文件引用 - 演示用简化配置
    home.file.".config/fish/config.fish".source = ./configs/config.fish;
    # 注意：此方式需要手动维护 configs/ 目录下的配置文件
  };
}
