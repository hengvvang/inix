{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.zsh = {
    enable = lib.mkEnableOption "Zsh Shell 配置";
    
    # 配置方式选择
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" ];
      default = "homemanager";
      description = ''
        Zsh 配置方式:
        - homemanager: 使用 Home Manager 程序模块 (推荐)
        - direct: 直接写入 zshrc 文件 (演示用)
        - external: 引用外部 zshrc 文件 (演示用)
      '';
    };
  };

  imports = [
    ./homemanager.nix
    ./direct.nix
    ./external.nix
  ];
}
