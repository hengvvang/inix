{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts.enable = lib.mkEnableOption "字体配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.fonts.enable {
    # 字体层默认值：字体配置默认开启
    myHome.profiles.fonts = {
      fonts.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./fonts.nix
  ];
}