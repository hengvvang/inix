{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.nushell = {
    enable = lib.mkEnableOption "Nushell dotfiles 配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = "Nushell 配置方式";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
