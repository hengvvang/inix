{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.alacritty = {
    enable = lib.mkEnableOption "Alacritty 终端配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "Alacritty 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
