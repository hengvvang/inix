{ config, lib, pkgs, ... }:

{
  options.myHome.profiles = {
    enable = lib.mkEnableOption "用户配置档案支持";
  };

  imports = [
    ./fonts
    ./stylix
  ];
}
