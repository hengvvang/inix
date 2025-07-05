{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.envVar.enable = lib.mkEnableOption "环境变量配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.envVar.enable {
    # 直接配置而不设置过深的层次结构
  };

  imports = [
    ./environment.nix
  ];
}