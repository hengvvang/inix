{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts.enable = lib.mkEnableOption "字体配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.profiles.fonts.enable {
    # 设置字体配置的默认值
    myHome.profiles.fonts = {
      fonts.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./fonts.nix
  ];
}