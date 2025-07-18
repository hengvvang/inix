{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.tmux = {
    # 基本启用选项
    enable = lib.mkEnableOption "Tmux 会话管理配置";
    
    # 配置方式选择
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
    ./homemanager.nix  # Home Manager 原生配置
    ./direct.nix       # 直接配置文件管理
    ./external.nix     # 外部配置文件方式
  ];
}
