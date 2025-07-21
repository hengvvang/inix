# rmpc 终端音乐播放器配置
{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.rmpc = {
    enable = lib.mkEnableOption "rmpc 终端音乐播放器配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        rmpc 配置方法选择:
        - homemanager: 使用 Home Manager 管理配置 (推荐)
        - direct: 直接写入配置文件
        - external: 引用外部配置文件
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}