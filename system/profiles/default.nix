{ config, lib, pkgs, ... }:

{
  options.mySystem.profiles = {
    enable = lib.mkEnableOption "系统配置支持";
  };

  imports = [
    ./stylix
    ./fonts
  ];
}
