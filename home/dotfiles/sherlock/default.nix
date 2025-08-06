# Sherlock Launcher dotfiles configuration
{ config, lib, pkgs, inputs, ... }:

{
  options.myHome.dotfiles.sherlock = {
    enable = lib.mkEnableOption "Sherlock Launcher 应用启动器配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "external";
      description = ''
        Sherlock 配置方式:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
        - direct: 直接安装包到环境 (演示用)  
        - external: 外部配置文件管理 (macOS Tahoe 风格)
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
