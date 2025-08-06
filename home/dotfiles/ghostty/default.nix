{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.ghostty = {
    enable = lib.mkEnableOption "Ghostty dotfiles 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "direct";
      description = "Ghostty 配置方式";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
