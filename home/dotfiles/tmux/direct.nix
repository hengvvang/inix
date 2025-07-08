{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.tmux.enable && 
                    config.myHome.dotfiles.tmux.method == "direct") {
    home.packages = with pkgs; [ tmux ];
    
    # 直接写入配置文件
    home.file.".config/tmux/tmux.conf" = {
      source = ./configs/tmux.conf;
      executable = false;
    };
  };
}
