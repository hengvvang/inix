{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.tmux = {

    enable = lib.mkEnableOption "Tmux 会话管理配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        Tmux 配置方式选择:
        - homemanager: 使用 Home Manager 的 programs.tmux 模块 (推荐)
        - direct: 直接通过 Home Manager 配置文件管理
        - external: 使用外部配置文件
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
