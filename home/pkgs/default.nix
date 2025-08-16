{ config, lib, pkgs, ... }:

{
  imports = [
    ./user1
    ./user2
  ];

  options.myHome.pkgs = {
    enable = lib.mkEnableOption "系统包管理模块支持";
    user1.enable = lib.mkEnableOption "用户1的自定义包管理支持" // { default = false; };
    user2.enable = lib.mkEnableOption "用户1的自定义包管理支持" // { default = false; };
  };
}
