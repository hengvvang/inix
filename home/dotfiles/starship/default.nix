{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.starship = {
    enable = lib.mkEnableOption "Starship 跨 Shell 提示符配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        Starship 配置方式:
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
