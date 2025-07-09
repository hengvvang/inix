{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.bash = {
    enable = lib.mkEnableOption "Bash Shell 配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        配置方式选择:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
        - direct: 直接文件写入方式
        - external: 外部文件引用方式
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
