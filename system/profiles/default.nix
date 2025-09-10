{ config, lib, pkgs, ... }:

{
  imports = [
    ./stylix
    ./fonts
  ];

  options.mySystem.profiles = {
    enable = lib.mkEnableOption "系统配置支持";
  };
}
