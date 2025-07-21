# MPD 客户端工具和脚本配置
# 注意: MPD 服务本身在系统服务中配置 (system/services/media/mpd.nix)
{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.mpd = {
    enable = lib.mkEnableOption "MPD 客户端工具和脚本配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        MPD 客户端配置方法选择:
        - homemanager: 使用 Home Manager 管理客户端工具 (推荐)
        - direct: 直接配置客户端脚本
        - external: 引用外部客户端配置
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
