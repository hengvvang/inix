{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.git = {
    enable = lib.mkEnableOption "Git dotfiles 配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "Git 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
