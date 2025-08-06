{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.qutebrowser = {
    enable = lib.mkEnableOption "Qutebrowser dotfiles 配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = "Qutebrowser 配置方式";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
