{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.lazygit = {
    enable = lib.mkEnableOption "Lazygit dotfiles 配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "Lazygit 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
