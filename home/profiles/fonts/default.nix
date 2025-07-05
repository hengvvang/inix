{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts.enable = lib.mkEnableOption "字体配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.fonts.enable {
    # 直接配置而不设置过深的层次结构
  };

  imports = [
    ./fonts.nix
  ];
}