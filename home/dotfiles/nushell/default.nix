{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.nushell = {
    enable = lib.mkEnableOption "Nushell dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "template" ];
      default = "homemanager";
      description = "Nushell 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
    ./template.nix
  ];
}
