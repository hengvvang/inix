{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "external") {
    home.packages = with pkgs; [ git ];
    
    home.file.".gitconfig" = {
      source = ./configs/gitconfig;
      # 设置为只读，确保配置文件不被意外修改
      # readonly = true;  # 可选，如果希望可以手动修改配置则注释此行
    };
    
    home.file.".gitignore" = {
      source = ./configs/gitignore;
      # readonly = true;  # 可选
    };
  };
}