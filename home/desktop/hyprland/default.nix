{ config, lib, pkgs, ... }:

{
  options.myHome.desktop.hyprland = {
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        配置方式选择:
        - homemanager: 使用 Home Manager 程序模块
        - direct: 直接文件写入方式
        - external: 外部文件引用方式
      '';
    };
  };

  imports = [
    # ./homemanager
    # ./direct
    ./external
  ];
}
