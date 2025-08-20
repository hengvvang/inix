{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.yazi = {
    enable = lib.mkEnableOption "Yazi dotfiles 配置";

    packageEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装 Yazi 软件包 (设为 false 时仅应用配置文件)";
    };

    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = "Yazi 配置方式";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
