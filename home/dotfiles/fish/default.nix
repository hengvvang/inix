{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.fish = {
    enable = lib.mkEnableOption "Fish Shell 终端配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        Fish 配置方式:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
        - direct: 直接安装包到环境 (演示用)
        - external: 外部配置文件管理 (演示用)
        - xdirect: 扩展直接配置 (演示用)
      '';
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
