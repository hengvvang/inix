{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "xdirect") {
    home.packages = lib.optionals config.myHome.dotfiles.qutebrowser.packageEnable (with pkgs; [
      qutebrowser
      yt-dlp
      mpv
    ]);

    home.file.".config/qutebrowser/config.py".text = builtins.readFile ./configs/config.py;
    home.file.".config/qutebrowser/quickmarks".text = builtins.readFile ./configs/quickmarks;
  };
}
