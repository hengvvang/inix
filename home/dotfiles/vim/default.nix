{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.vim = {
    enable = lib.mkEnableOption "Vim dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "Vim 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
