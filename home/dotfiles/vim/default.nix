{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.vim = {
    enable = lib.mkEnableOption "Vim 编辑器配置";
    
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        Vim 配置方式:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
        - direct: 直接写入 vimrc 文件 (演示用)
        - external: 引用外部 vimrc 文件 (演示用)
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
