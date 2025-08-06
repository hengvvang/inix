{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.yazi = {
    enable = lib.mkEnableOption "Yazi dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = "Yazi 配置方式";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
