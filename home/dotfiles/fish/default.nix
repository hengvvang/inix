{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.fish = {
    enable = lib.mkEnableOption "Fish Shell 配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        Fish 配置方式:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
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
