{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.rmpc = {
    enable = lib.mkEnableOption "RMPC 音乐播放器客户端配置";

    packageEnable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装 RMPC 软件包 (设为 false 时仅应用配置文件)";
    };

    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = ''
        RMPC 配置方式:
        - homemanager: 使用 Home Manager 管理配置 (推荐)
        - direct: 直接写入配置文件 (演示用)
        - external: 引用外部配置文件 (演示用)
        - xdirect: 使用 builtins.readFile 引用配置 (演示用)
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
