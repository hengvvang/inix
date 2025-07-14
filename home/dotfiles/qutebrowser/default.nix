{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.qutebrowser = {
    enable = lib.mkEnableOption "Qutebrowser dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "Qutebrowser 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
