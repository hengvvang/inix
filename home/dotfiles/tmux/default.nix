{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.tmux = {
    enable = lib.mkEnableOption "Tmux 会话管理配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "Tmux 配置方式";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
