# MPD 音乐播放器守护进程配置
{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.mpd = {
    enable = lib.mkEnableOption "MPD 音乐播放器守护进程配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = "配置方法选择";
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix        # 直接配置方式
    ./external.nix      # 外部服务器连接方式
  ];
}
