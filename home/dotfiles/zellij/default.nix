{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.zellij = {
    # 基本启用选项
    enable = lib.mkEnableOption "Zellij 终端多路复用器配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        Zellij 配置方式选择:
        - homemanager: 使用 Home Manager 的 programs.zellij 模块 (推荐)
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
