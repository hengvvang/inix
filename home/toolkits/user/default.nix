{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.user.enable = lib.mkEnableOption "用户工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.user.enable {
    # 直接配置而不设置过深的层次结构
  };

  imports = [
    ./utilities.nix
  ];
}