{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.fish = {
    enable = lib.mkEnableOption "Fish dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "template" ];
      default = "homemanager";
      description = "Fish 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
    ./template.nix
  ];
}
