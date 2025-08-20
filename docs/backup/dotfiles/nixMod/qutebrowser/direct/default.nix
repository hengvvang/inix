{ config, lib, pkgs, ... }:

{
  imports = [
    ./config.py.nix
    ./quickmarks.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {

    home.packages = lib.optionals config.myHome.dotfiles.qutebrowser.packageEnable (with pkgs; [
      qutebrowser
    ]);

    home.file.".config/qutebrowser/quickmarks".text = ''
    '';

  };
}
