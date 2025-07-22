{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.rmpc = {
    enable = lib.mkEnableOption "RMPC 音乐播放器客户端配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        RMPC 配置方式:
        - homemanager: 使用 Home Manager 管理配置 (推荐)
        - direct: 直接写入配置文件 (演示用)
        - external: 引用外部配置文件 (演示用)
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
