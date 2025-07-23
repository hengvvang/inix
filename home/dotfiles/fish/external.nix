{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.fish.enable && config.myHome.dotfiles.fish.method == "external") {
    
    home.packages = with pkgs; [ fish ];
    
    # Fish Shell 配置文件结构
    # 主配置文件
    home.file.".config/fish/config.fish".source = ./configs/config.fish;
    
    # 自定义函数目录
    home.file.".config/fish/functions".source = ./configs/functions;
    
    # 自动加载的配置片段目录
    home.file.".config/fish/conf.d".source = ./configs/conf.d;
    
    # 自定义补全目录
    home.file.".config/fish/completions".source = ./configs/completions;
  };
}
