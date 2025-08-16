{ config, lib, pkgs, ... }:

{
  imports = [
    ./mpd.nix
  ];

  options.myHome.services.media = {
    enable = lib.mkEnableOption "家庭媒体服务模块";
    mpd = {
      enable = lib.mkEnableOption "MPD 音乐播放器服务";
      musicDirectory = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/Music";
        description = "音乐文件目录路径";
      };
      port = lib.mkOption {
        type = lib.types.port;
        default = 6600;
        description = "MPD 服务监听端口";
      };
      autoStart = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "是否开机自动启动 MPD 服务";
      };
      clients = {
        mpc = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "是否安装 mpc 命令行客户端";
        };
        rmpc = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "是否安装 rmpc 终端客户端";
        };
      };
    };
  };
}
