{ config, lib, pkgs, ... }:

{
  options.myHome.pkgs = {
    enable = lib.mkEnableOption "系统包管理模块支持";
    apps.enable = lib.mkEnableOption "应用程序包管理支持";
    toolkits.enable = lib.mkEnableOption "工具包管理支持";
    workflows.enable = lib.mkEnableOption "工作流包管理支持";
  };

  imports = [
    ./apps.nix
    ./toolkits.nix
    ./workflows.nix
  ];
}
