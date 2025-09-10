{ config, lib, pkgs, ... }:

{
  imports = [
    ./fonts
    ./stylix
  ];

  options.myHome.profiles = {
    enable = lib.mkEnableOption "用户配置档案支持";
  };
}
