{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.rio = {

    enable = lib.mkEnableOption "Rio 现代化终端配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        Rio 配置方式选择:
        - homemanager: 使用 Home Manager 直接配置 (推荐)
        - direct: 直接通过 Home Manager 配置文件管理
        - external: 使用外部配置文件
        - xdirect: 使用 builtins.readFile 读取外部文件
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
