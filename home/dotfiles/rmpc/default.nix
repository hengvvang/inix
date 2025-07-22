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
    
    # 主题选择
    theme = lib.mkOption {
      type = lib.types.enum [ "default" "rose-pine" "rose-pine-dawn" "rose-pine-moon" ];
      default = "rose-pine";
      description = ''
        RMPC 主题选择:
        - default: RMPC 默认主题
        - rose-pine: Rose Pine 配色主题 (深色，推荐)
        - rose-pine-dawn: Rose Pine Dawn 配色主题 (浅色)
        - rose-pine-moon: Rose Pine Moon 配色主题 (中等对比度)
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
