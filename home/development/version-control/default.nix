{ config, lib, pkgs, ... }:

{
  options.myHome.development.versionControl.enable = lib.mkEnableOption "版本控制工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.development.versionControl.enable {
    # 直接配置而不设置过深的层次结构
  };

  imports = [
    ./git.nix
    ./lazygit.nix
  ];
}