{ config, lib, pkgs, ... }:

{
  options.myHome.develop.devenv = {
    enable = lib.mkEnableOption "devenv 项目环境管理";
    
    shell = lib.mkOption {
      type = lib.types.enum [ "bash" "fish" "zsh" ];
      default = "fish";
      description = "默认集成的 shell";
    };
    
    templates = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "是否安装预设的项目模板";
    };
  };

  imports = [
    ./devenv.nix
  ];
}
