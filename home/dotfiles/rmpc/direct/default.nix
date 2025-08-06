{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "direct") {
    home.packages = with pkgs; [
      rmpc
    ];

    # RMPC配置文件通常在~/.config/rmpc/目录
    home.file.".config/rmpc/config.toml".text = ''
      [mpd]
      host = "localhost"
      port = 6600
      
      [theme]
      accent_color = "blue"
    '';
  };
}
