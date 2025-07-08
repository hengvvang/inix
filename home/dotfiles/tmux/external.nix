{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.tmux.enable && 
                    config.myHome.dotfiles.tmux.method == "external") {
    home.packages = with pkgs; [ tmux ];
    
    # 外部配置文件引用
    home.file.".config/tmux/tmux.conf" = {
      source = ./configs/tmux.conf;
      executable = false;
    };
  };
}
