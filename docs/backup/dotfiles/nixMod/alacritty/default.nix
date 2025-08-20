{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.alacritty = {
    enable = lib.mkEnableOption "Alacritty 终端配置";

    packageEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装 Alacritty 软件包 (设为 false 时仅应用配置文件)";
    };

    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        Alacritty 配置方式:
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
